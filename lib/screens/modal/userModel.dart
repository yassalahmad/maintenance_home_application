
class UserModel {
  String userName;
  String? userEmail,
      userPhoneNumber,
      userProfession,
      userAddress;
  // String userImage;
  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userProfession,
    required this.userAddress,
  });
}