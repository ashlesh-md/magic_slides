import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
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
        final json = await rootBundle.loadString('assets/dummy_response.json');
        return Success(
          // PresentationResponse.fromJson(jsonDecode(response.body)),
          PresentationResponse.fromJson(jsonDecode(json))
        );
      } else {
        log(response.body);
        return Failure('Something went wrong');
      }
    } on SocketException catch (_) {
      return Failure('Check your internet connection');
    } catch (_) {
      return Failure('Something went wrong');
    }
  }
}
