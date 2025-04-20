import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/models/pengajuan_cuti_model.dart';
import 'package:presensi/services/pengajuan_cuti_service.dart';

class PengajuanCutiController extends GetxController {
  RxList<PengajuanCuti> listPengajuanCuti = <PengajuanCuti>[].obs;
  RxBool isLoadingPengajuanCuti = false.obs;

  @override
  void onInit() {
    loadPengajuanCuti();
    super.onInit();
  }

  setLoadingPengajuanCuti() {
    isLoadingPengajuanCuti.value = !isLoadingPengajuanCuti.value;
  }

  Future<void> loadPengajuanCuti() async {
    setLoadingPengajuanCuti();
    final res = await PengajuanCutiService().getPengajuanCuti();
    listPengajuanCuti.value = res;
    setLoadingPengajuanCuti();
  }

  //FORM CREATE
  var tanggalCuti = Rxn<DateTime>();
  var tanggalSelesaiCuti = Rxn<DateTime>();

  Future<void> pilihTanggalCuti() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      tanggalCuti.value = picked;
    }
  }

  Future<void> pilihTanggalSelesai() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: tanggalCuti.value ?? DateTime.now(),
      firstDate: tanggalCuti.value ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      tanggalSelesaiCuti.value = picked;
    }
  }
}
