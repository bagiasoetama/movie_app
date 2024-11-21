import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/views/home/component/filter_selector.dart';
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

    Widget itemGrid(double width) {
      const int itemsPerRow = 3;
      const double ratio = 2 / 3;
      const double horizontalPadding = 0;
      final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) *
          (statusMovieList.length / itemsPerRow).ceil() *
          (1 / ratio);
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        width: width,
        height: calcHeight,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          itemCount: statusMovieList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            crossAxisCount: itemsPerRow,
            childAspectRatio: ratio,
          ),
          itemBuilder: (context, index) {
            return Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${statusMovieList[index].backdropPath}',
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    }

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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: kcTextSearchBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: kcTextSearchColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.search,
                                color: kcTextSearchColor,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(
                        height: 275.0,
                        width: double.infinity,
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: topMovieList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Stack(
                            children: [
                              Container(
                                width: 175,
                                padding: EdgeInsets.fromLTRB(
                                  index == 0 ? 16 : 16 / 2,
                                  0,
                                  index == topMovieList.length ? 16 : 16 / 2,
                                  0,
                                ),
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: SizedBox(
                                    height: 250,
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500/${topMovieList[index].backdropPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -25,
                                left: 5,
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: kcTextRankingColor,
                                      fontSize: 72,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 25.0,
                                          color: Colors.black,
                                        ),
                                        Shadow(
                                          // bottomLeft
                                          offset: Offset(-0.1, -0.1),
                                          color: kcTextRankingStrokeColor,
                                        ),
                                        Shadow(
                                          // bottomRight
                                          offset: Offset(0.1, -0.1),
                                          color: kcTextRankingStrokeColor,
                                        ),
                                        Shadow(
                                          // topRight
                                          offset: Offset(0.1, 0.1),
                                          color: kcTextRankingStrokeColor,
                                        ),
                                        Shadow(
                                          // topLeft
                                          offset: Offset(-0.1, 0.1),
                                          color: kcTextRankingStrokeColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FilterSelector(viewModel: viewModel),
                      const SizedBox(height: 10),
                      itemGrid(width),
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
