import 'package:flutter/material.dart';
import 'package:movie_app/ui/common/app_colors.dart';
import 'package:movie_app/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

class MainView extends StackedView<MainViewModel> {
  final int initialIndex;
  const MainView({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MainViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: PageView(
        controller: viewModel.pageController,
        onPageChanged: (index) => viewModel.setIndex(index),
        children: const [
          HomeView(),
          HomeView(),
          HomeView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: kcPrimaryColor, width: 1.0),
          ),
        ), // width: 3.0 --> you can set a custom width too! ), ), ),
        child: BottomNavigationBar(
          backgroundColor: kcColorFilterBackground,
          currentIndex: viewModel.currentIndex,
          onTap: (index) => viewModel.onBottomNavTapped(index),
          selectedItemColor: kcPrimaryColor,
          unselectedItemColor: kcTextColorPlaceholder,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              label: 'Watch List',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(MainViewModel viewModel) {
    viewModel.initializePage(initialIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.pageController.jumpToPage(initialIndex);
    });
  }

  @override
  MainViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MainViewModel();
}
