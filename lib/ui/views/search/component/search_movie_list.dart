import 'package:flutter/material.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';
import 'package:movie_app/ui/views/search/component/search_movie.dart';

class SearchMovieList extends StatelessWidget {
  final List<Result> searchMovieList;
  final int itemsPerRow;
  final double width;
  const SearchMovieList({
    super.key,
    required this.searchMovieList,
    required this.itemsPerRow,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    const int itemsPerRow = 1;
    const double ratio = 3 / 2;
    const double horizontalPadding = 0;
    final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) *
        (searchMovieList.length / itemsPerRow).ceil() *
        (1 / ratio);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: width,
      height: calcHeight,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: searchMovieList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          crossAxisCount: itemsPerRow,
          childAspectRatio: ratio,
        ),
        itemBuilder: (context, index) {
          return SearchMovie(data: searchMovieList[index]);
        },
      ),
    );
  }
}
