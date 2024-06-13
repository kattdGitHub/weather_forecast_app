class ResponseWrapper<T> {
  final T? data;
  final String? error;

  ResponseWrapper({this.data, this.error});

  bool get isSuccess => data != null && error == null;
}
