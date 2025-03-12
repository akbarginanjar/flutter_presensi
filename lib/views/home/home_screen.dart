import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi/controllers/home_conntroller.dart';
import 'package:presensi/services/home_service.dart';
import 'package:presensi/views/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black54,
        title: Text(
          'PRESENSI ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Image.asset(
              'assets/images/user.png',
              scale: 2.5,
            ),
          ),
          Obx(() {
            return Text(
              "${controller.time.value.hour.toString().padLeft(2, '0')}:"
              "${controller.time.value.minute.toString().padLeft(2, '0')}:"
              "${controller.time.value.second.toString().padLeft(2, '0')}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
          const SizedBox(height: 20),
          Text(
            '${GetStorage().read('name')}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${GetStorage().read('email')}',
            style: const TextStyle(
                // color: Colors.grey,
                ),
          ),
          const SizedBox(height: 5),
          Card(
            color: Colors.blue[50],
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Text(
                '${GetStorage().read('type')}',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.blue[900],
                surfaceTintColor: Colors.blue[900],
              ),
              onPressed: () {
                HomeService().absen(
                    latitude: controller.latitude.toString(),
                    longitude: controller.longitude.toString());
              },
              child: const Text(
                'Absen Masuk',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                side: BorderSide(color: Colors.grey[300]!),
              ),
              onPressed: () {
                Get.dialog(
                  barrierDismissible: false,
                  barrierColor: Colors.black.withOpacity(0.2),
                  AlertDialog(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    title: const Text('Logout?'),
                    content: const Text('Apakah anda mau keluar?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GetStorage().remove('token');
                          GetStorage().remove('id_user');
                          GetStorage().remove('name');
                          GetStorage().remove('email');
                          GetStorage().remove('type');
                          Get.offAll(
                            const LoginScreen(),
                            transition: Transition.rightToLeftWithFade,
                          );
                        },
                        child: Text(
                          'Ya, logout',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
