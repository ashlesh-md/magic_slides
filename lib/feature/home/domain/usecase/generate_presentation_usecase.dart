import 'package:magic_slides/core/data/services/file_service.dart';
import 'package:magic_slides/feature/home/domain/model/generated_presentation_model.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/domain/repository/presentation_repository.dart';

class GeneratePresentationUsecase {
  final PresentationRepository _presentationRepository;
  final FileService _fileService;

  GeneratePresentationUsecase({
    required PresentationRepository presentationRepository,
    required FileService fileService,
  }) : _presentationRepository = presentationRepository,
       _fileService = fileService;

  Future<GeneratedPresentationModel> execute({
    required String topic,
    String? extraInfoSource,
    required PresentationSettingsModel settings,
  }) async {
    final responseModel = await _presentationRepository.generatePresentation(
      topic: topic,
      extraInfoSource: extraInfoSource,
      settings: settings,
    );

    final pdfPath = responseModel.data.pdfUrl;
    final pptPath = responseModel.data.url;

    final pdfFile = await _fileService.downloadFile(
      pdfPath,
      'generated_pdf_${DateTime.now().millisecondsSinceEpoch}',
    );
    final pptFile = await _fileService.downloadFile(
      pptPath,
      'generated_ppt_${DateTime.now().millisecondsSinceEpoch}',
    );

    return GeneratedPresentationModel(pdfFile: pdfFile, pptFile: pptFile);
  }
}
