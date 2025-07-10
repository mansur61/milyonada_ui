 

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? statusEnum;
 // final MetaModel? meta;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.statusEnum,
   // this.meta,
  });

  /// JSON'dan nesne oluşturma
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
   // MyLog.debug("ApiResponse fromJson $json");

    final rawData = json['data'];

    T? parsedData;
    if (rawData is List) {
      parsedData = List<T>.from(rawData.map((item) => fromJsonT(item))) as T;
    } else if (rawData is Map<String, dynamic> || rawData != null) {
      parsedData = fromJsonT(rawData);
    }

    return ApiResponse<T>(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: parsedData,
        statusEnum: json['statusEnum']?.toString(),
      //  meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null
       );
  }

  /// Nesneyi JSON'a çevirme
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    final T? rawData = data;
    dynamic encodedData;

    if (rawData is List) {
      encodedData = rawData.map((item) => toJsonT(item)).toList();
    } else if (rawData != null) {
      encodedData = toJsonT(rawData);
    }

    return {
      'success': success,
      'message': message,
      'data': encodedData,
      'statusEnum': statusEnum,
      //'meta': meta
    };
  }
}
