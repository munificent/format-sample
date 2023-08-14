 

/// id : 0
/// thumbnail : "string"
/// colorCode : "string"
/// colorCode2 : "string"
/// catName : "string"
/// display : 0

class PublishEventCategory {
  PublishEventCategory({
    this.id,
    this.thumbnail,
    this.colorCode,
    this.colorCode2,
    this.catName,
    this.display,
  });

  PublishEventCategory.empty() {
    id = 0;
  }

  PublishEventCategory.fromJson(dynamic json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    colorCode = json['colorCode'];
    colorCode2 = json['colorCode2'];
    catName = json['catName'];
    display = json['display'];
  }
  int? id;
  String? thumbnail;
  String? colorCode;
  String? colorCode2;
  String? catName;
  int? display;
  bool select = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['thumbnail'] = thumbnail;
    map['colorCode'] = colorCode;
    map['colorCode2'] = colorCode2;
    map['catName'] = catName;
    map['display'] = display;
    return map;
  }
}
