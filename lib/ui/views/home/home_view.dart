import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/views/home/component/filter_selector.dart';
import 'package:movie_app/ui/views/home/component/movies_grid.dart';
import 'package:movie_app/ui/views/home/component/search_field.dart';
import 'package:movie_app/ui/views/home/component/top_movies_list.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_app/ui/common/app_colors.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final topMovieList = viewModel.movieHeaderResponse?.results ?? [];
    final statusMovieList = viewModel.movieStatusResponse?.results ?? [];
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kcColorFilterBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What do you want to watch?',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SearchField(),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      TopMoviesList(topMovieList: topMovieList),
                      const SizedBox(height: 10),
                      FilterSelector(viewModel: viewModel),
                      const SizedBox(height: 10),
                      MoviesGrid(
                        width: width,
                        itemsPerRow: 3,
                        movieList: statusMovieList,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchTopMovie();
    viewModel.fetchMovie();
  }
}
