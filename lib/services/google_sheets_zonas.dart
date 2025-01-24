import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart'; // Importar el archivo de configuración

class GoogleSheetsService {
  static Future<bool> enviarDatos({
    required String nombre,
    required String email,
    required String mensaje,
    required String firma,
    String? opcion, // Nueva firma en Base64
  }) async {
    try {
      final response = await http.post(
        Uri.parse(scriptZonas.urlScriptZonas),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "nombre": nombre,
          "email": email,
          "mensaje": mensaje,
          "firma": firma, // Enviar firma al servidor
        }),
      );

      print("Código de estado: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");

      final data = jsonDecode(response.body);
      return data['status'] == 'success';
    } catch (e) {
      print("Error al enviar datos: $e");
      return false;
    }
  }

  static Future<List?> obtenerRegistros() async {
    try {
      final response = await http.get(
        Uri.parse(
            scriptZonas.urlScriptZonas), // Usar URL desde la configuración
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print("Error al obtener registros: $e");
      return null;
    }
  }
}
