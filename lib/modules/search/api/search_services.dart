import 'dart:convert';

import 'package:movie_app/api/api_service.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';

class SearchServices extends ApiService {
  Future<MovieResponse> fetchSearchMovie(String query) async {
    final response = await get('/search/movie?query=$query');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return MovieResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to load invoice data');
    }
  }
}
