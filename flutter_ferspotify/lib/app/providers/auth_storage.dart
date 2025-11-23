import 'package:shared_preferences/shared_preferences.dart';

/// Clase para manejar el almacenamiento local de autenticación
/// usando SharedPreferences.
/// Permite guardar, obtener y limpiar el token y el ID de usuario.
class AuthStorage {
  static const String _keyToken = "auth_token";
  static const String _keyUserId = "auth_user_id";

  /// Guardar token y userId en almacenamiento local.
  static Future<void> saveAuthData(String token, int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyToken, token);
      await prefs.setInt(_keyUserId, userId);
      print("🟢 [AuthStorage] Datos de auth guardados (token y userId).");
    } catch (e) {
      print("🚨 [AuthStorage] Error al guardar datos de auth: $e");
    }
  }

  /// Obtener el token guardado.
  /// Retorna `null` si no existe.
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_keyToken);
      print("🟡 [AuthStorage] Token obtenido: $token");
      return token;
    } catch (e) {
      print("🚨 [AuthStorage] Error al obtener token: $e");
      return null;
    }
  }

  /// Obtener el ID de usuario guardado.
  /// Retorna `null` si no existe.
  static Future<int?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_keyUserId);
      print("🟡 [AuthStorage] UserId obtenido: $userId");
      return userId;
    } catch (e) {
      print("🚨 [AuthStorage] Error al obtener userId: $e");
      return null;
    }
  }

  /// Limpiar token y userId (logout).
  static Future<void> clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyToken);
      await prefs.remove(_keyUserId);
      print("🧹 [AuthStorage] Datos de auth limpiados.");
    } catch (e) {
      print("🚨 [AuthStorage] Error al limpiar datos de auth: $e");
    }
  }
}
