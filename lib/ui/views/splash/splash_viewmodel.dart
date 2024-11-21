import 'package:movie_app/app/app.locator.dart';
import 'package:movie_app/app/app.router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  String appVersion = 'Unknown Version';
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    await _getAppVersion();
    await Future.delayed(const Duration(seconds: 3));
    await _navigationService.replaceWith(Routes.mainView);
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    print(
        'App version: ${packageInfo.version}, Build number: ${packageInfo.buildNumber}');
    appVersion = 'Version: ${packageInfo.version}+${packageInfo.buildNumber}';
    notifyListeners();
  }
}
