import 'package:magic_slides/core/exceptions/api_exception.dart';
import 'package:magic_slides/core/preferences/app_preferences.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/domain/repository/presentation_repository.dart';
import 'package:magic_slides/network/api_service.dart';
import 'package:magic_slides/network/mapper.dart';
import 'package:magic_slides/network/outcome.dart';
import 'package:magic_slides/network/response/presentation_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PresentationRepositoryImpl implements PresentationRepository {
  final ApiService _apiService;
  final AppPreferences _appPreferences;

  PresentationRepositoryImpl({
    required ApiService apiService,
    required AppPreferences appPreferences,
  }) : _apiService = apiService,
       _appPreferences = appPreferences;

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
    final storedAssetId = await _appPreferences.getString(
      assetIdIdentificationKey,
    );

    final Outcome<PresentationResponse> response = await _apiService
        .generatePresentation(
          Mapper.buildPresentationRequest(
            topic: topic,
            extraInfoSource: extraInfoSource ?? '',
            email: email,
            accessId: storedAssetId ?? accessId,
            settings: settings,
          ),
        );

    if (response is Failure) {
      throw ApiException((response as Failure).reason);
    }
    return (response as Success).data;
  }

  @override
  String get assetIdIdentificationKey => 'ASSET_ID_IDENTIFICATION_KEY';

  @override
  Future<void> updateAssetId(String assetId) async {
    await _appPreferences.setString(assetIdIdentificationKey, assetId);
  }
}
