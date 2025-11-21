import 'dart:convert';
import 'dart:io';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:magic_slides/network/outcome.dart';
import 'package:magic_slides/network/requests/presentation_request.dart';
import 'package:magic_slides/network/response/presentation_response.dart';

class ApiService {
  static const String baseUrl =
      "https://api.magicslides.app/public/api/ppt_from_topic";

  Future<Outcome<PresentationResponse>> generatePresentation(
    PresentationRequest request,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        // final json = await rootBundle.loadString('assets/dummy_response.json');
        // return Success(PresentationResponse.fromJson(jsonDecode(json)));

        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'];

        if (data != null && data['success'] == true) {
          return Success(PresentationResponse.fromJson(jsonData));
        }

        final message = data != null && data['message'] != null
            ? data['message'].toString()
            : "Something went wrong";

        return Failure(message);
      }

      return Failure('Something went wrong');
    } on SocketException {
      return Failure('Check your internet connection');
    } catch (e) {
      return Failure('Something went wrong');
    }
  }
}
