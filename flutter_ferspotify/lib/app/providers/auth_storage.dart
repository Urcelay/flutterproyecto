import 'package:shared_preferences/shared_preferences.dart';

/// Clase para manejar almacenamiento local de autenticación.
/// Guarda y obtiene token + user_id usando SharedPreferences.
class AuthStorage {
  static const String _tokenKey = "auth_token";
  static const String _userIdKey = "user_id";

  /// Guardar datos de autenticación
  static Future<void> saveAuthData({
    required String token,
    required int userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_userIdKey, userId);
    print("💾 [AuthStorage] Datos guardados: token=$token, userId=$userId");
  }

  /// Obtener token almacenado
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Obtener userId almacenado
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  /// Borrar datos de autenticación (por ejemplo, en logout)
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    print("🧹 [AuthStorage] Datos de autenticación borrados");
  }
}
