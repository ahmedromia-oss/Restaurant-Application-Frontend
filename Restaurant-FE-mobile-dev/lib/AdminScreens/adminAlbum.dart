// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class adAlbum {
  final String message;
  var user;
  final String AccessToken;

  adAlbum({
    required this.message,
    required this.user,
    required this.AccessToken,
  });

  factory adAlbum.fromJson(Map<String, dynamic> json) {
    return adAlbum(
      message: json['message'],
      user: json['user'],
      AccessToken: json['AccessToken:'],
    );
  }
}
