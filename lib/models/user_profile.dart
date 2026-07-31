enum ProfileThemeColor { pink, blue }

class UserProfile {
  final String id;
  final String name;
  final String iconUrl;
  final String exchangeCode;
  final ProfileThemeColor themeColor;

  const UserProfile({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.exchangeCode,
    required this.themeColor,
  });
}
