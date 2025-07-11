// models/basvuru_dto.dart
class BasvuruDTO {
  final String adSoyad;
  final String telefon;
  final String adres;
  final String tcNo;
  final String basvuruDurumu;
  final String? profilResmiUrl;

  BasvuruDTO({
    required this.adSoyad,
    required this.telefon,
    required this.adres,
    required this.tcNo,
    required this.basvuruDurumu,
    this.profilResmiUrl,
  });
}
