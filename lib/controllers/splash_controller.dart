import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presensi/views/home/home_screen.dart';
import 'package:presensi/views/login/login_screen.dart';

class SplashController extends GetxController {
  bool servicestatus = false;
  bool haspermission = false;
  LocationPermission? permission;
  Position? position;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  @override
  void onInit() {
    startSplashScreen();
    checkGps();
    fetchLocation();
    super.onInit();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);

    return Timer(duration, () async {
      Get.offAll(
        GetStorage().read('token') != null
            ? const HomeScreen()
            : const LoginScreen(),
      );
    });
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // print('Izin lokasi ditolak');
        } else if (permission == LocationPermission.deniedForever) {
          // print("''Izin lokasi ditolak permanen");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        // setState(() {
        //   //refresh the UI
        // });

        fetchLocation();
      }
    } else {
      Get.snackbar('Lokasi', 'Nyalakan GPS Terlebih dahulu');
    }
  }

  void fetchLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.low);
    latitude.value = position!.latitude;
    longitude.value = position!.longitude;
  }
}
