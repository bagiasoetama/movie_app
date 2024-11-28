import 'package:flutter/material.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';
import 'package:movie_app/ui/views/home/component/movie_card.dart';

class MoviesGrid extends StatelessWidget {
  final double width;
  final List<Result> movieList;
  final int itemsPerRow;
  const MoviesGrid({
    super.key,
    required this.width,
    required this.itemsPerRow,
    required this.movieList,
  });

  @override
  Widget build(BuildContext context) {
    const int itemsPerRow = 3;
    const double ratio = 2 / 3;
    const double horizontalPadding = 0;
    final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) *
        (movieList.length / itemsPerRow).ceil() *
        (1 / ratio);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: width,
      height: calcHeight,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: movieList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          crossAxisCount: itemsPerRow,
          childAspectRatio: ratio,
        ),
        itemBuilder: (context, index) {
          return MovieCard(posterPath: movieList[index].posterPath!);
        },
      ),
    );
  }
}
