class MovieSongModel {
  List<Songs>? songs;

  MovieSongModel({this.songs});

  MovieSongModel.fromJson(Map<String, dynamic> json) {
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add(Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Songs {
  String? link;
  String? name;

  Songs({this.link, this.name});

  Songs.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['name'] = name;
    return data;
  }
}
