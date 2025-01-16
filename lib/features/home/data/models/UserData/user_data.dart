class UserDataClass {
  String? uuid;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  UserDataClass({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory UserDataClass.fromJson(Map<String, dynamic> myUserData) {
    return UserDataClass(
      uuid: myUserData['uuid'],
      firstName: myUserData['first_name'],
      lastName: myUserData['last_name'],
      phoneNumber: myUserData['phone_number'],
      email: myUserData['email'],
    );
  }
}
