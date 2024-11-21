import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';
import 'logger_service.dart';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final String appKey = dotenv.env['APP_KEY']!;
  final _dialogService = locator<DialogService>();

  Future<http.Response> post(String endpoint, Map<String, String> data) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await retry(
        () => http.post(
          Uri.parse(url),
          body: data,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ).timeout(const Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is HttpException,
        maxAttempts: 1,
      );
      LoggerService.log(
        message: 'POST Request to: $url',
        requestData: data.toString(),
        responseBody: response.body,
        statusCode: response.statusCode.toString(),
      );
      return response;
    } on SocketException {
      await _showConnectionErrorDialog();
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      await _showConnectionErrorDialog();
      throw Exception('Terjadi kesalahan di server.');
    } on TimeoutException {
      LoggerService.log(
        message: 'POST Request to: $url',
        requestData: data.toString(),
        responseBody: '',
        statusCode: '',
      );
      throw Exception('Periksa koneksi Anda. Waktu permintaan habis.');
    } catch (e) {
      LoggerService.log(
        message: 'POST Request to: $url',
        requestData: data.toString(),
        responseBody: '',
        statusCode: '',
      );
      throw Exception('Terjadi kesalahan. Periksa koneksi Anda.');
    }
  }

  Future<http.Response> postWithToken(
      String endpoint, Map<String, String> data, String token) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await retry(
        () => http.post(
          Uri.parse(url),
          body: data,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $appKey',
          },
        ).timeout(const Duration(seconds: 10)),
        retryIf: (e) => e is SocketException || e is HttpException,
        maxAttempts: 1,
      );

      // Logging response
      LoggerService.log(
        message: 'POST Request to: $url',
        requestData: data.toString(),
        responseBody: response.body,
        statusCode: response.statusCode.toString(),
      );

      if (response.statusCode == 400) {
        final responseBody = json.decode(response.body);
        if (responseBody['message'] == 'Login First') {
          // Tampilkan dialog kepada pengguna
          final dialogResponse = await _dialogService.showDialog(
            title: 'Otentikasi Diperlukan',
            description: 'Anda harus login terlebih dahulu untuk melanjutkan.',
            buttonTitle: 'OK',
          );

          // Jika pengguna mengetuk OK, baru lakukan navigasi ke halaman login
          if (dialogResponse!.confirmed) {
            final _navigationService = locator<NavigationService>();
            _navigationService.replaceWith(Routes.startupView);
            throw Exception('Pengguna harus login terlebih dahulu.');
          }
        }
      }

      return response;
    } on SocketException {
      await _showConnectionErrorDialog();
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      await _showConnectionErrorDialog();
      throw Exception('Terjadi kesalahan di server.');
    } catch (e) {
      throw Exception('Terjadi kesalahan. Periksa koneksi Anda.');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await retry(
        () => http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $appKey',
            'Content-Type': 'application/json',
          },
        ).timeout(const Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is HttpException,
        maxAttempts: 1,
      );
      LoggerService.log(
        message: 'GET Request to: $url',
        responseBody: response.body,
        statusCode: response.statusCode.toString(),
      );
      if (response.statusCode == 400) {
        final responseBody = json.decode(response.body);
        if (responseBody['message'] == 'Login First') {
          // Tampilkan dialog kepada pengguna
          final dialogResponse = await _dialogService.showDialog(
            title: 'Otentikasi Diperlukan',
            description: 'Anda harus login terlebih dahulu untuk melanjutkan.',
            buttonTitle: 'OK',
          );

          // Jika pengguna mengetuk OK, baru lakukan navigasi ke halaman login
          if (dialogResponse!.confirmed) {
            final _navigationService = locator<NavigationService>();
            _navigationService.replaceWith(Routes.startupView);
            throw Exception('Pengguna harus login terlebih dahulu.');
          }
        }
      }
      return response;
    } on SocketException {
      await _showConnectionErrorDialog();
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      await _showConnectionErrorDialog();
      throw Exception('Terjadi kesalahan di server.');
    } catch (e) {
      throw Exception('Error in GET request: $e');
    }
  }

  Future<http.Response> getUrlUndicode(String endpoint, String token,
      String employeeName, String employeeId) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await retry(
        () => http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $appKey',
            'Content-Type': 'application/x-www-form-urlencoded',
            'employee_name': employeeName,
            'employee_id': employeeId,
          },
        ).timeout(const Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is HttpException,
        maxAttempts: 1,
      );

      LoggerService.log(
        message: 'GET Request to: $url',
        responseBody: response.body,
        statusCode: response.statusCode.toString(),
      );
      return response;
    } on SocketException {
      await _showConnectionErrorDialog();
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      await _showConnectionErrorDialog();
      throw Exception('Terjadi kesalahan di server.');
    } catch (e) {
      throw Exception('Error in GET request: $e');
    }
  }

  Future<http.StreamedResponse> postWithAuthAndFile(
      String endpoint,
      Map<String, String> fields,
      File? invoiceAttachment,
      File? paymentFile,
      String token) async {
    final url = '$baseUrl$endpoint';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $appKey';
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // Menambahkan file invoiceAttachment jika ada
    if (invoiceAttachment != null && await invoiceAttachment.exists()) {
      request.files.add(
        await http.MultipartFile.fromPath(
            'invoice_attachment', invoiceAttachment.path),
      );
    }
    if (paymentFile != null && await paymentFile.exists()) {
      request.files.add(
        await http.MultipartFile.fromPath('payment_file', paymentFile.path),
      );
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      LoggerService.log(
        message: 'Response Received: $url',
        responseBody: responseBody,
        statusCode: response.statusCode.toString(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request Success: ${response.statusCode}');
      } else {
        print('Request Failed: ${response.statusCode} - $responseBody');
      }

      return response;
    } on SocketException {
      await _showConnectionErrorDialog();
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      await _showConnectionErrorDialog();
      throw Exception('Terjadi kesalahan di server.');
    } catch (e) {
      throw Exception('Error in POST request with file: $e');
    }
  }

  Future<Map<String, dynamic>> addCustomerWithFile(String endpoint,
      Map<String, String> fields, File? imageFile, String token) async {
    final url = '$baseUrl$endpoint';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Tambahkan header Authorization
    request.headers['Authorization'] = 'Bearer $appKey';

    // Menambahkan fields ke dalam request
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // Mengecek apakah imageFile ada, jika ya tambahkan ke request sebagai file
    if (imageFile != null && await imageFile.exists()) {
      print("Menambahkan file gambar: ${imageFile.path}");
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
    } else {
      print("Tidak ada file gambar yang ditambahkan.");
    }

    try {
      // Mengirim request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Logging responsenya
      LoggerService.log(
        message: 'Response from: $url',
        responseBody: responseBody,
        statusCode: response.statusCode.toString(),
      );

      // Memeriksa status kode
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(responseBody);
      } else {
        throw Exception(
            'Gagal menambahkan customer: ${response.statusCode} - $responseBody');
      }
    } catch (e) {
      // Logging jika ada error
      LoggerService.log(
        message: 'Exception occurred: $e',
        responseBody: '',
        statusCode: '',
      );
      throw Exception('Exception occurred: $e');
    }
  }

  // Fungsi untuk menampilkan dialog error koneksi
  Future<void> _showConnectionErrorDialog() async {
    bool retry = false;
    await _dialogService
        .showDialog(
      title: 'Koneksi Terputus',
      description: 'Cek koneksi internet Anda.',
      buttonTitle: 'Oke',
    )
        .then((value) {
      retry = value!.confirmed;
    });

    if (retry) {
      // Jika pengguna memilih "Coba Lagi", proses request akan diulang dari fungsi yang memanggilnya
      print('Retrying API call...');
    }
  }
}
