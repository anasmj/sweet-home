//Current App User model
class AppUser {
  String? userId;
  String? userEmail;
  String? userName;
  AppUser({this.userId, this.userEmail, this.userName});

  //returns a map
  static Map<String, dynamic> toJson() => {};

  //convert to AppUser object
  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
        userId: json['id'],
        userName: json['userName'],
        userEmail: json['userEmail'],
      );
}
