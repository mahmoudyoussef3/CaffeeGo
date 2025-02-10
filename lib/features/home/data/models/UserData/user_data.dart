class UserDataClass {
  String? uuid;
  String? name;
  String? phoneNumber;
  String? email;

  UserDataClass({
    required this.uuid,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  factory UserDataClass.fromJson(Map<String, dynamic> myUserData) {
    return UserDataClass(
      uuid: myUserData['uuid'],
      name: myUserData['displayName'],
      phoneNumber: myUserData['phone_number'],
      email: myUserData['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'displayName': name,
      'phone_number': phoneNumber,
      'email': email,
    };
  }
}
