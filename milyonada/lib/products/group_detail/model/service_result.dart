class ServiceResult<T> {
  final bool success;
  final String? message;
  final T? data;
  final String? statusEnum;

  ServiceResult({
    required this.success,
    this.message,
    this.data,
    this.statusEnum,
  });

  factory ServiceResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ServiceResult<T>(
      success: json['success'] ?? false,
      message: json['message'],
      statusEnum: json['statusEnum'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
