import 'dart:convert';

class UserModel {
  const UserModel({
    required this.id,
    required this.isVerified,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      isVerified: ['isVerified'] as bool,
    );
  }

  final int id;
  final bool isVerified;

  Map<String, dynamic> toMap() => {
        'id': id,
        'isVerified': isVerified,
      };
  String toJson() => jsonEncode(toMap());


}

// void main() {
//
//   final user= UserModel(id:1,isVerified: false);
//
//   final serverReadableMap = user.toJson();
//
//   final newUser = UserModel.fromJson(serverReadableMap);
//
// }
