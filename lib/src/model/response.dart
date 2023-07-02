class Response {
  int? code;
  String? body;

  dynamic content;
  Response({this.code, this.body});
  @override
  String toString() => 'code: $code, body: $body,content: $content';
}
