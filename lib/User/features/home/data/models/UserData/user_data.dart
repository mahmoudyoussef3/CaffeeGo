class UserDataClass {
  String? uuid;
  String? name;
  String? phoneNumber;
  String? email;
  String? fcmToken;

  UserDataClass({
    required this.uuid,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.fcmToken,
  });

  factory UserDataClass.fromJson(Map<String, dynamic> myUserData) {
    return UserDataClass(
      uuid: myUserData['uuid'],
      fcmToken: myUserData['fcmToken'],
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
      'fcmToken': fcmToken,
    };
  }
}
