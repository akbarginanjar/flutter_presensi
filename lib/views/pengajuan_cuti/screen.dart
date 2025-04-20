import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/controllers/pengajuan_cuti_controller.dart';
import 'package:presensi/views/pengajuan_cuti/create_pengajuan_cuti.dart';

class PengajuanCutiScreen extends StatelessWidget {
  const PengajuanCutiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PengajuanCutiController controller =
        Get.put(PengajuanCutiController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black54,
        title: const Text('Pengajuan Cuti'),
      ),
      body: Obx(
        () {
          return RefreshIndicator(
            color: Colors.blue[900],
            backgroundColor: Colors.white,
            onRefresh: () async {
              await controller.loadPengajuanCuti();
            },
            child: controller.isLoadingPengajuanCuti.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue[900],
                    ),
                  )
                : SingleChildScrollView(
                    physics:
                        const AlwaysScrollableScrollPhysics(), // penting buat RefreshIndicator
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                              ),
                              onPressed: () {
                                Get.to(CreatePengajuanCuti());
                              },
                              child: Text(
                                'Buat Pengajuan Cuti',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                          const SizedBox(height: 10),
                          ListView.builder(
                            itemCount: controller.listPengajuanCuti.length,
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // biar gak konflik scroll
                            itemBuilder: (context, index) {
                              final pengajuanCuti =
                                  controller.listPengajuanCuti[index];
                              return Card(
                                margin: const EdgeInsets.only(
                                    top: 0, left: 0, right: 0, bottom: 10),
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  side: BorderSide(color: Colors.grey[400]!),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        margin: const EdgeInsets.all(0),
                                        color: Colors.blue[100],
                                        surfaceTintColor: Colors.blue[100],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Text(
                                            pengajuanCuti.statusPermohonan ==
                                                    null
                                                ? 'Pending'
                                                : pengajuanCuti
                                                            .statusPermohonan ==
                                                        0
                                                    ? 'Ditolak'
                                                    : 'Disetujui',
                                            style: TextStyle(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Tanggal Cuti'),
                                          Text('${pengajuanCuti.tanggalCuti}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Tanggal Selesai Cuti'),
                                          Text(
                                              '${pengajuanCuti.tanggalCutiSelesai}'),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Alasan Cuti',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('${pengajuanCuti.alasanCuti}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
