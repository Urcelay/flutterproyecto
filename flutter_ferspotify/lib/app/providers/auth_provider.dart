import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constans.dart';
import '../models/auth_response_model.dart';
import '../models/logout_response_model.dart';

/// Proveedor de autenticación.
/// Aquí se realizan las peticiones HTTP relacionadas con login, register y logout.
/// En este caso implementamos únicamente el método 'login'.
class AuthProvider {
  /// Método para iniciar sesión.
  /// Envía el [email] y [password] al backend y devuelve un [AuthResponseModel].
static Future<AuthResponseModel?> login(String email, String password) async {
    final url = Uri.parse('$BASE_URL/login');
    print("🔵 [AuthProvider] Intentando login en: $url");
    print("🟦 [AuthProvider] Body enviado: {email: $email, password: $password}");

    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      print("🟡 [AuthProvider] Código de respuesta: ${response.statusCode}");
      print("🟡 [AuthProvider] Body de respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("🟢 [AuthProvider] Login exitoso, parseando datos...");
        return AuthResponseModel.fromJson(data);
      } else {
        print("🔴 [AuthProvider] Error en login: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 [AuthProvider] Excepción capturada en login: $e");
      return null;
    }
  }
/// Método para registrar un nuevo usuario.
/// Envía [name], [email] y [password] al backend.
/// Devuelve un [AuthResponseModel] si el registro es exitoso.

static Future<AuthResponseModel?> register(
  String name,
  String email,
  String password,
) async {
  final url = Uri.parse('$BASE_URL/register');
  print("🔵 [AuthProvider] Intentando registro en: $url");
  print("🟦 [AuthProvider] Body enviado: {name: $name, email: $email, password: $password}");

  try {
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    print("🟡 [AuthProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [AuthProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [AuthProvider] Registro exitoso, parseando datos...");
      return AuthResponseModel.fromJson(data);
    } else {
      print("🔴 [AuthProvider] Error en registro: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [AuthProvider] Excepción capturada en registro: $e");
    return null;
  }
}


/// Método para cerrar sesión (revocar token).
/// Requiere que se envíe el [token] en los headers.
static Future<LogoutResponseModel?> logout(String token) async {
  final url = Uri.parse('$BASE_URL/logout');
  print("🔵 [AuthProvider] Intentando logout en: $url");
  print("🟦 [AuthProvider] Token enviado: Bearer $token");

  try {
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🟡 [AuthProvider] Código de respuesta: ${response.statusCode}");
    print("🟡 [AuthProvider] Body de respuesta: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("🟢 [AuthProvider] Logout exitoso, parseando datos...");
      return LogoutResponseModel.fromJson(data);
    } else {
      print("🔴 [AuthProvider] Error en logout: ${response.body}");
      return null;
    }
  } catch (e) {
    print("🚨 [AuthProvider] Excepción capturada en logout: $e");
    return null;
  }
}
}



