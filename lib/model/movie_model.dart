class MovieModel {
  List<Mlist>? mlist;
  String? next;

  MovieModel({this.mlist, this.next});

  MovieModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      mlist = <Mlist>[];
      json['list'].forEach((v) {
        mlist!.add(Mlist.fromJson(v));
      });
    }
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mlist != null) {
      data['list'] = mlist!.map((v) => v.toJson()).toList();
    }
    data['next'] = next;
    return data;
  }
}

class Mlist {
  String? image;
  String? link;
  String? title;

  Mlist({this.image, this.link, this.title});

  Mlist.fromJson(Map<String, dynamic> json) {
    image = "https://masstamilan.dev/${json['image']}";
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['link'] = link;
    data['title'] = title;
    return data;
  }
}
