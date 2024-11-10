class UserSettingsEntity {
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final String status;

  UserSettingsEntity(
      {required this.screenName,
      required this.userName,
      required this.phoneNumber,
      required this.bio,
      required this.status});
}
