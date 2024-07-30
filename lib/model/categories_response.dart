
class CategoriesResponse {
    String? success;
    List<Message>? message;

    CategoriesResponse({
        this.success,
        this.message,
    });

    factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        success: json["success"],
        message: json["message"] == null ? [] : List<Message>.from(json["message"]!.map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class Message {
    int? id;
    String? name;
    String? description;
    int? price;
    DateTime? createdAt;
    DateTime? updatedAt;

    Message({
        this.id,
        this.name,
        this.description,
        this.price,
        this.createdAt,
        this.updatedAt,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
