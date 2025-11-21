import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/network/response/presentation_response.dart';

///
/// Repository that deals with the slide generation
/// 
abstract class PresentationRepository {
  Future<PresentationResponse> generatePresentation({
    required String topic,
    String? extraInfoSource,
    required PresentationSettingsModel settings,
  });
  String get accessId;
  String get assetIdIdentificationKey;
  Future<void> updateAssetId(String assetId);
}
