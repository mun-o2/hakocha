import 'package:flutter/foundation.dart';
import 'package:hakocha/models/app_tab.dart';

class AppNavigationProvider extends ChangeNotifier {
  AppTab _selectedTab = AppTab.home;

  AppTab get selectedTab => _selectedTab;

  void selectTab(AppTab tab) {
    if (_selectedTab == tab) {
      return;
    }

    _selectedTab = tab;
    notifyListeners();
  }
}
