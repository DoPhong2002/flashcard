class Category {
  Category({
    this.urlPicture,
    this.name,
    this.id,
    this.flashcard,
  });

  Category.fromJson(dynamic json) {
    urlPicture = json['urlPicture'];
    name = json['name'];
    id = json['id'];
    if (json['jsonn'] != null) {
      flashcard = [];
      json['jsonn'].forEach((v) {
        flashcard?.add(Flashcard.fromJson(v));
      });
    }
  }

  String? urlPicture;
  String? name;
  String? id;
  List<Flashcard>? flashcard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['urlPicture'] = urlPicture;
    map['name'] = name;
    map['id'] = id;
    if (flashcard != null) {
      map['jsonn'] = flashcard?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Flashcard {
  Flashcard({
    this.urlPicture,
    this.name,
    this.isClick,
    this.audio,
    this.id,
    this.phongId,
  });

  Flashcard.fromJson(dynamic json) {
    urlPicture = json['urlPicture'];
    name = json['name'];
    isClick = json['isClick'];
    audio = json['audio'];
    id = json['id'];
    phongId = json['phongId'];
  }

  String? urlPicture;
  String? name;
  bool? isClick;
  String? audio;
  String? id;
  String? phongId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['urlPicture'] = urlPicture;
    map['name'] = name;
    map['isClick'] = isClick;
    map['audio'] = audio;
    map['id'] = id;
    map['phongId'] = phongId;
    return map;
  }
}
