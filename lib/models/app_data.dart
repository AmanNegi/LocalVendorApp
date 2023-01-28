class AppData {
  String userId;
  String name;
  String email;
  bool isLoggedIn;
  bool isFirstTime;

  AppData({
    required this.userId,
    required this.name,
    required this.isLoggedIn,
    required this.isFirstTime,
    required this.email,
  });

  factory AppData.fromJSON(Map data) => AppData(
      userId: data['userId'] ?? "",
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      isLoggedIn: data['isLoggedIn'] ?? false,
      isFirstTime: data['isFirstTime'] ?? true);

  factory AppData.empty() => AppData(
        name: '',
        isLoggedIn: false,
        isFirstTime: true,
        email: '',
        userId: '',
      );

  toJson() => {
        'name': name,
        'isLoggedIn': isLoggedIn,
        'isFirstTime': isFirstTime,
        'email': email,
        'userId': userId,
      };
}
