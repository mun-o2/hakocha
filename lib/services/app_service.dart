import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  const AppService();

  static const String _kProfileColorKey = 'profile_color';

  Future<void> initialize() async {
    // 今後の初期化処理をここに追加します。保持の初期化は各メソッドで行います。
  }

  Future<String> getProfileColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kProfileColorKey) ?? 'pink';
  }

  Future<void> setProfileColor(String color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kProfileColorKey, color);
  }
}
