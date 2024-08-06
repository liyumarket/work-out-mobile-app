class VideoByCategory {
  String? success;
  List<SingleVideo>? message;

  VideoByCategory({
    this.success,
    this.message,
  });

  factory VideoByCategory.fromJson(Map<String, dynamic> json) =>
      VideoByCategory(
        success: json["success"],
        message: json["message"] == null
            ? []
            : List<SingleVideo>.from(
                json["message"]!.map((x) => SingleVideo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x?.toJson())),
      };
}

class SingleVideo {
  int? id;
  String? title;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? categoryId;
  int? uploadedBy;

  SingleVideo({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.uploadedBy,
  });

  factory SingleVideo.fromJson(Map<String, dynamic> json) => SingleVideo(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        categoryId: json["categoryId"],
        uploadedBy: json["uploadedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "categoryId": categoryId,
        "uploadedBy": uploadedBy,
      };
}
