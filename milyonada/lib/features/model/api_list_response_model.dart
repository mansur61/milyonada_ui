 
class ApiListResponse<T> {
  final bool? success;
  final String? message;
  final List<T>? data;
  final String? statusEnum;
  //final MetaModel? meta;

  ApiListResponse(
      {this.success, this.message, this.data, this.statusEnum,  });

  /// JSON'dan nesne oluşturma
  factory ApiListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
   // MyLog.debug("ApiListResponse fromJson ${json["data"]}");
    final rawData = json['data'] ?? [];

    return ApiListResponse<T>(
        success: json['success'],
        message: json['message'],
        data: rawData is List
            ? rawData.map((item) => fromJsonT(item)).toList()
            : null, // Eğer data list değilse boş liste döner
        statusEnum: json['statusEnum'],
      //  meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null
       );
  }

  /// Nesneyi JSON'a çevirme
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': (data ?? []).map((item) => toJsonT(item)).toList(),
      'statusEnum': statusEnum,
    //  'meta': meta
    };
  }
}
