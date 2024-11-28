import 'package:flutter/material.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';
import 'package:movie_app/ui/views/home/component/top_movies.dart';

class TopMoviesList extends StatelessWidget {
  final List<Result> topMovieList;
  const TopMoviesList({
    super.key,
    required this.topMovieList,
  });

  @override
  Widget build(BuildContext context) {
    // return Text("HELLOO");
    return Container(
      height: 285.0,
      width: double.infinity,
      // child: Text("HELLOO"),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: topMovieList.length,
        itemBuilder: (BuildContext context, int index) => TopMovies(
          index: index,
          dataLength: topMovieList.length,
          posterPath: topMovieList[index].posterPath!,
        ),
      ),
    );
  }
}
