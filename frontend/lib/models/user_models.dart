class BaseUser {
  final String username;

  BaseUser({required this.username});

  factory BaseUser.fromJson(Map<String, dynamic> json) =>
      BaseUser(username: json['username'] as String);
}

class UserCredentials extends BaseUser {
  final String password;

  UserCredentials({required super.username, required this.password});

  Map<String, dynamic> toJson() => {'username': username, 'password': password};

  
}

class AuthenticatedUser extends BaseUser {
  final String token;

  AuthenticatedUser({required super.username, required this.token});

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => AuthenticatedUser(
    username: json['username'] as String,
    token: json['token'] as String,
  );
  
}
