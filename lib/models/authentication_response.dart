class AuthenticationResponse {
  final String accessToken;
  final String refreshToken;

  AuthenticationResponse(
      {required this.accessToken, required this.refreshToken});
}
