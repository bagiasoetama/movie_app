import 'package:movie_app/modules/home/api/home_services.dart';
import 'package:movie_app/modules/home/dto/movie_response.dart';
import 'package:movie_app/ui/views/home/component/filter_chips.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final HomeServices _service = HomeServices();
  MovieResponse? movieHeaderResponse;
  MovieResponse? movieStatusResponse;
  MovieFilter selectedFilter = MovieFilter.nowPlaying;
  bool isLoadingMore = false;

  void setFilter(MovieFilter filter) {
    selectedFilter = filter;
    fetchMovie();
    notifyListeners();
  }

  Future<void> fetchTopMovie() async {
    setBusy(true);
    try {
      movieHeaderResponse = await _service.fetchTopMovie();
      notifyListeners();
    } catch (e) {
      print('Error fetching top movies: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchMovie() async {
    setBusy(true);
    String url;
    url = formatStatus(selectedFilter);
    try {
      movieStatusResponse = await _service.fetchByUrl(url);
      notifyListeners();
    } catch (e) {
      print('Error fetching movies by url: $e');
    } finally {
      setBusy(false);
    }
  }

  String formatStatus(MovieFilter filter) {
    switch (filter) {
      case MovieFilter.nowPlaying:
        return 'now_playing';
      case MovieFilter.popular:
        return 'popular';
      case MovieFilter.topRated:
        return 'top_rated';
      case MovieFilter.upComing:
        return 'upcoming';
      default:
        return "";
    }
  }
}
