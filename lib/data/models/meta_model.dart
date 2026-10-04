class MetaModel {
  final int currentPage;
  final int lastPage;
  final String path;
  final int perPage;
  final int total;

  MetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'total': total,
    };
  }
}

class PaginationModel {
  final int currentPage;
  // final int lastPage;
  // final String path;
  // final int perPage;
  // final int total;
  final bool has_next_page;

  PaginationModel({
    required this.currentPage,
    // required this.lastPage,
    // required this.path,
    // required this.perPage,
    // required this.total,
    required this.has_next_page,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
        currentPage: json['current_page'],
        // lastPage: json['last_page'],
        // path: json['path'],
        // perPage: json['per_page'],
        // total: json['total'],
        has_next_page: json['has_next_page']);
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      // 'last_page': lastPage,
      // 'path': path,
      // 'per_page': perPage,
      // 'total': total,
      'has_next_page': has_next_page
    };
  }
}
