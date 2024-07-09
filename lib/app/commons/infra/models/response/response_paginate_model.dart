class ResponsePaginateModel<T> {
  int currentPage;
  List<T> data;
  int lastPage;
  int total;
  int perPage;
  String? prevPageUrl;
  String? nextPageUrl;
  String firstPageUrl;
  String lastPageUrl;

  ResponsePaginateModel({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.total,
    required this.perPage,
    this.prevPageUrl,
    this.nextPageUrl,
    required this.firstPageUrl,
    required this.lastPageUrl,
  });

  ResponsePaginateModel.fromJson(Map<String, dynamic> json,
      {required T Function(Map<String, dynamic> map) parser})
      : currentPage = json['current_page'],
        data = (json['data'] as List).map((e) => parser(e)).toList(),
        lastPage = json['last_page'],
        total = json['total'],
        perPage = json['per_page'],
        prevPageUrl = json['prev_page_url'],
        nextPageUrl = json['next_page_url'],
        firstPageUrl = json['first_page_url'],
        lastPageUrl = json['last_page_url'];
}
