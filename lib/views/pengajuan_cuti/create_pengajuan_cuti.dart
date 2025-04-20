import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:presensi/controllers/pengajuan_cuti_controller.dart';
import 'package:presensi/services/pengajuan_cuti_service.dart';

class CreatePengajuanCuti extends StatelessWidget {
  CreatePengajuanCuti({super.key});
  final PengajuanCutiController controller = Get.put(PengajuanCutiController());

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController alasanCuti = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pengajuan Cuti'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black38,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Tanggal Cuti
            const Text('Tanggal Cuti *',
                style: TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: controller.pilihTanggalCuti,
              child: Obx(() => Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.tanggalCuti.value != null
                          ? formatDate(controller.tanggalCuti.value)
                          : 'Pilih Tanggal',
                      style: TextStyle(
                        color: controller.tanggalCuti.value != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  )),
            ),

            // Tanggal Selesai Cuti
            const Text('Tanggal Selesai Cuti *',
                style: TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: controller.pilihTanggalSelesai,
              child: Obx(() => Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.tanggalSelesaiCuti.value != null
                          ? formatDate(controller.tanggalSelesaiCuti.value)
                          : 'Pilih Tanggal Selesai Cuti',
                      style: TextStyle(
                        color: controller.tanggalSelesaiCuti.value != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  )),
            ),

            // Alasan Cuti
            const Text('Alasan Cuti *',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 4,
              controller: alasanCuti,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Masukkan alasan cuti...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blue[900],
                  surfaceTintColor: Colors.blue[900],
                ),
                onPressed: () {
                  PengajuanCutiService().createPengajuanCuti(
                    idUser: GetStorage().read('id_user'),
                    tanggalCuti: controller.tanggalCuti.toString(),
                    tanggalCutiSelesai:
                        controller.tanggalSelesaiCuti.toString(),
                    alasanCuti: alasanCuti.text,
                  );
                },
                child: const Text(
                  'Ajukan  Cuti',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
