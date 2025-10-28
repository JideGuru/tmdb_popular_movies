class NetworkRequestError {
  final String message;
  final int statusCode;

  const NetworkRequestError({this.message = '', this.statusCode = 0});
}
