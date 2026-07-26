enum AppTab { home, exchange, profile }

extension AppTabExtension on AppTab {
  String get label {
    switch (this) {
      case AppTab.home:
        return 'トップ';
      case AppTab.exchange:
        return '交換';
      case AppTab.profile:
        return 'プロフィール帳';
    }
  }
}
