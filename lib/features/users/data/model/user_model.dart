import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
    super.gender,
    super.name,
    super.location,
    super.email,
    super.dob,
    super.registered,
    super.phone,
    super.cell,
    super.pictures,
    super.nat,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['gender'] ?? '',
      Name.fromJson(json['name'] ?? {}),
      Location.fromJson(json['location'] ?? {}),
      json['email'] ?? '',
      Dob.fromJson(json['dob'] ?? {}),
      Registered.fromJson(json['registered'] ?? {}),
      json['phone'] ?? '',
      json['cell'] ?? '',
      Pictures.fromJson(json['picture'] ?? {}),
      json['nat'] ?? '',
    );
  }
}
