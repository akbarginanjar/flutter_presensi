import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi/models/user_model.dart';
import 'package:presensi/views/home/home_screen.dart';

class AuthController extends GetConnect {
  Future<User> login({required String email, required String password}) async {
    if (password.isNotEmpty && email.isNotEmpty) {
      var body = json.encode({
        "email": email,
        "password": password,
      });

      EasyLoading.show(status: 'loading...');

      final Response conn = await post(
        // 'http://10.0.2.2:8000/api-login-mobile',
        'http://localhost:8000/api-login-mobile',
        body,
        headers: {'Accept': 'application/json'},
      );
      // print(conn.body);
      if (conn.statusCode == 200) {
        EasyLoading.showSuccess('Berhasil');
        GetStorage().write('token', conn.body['token']);
        GetStorage().write('id_user', conn.body['data']['id']);
        GetStorage().write('name', conn.body['data']['name']);
        GetStorage().write('email', conn.body['data']['email']);
        GetStorage().write('type', conn.body['data']['type']);
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
            title: const Text('Login Gagal!'),
            content: const Text('Akun tidak ditemukan!'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(
                  'OKE',
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
            ],
          ),
        );
      }
      // Get.snackbar("Gagal Login", conn.body['message']);
    }

    return User();
  }
}
