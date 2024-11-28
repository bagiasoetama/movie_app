import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  const MovieCard({
    super.key,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Image.network(
        'https://image.tmdb.org/t/p/w500/$posterPath',
        fit: BoxFit.cover,
      ),
    );
  }
}
