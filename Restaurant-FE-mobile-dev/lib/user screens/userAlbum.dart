// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class Album {
  final String message;
  var user;
  final String AccessToken;

  Album({
    required this.message,
    required this.user,
    required this.AccessToken,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      message: json['message'],
      user: json['user'],
      AccessToken: json['AccessToken:'],
    );
  }
}
