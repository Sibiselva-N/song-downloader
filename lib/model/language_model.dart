class LanguageModel {
  List<Language>? language;

  LanguageModel({this.language});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Language {
  String? language;
  String? url;

  Language({this.language, this.url});

  Language.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['url'] = url;
    return data;
  }
}
