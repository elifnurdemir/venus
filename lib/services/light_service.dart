import 'dart:convert';
import 'package:http/http.dart' as http;

class LightService {
  static const String baseUrl = 'http://109.228.228.154:5000';

  static Future<bool> getPinStatus() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pin-status'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 1; // true = açık
      } else {
        throw Exception('Durum alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Işık durumu alınırken hata: $e');
    }
  }

  static Future<bool> togglePin() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/toggle-pin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pin': 18}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      } else {
        throw Exception('Pin değiştirme başarısız: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Pin değiştirilirken hata: $e');
    }
  }
}
