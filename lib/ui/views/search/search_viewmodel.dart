import 'package:flutter/material.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';
import 'package:movie_app/modules/search/api/search_services.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  final SearchServices _service = SearchServices();
  TextEditingController searchController = TextEditingController();
  MovieResponse? movieSearchResponse;

  String searchQuery = "";

  Future<void> searchMovie(String query) async {
    setBusy(true);
    try {
      movieSearchResponse = await _service.fetchSearchMovie(searchQuery);
      notifyListeners();
    } catch (e) {
      print('Error fetching top movies: $e');
    } finally {
      setBusy(false);
    }
  }
}
