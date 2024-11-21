import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setIndexToSearch() {
    _currentIndex = 1;
    notifyListeners();
  }

  void initializePage(int initialIndex) {
    _currentIndex = initialIndex;
    notifyListeners();
  }

  void onBottomNavTapped(int index) {
    pageController.jumpToPage(index);
  }
}
