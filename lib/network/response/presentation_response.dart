class PresentationResponse {
  final String status;
  final String message;
  final PresentationData data;

  PresentationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PresentationResponse.fromJson(Map<String, dynamic> json) {
    return PresentationResponse(
      status: json['status'],
      message: json['message'],
      data: PresentationData.fromJson(json['data']),
    );
  }
}

class PresentationData {
  final String url;
  final PresentationJson json;
  final PresentationJson originalJson;
  final String pptId;
  final String userMessage;
  final int openAICallTime;
  final int tokenUsed;
  final String pdfUrl;
  final String model;
  final String customStartGenerationTime;
  final bool success;

  PresentationData({
    required this.url,
    required this.json,
    required this.originalJson,
    required this.pptId,
    required this.userMessage,
    required this.openAICallTime,
    required this.tokenUsed,
    required this.pdfUrl,
    required this.model,
    required this.customStartGenerationTime,
    required this.success,
  });

  factory PresentationData.fromJson(Map<String, dynamic> json) {
    return PresentationData(
      url: json['url'],
      json: PresentationJson.fromJson(json['json']),
      originalJson: PresentationJson.fromJson(json['original_json']),
      pptId: json['pptId'],
      userMessage: json['UserMessage'],
      openAICallTime: json['openAICallTime'],
      tokenUsed: json['tokenUsed'],
      pdfUrl: json['pdfUrl'],
      model: json['model'],
      customStartGenerationTime: json['customStartGenerationTime'],
      success: json['success'],
    );
  }
}

class PresentationJson {
  final String presentationTitle;
  final String presentationSubtitle;
  final String imageSearch;
  final List<SlideModel> slides;

  PresentationJson({
    required this.presentationTitle,
    required this.presentationSubtitle,
    required this.imageSearch,
    required this.slides,
  });

  factory PresentationJson.fromJson(Map<String, dynamic> json) {
    return PresentationJson(
      presentationTitle: json['presentationTitle'],
      presentationSubtitle: json['presentationSubtitle'],
      imageSearch: json['imageSearch'],
      slides: (json['slides'] as List)
          .map((e) => SlideModel.fromJson(e))
          .toList(),
    );
  }
}

class SlideModel {
  final String title;
  final String subtitle;
  final String imageSearch;
  final List<SlideContent> content;

  SlideModel({
    required this.title,
    required this.subtitle,
    required this.imageSearch,
    required this.content,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) {
    return SlideModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imageSearch: json['imageSearch'],
      content: (json['content'] as List)
          .map((e) => SlideContent.fromJson(e))
          .toList(),
    );
  }
}

class SlideContent {
  final String title;
  final String description;

  SlideContent({required this.title, required this.description});

  factory SlideContent.fromJson(Map<String, dynamic> json) {
    return SlideContent(title: json['title'], description: json['description']);
  }
}
