import 'package:magic_slides/core/exceptions/api_exception.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/domain/repository/presentation_repository.dart';
import 'package:magic_slides/network/api_service.dart';
import 'package:magic_slides/network/mapper.dart';
import 'package:magic_slides/network/outcome.dart';
import 'package:magic_slides/network/response/presentation_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PresentationRepositoryImpl implements PresentationRepository {
  final ApiService _apiService;

  PresentationRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  String get accessId => ""; // TODO : Add accessId here

  @override
  Future<PresentationResponse> generatePresentation({
    required String topic,
    String? extraInfoSource,
    required PresentationSettingsModel settings,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? '';

    final Outcome<PresentationResponse> response = await _apiService
        .generatePresentation(
          Mapper.buildPresentationRequest(
            topic: topic,
            extraInfoSource: extraInfoSource ?? '',
            email: email,
            accessId: accessId,
            settings: settings,
          ),
        );

    if (response is Failure) {
      throw ApiException((response as Failure).reason);
    }
    return (response as Success).data;
  }
}
