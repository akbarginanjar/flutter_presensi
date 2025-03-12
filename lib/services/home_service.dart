import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi/views/home/home_screen.dart';

class HomeService extends GetConnect {
  Future<Response> absen(
      {required String latitude, required String longitude}) async {
    var body = FormData({
      "user_login": GetStorage().read('id_user'),
      "latitude": latitude,
      "longitude": longitude,
    });

    // EasyLoading.show(status: 'loading...');

    final Response conn = await post(
      // 'http://10.0.2.2:8000/api-act-absensi',
      'http://localhost:8000/api-act-absensi',
      body,
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${GetStorage().read('token')}',
        // 'Content-Type': 'application/json',
      },
    );
    // print(conn.body);
    if (conn.statusCode == 200) {
      EasyLoading.showSuccess('Absen Berhasil');
      Get.offAll(
        const HomeScreen(),
        transition: Transition.rightToLeft,
      );
    } else {
      EasyLoading.dismiss();
      Get.dialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.2),
        AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text('Absen Gagal!'),
          content: Text('${conn.body['message']}'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Oke',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      );
    }

    return const Response();
  }
}
