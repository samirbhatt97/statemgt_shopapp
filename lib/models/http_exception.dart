class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    // TO-DO: implement toString
    //return super.toString();
    return message;
  }
}
