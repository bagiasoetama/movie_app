import 'package:flutter/material.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';
import 'package:movie_app/ui/views/search/component/search_movie_detail.dart';

class SearchMovie extends StatelessWidget {
  final Result data;
  const SearchMovie({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SizedBox(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${data.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SearchMovieDetail(
              title: data.title!,
              voteAverage: data.voteAverage!.toString(),
              releaseDate: data.releaseDate!.year.toString(),
              popularity: data.popularity!.toString(),
              overview: data.overview!,
            ),
          ),
        ],
      ),
    );
  }
}
