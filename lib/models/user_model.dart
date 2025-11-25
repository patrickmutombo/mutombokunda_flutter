class UserModel {
  final String uid;
  final String email;
  final String? phone;

  UserModel({
    required this.uid,
    required this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "phone": phone,
    };
  }
}
