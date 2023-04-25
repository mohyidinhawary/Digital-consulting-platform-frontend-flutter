class AppResponse<T> {
  bool success;
  int statusCode;
  T? data;
  String? errorMessage;

  AppResponse(
      {required this.success,
      required this.statusCode,
      this.data,
      this.errorMessage});
}
