import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';

class HomeController extends GetxController {
  bool servicestatus = false;
  bool haspermission = false;
  LocationPermission? permission;
  Position? position;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var time = DateTime.now().obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time.value = DateTime.now();
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
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
