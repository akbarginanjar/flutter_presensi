import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi/models/pengajuan_cuti_model.dart';
import 'package:presensi/views/main_screen/screen.dart';

class PengajuanCutiService extends GetConnect {
  Future<List<PengajuanCuti>> getPengajuanCuti() async {
    final conn = await get(
      // 'http://10.0.2.2:8000/api-pengajuan-cuti/${GetStorage().read('id_user')}',
      'http://localhost:8000/api-pengajuan-cuti/${GetStorage().read('id_user')}',
    );
    print('tes ${conn.statusCode}');
    // print(conn.body);
    if (!conn.hasError) {
      final List result = conn.body['data'];
      return result.map((e) => PengajuanCuti.fromJson(e)).toList();
    }
    return [];
  }

  Future<PengajuanCuti> createPengajuanCuti({
    required int idUser,
    required String tanggalCuti,
    required String tanggalCutiSelesai,
    required String alasanCuti,
  }) async {
    if (tanggalCuti != 'null' &&
        tanggalCutiSelesai != 'null' &&
        alasanCuti != '') {
      var body = json.encode({
        "user_id": idUser,
        "tanggal_cuti": tanggalCuti,
        "tanggal_cuti_selesai": tanggalCutiSelesai,
        "alasan_cuti": alasanCuti,
      });

      EasyLoading.show(status: 'loading...');

      final Response conn = await post(
        // 'http://10.0.2.2:8000/api-act-pengajuan-cuti',
        'http://localhost:8000/api-act-pengajuan-cuti',
        body,
        headers: {'Accept': 'application/json'},
      );
      print(conn.body);
      if (conn.statusCode == 200) {
        EasyLoading.showSuccess('Berhasil Pengajuan Cuti');
        Get.offAll(
          const MainScreen(),
        );
      } else {
        EasyLoading.dismiss();
        Get.dialog(
          barrierDismissible: false,
          // ignore: deprecated_member_use
          barrierColor: Colors.black.withOpacity(0.2),
          AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Gagal!'),
            content: Text('${conn.body['message']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
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
    } else {
      EasyLoading.showError('Lengkapi data');
    }
    return PengajuanCuti();
  }
}
