

class UserResponse {
    String? success;
    Message? message;

    UserResponse({
        this.success,
        this.message,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message?.toJson(),
    };
}

class Message {
    String? token;

    Message({
        this.token,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
