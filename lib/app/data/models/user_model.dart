class UserModel {
  final String id;
  final String userName;
  final String email;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? json['uid']).toString(),
      userName: json['userName'].toString(),
      email: json['email'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
    };
  }
}
