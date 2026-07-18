import 'package:get/get.dart';

enum NavTab {
  home,
  onboarding,
}

class NavigationController extends GetxController {
  /// widget rebuild id for bottom navigation bar
  static const navBarUiKey = "nav_bar";
  int currentIndex = 0;
  bool isNavVisible = true;
  DateTime? lastBackPressTime;
  List<NavTab> availableTabs = [];

  @override
  void onInit() {
    super.onInit();
    evaluateTabs();
  }

  void evaluateTabs() {
    availableTabs = [NavTab.home, NavTab.onboarding];
    if (currentIndex >= availableTabs.length) {
      currentIndex = 0;
    }
    update([navBarUiKey]);
  }

  void changePage(int index) {
    if (index < 0 || index >= availableTabs.length) return;
    currentIndex = index;
    update([navBarUiKey]);
  }

  void setNavVisibility(bool visible) {
    isNavVisible = visible;
    update([navBarUiKey]);
  }
}
