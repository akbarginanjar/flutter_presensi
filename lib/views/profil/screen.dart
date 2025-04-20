import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi/views/login/login_screen.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Profil Saya',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/user.png',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            margin: const EdgeInsets.all(15),
            elevation: 0,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
              side: BorderSide(color: Colors.grey[400]!),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profil',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'NAMA LENGKAP',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                  ),
                  Text(
                    '${GetStorage().read('name')}',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'EMAIL',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                  ),
                  Text(
                    '${GetStorage().read('email')}',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'JABATAN',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                  ),
                  Text(
                    '${GetStorage().read('type')}',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  surfaceTintColor: Colors.blue[900],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onPressed: () {
                  GetStorage().remove('token');
                  GetStorage().remove('id_user');
                  GetStorage().remove('name');
                  GetStorage().remove('email');
                  GetStorage().remove('type');
                  Get.offAll(const LoginScreen());
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
