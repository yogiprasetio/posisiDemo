part of 'core.dart';

class setPermission {
  Future<void> requestPermission() async {
    var statusses = await [
      ph.Permission.location,
      ph.Permission.locationAlways,
      ph.Permission.notification,
      //ph.ignoreBatteryOptimizations
    ].request();
    await checkGps();
    print(
        "Location => ${statusses[ph.Permission.location]}, Notif => ${statusses[ph.Permission.notification]}");
    if (await ph.Permission.speech.isPermanentlyDenied) {
      requestPermissionWithOpenedSettings();
    }
  }

  void requestPermissionWithOpenedSettings() async {
    ph.openAppSettings();
  }

  Future<bool> checkGps() async {
    bool serviceEnabled;
    // Tes apakah layanan lokasi atau GPS sudah menyala atau belum
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // layanan lokasi tidak menyala, maka aplikasi tidak dapat mengakses
      // lokasi dan aplikasi harus meminta ijin akses kepada
      // user untuk menyalakan GPS
      try {
        //karena GeoLocator tidak mentyediakan fitur untuk permission menyalakan GPS, jadi saya ambil pendekatan cara ini.
        await Geolocator.getCurrentPosition();
        serviceEnabled = true;
      } catch (e) {
        return false;
      }
      return true;
    }
    return false;
  }

  Future<void> checkPermit() async {
    bool gps;
    LocationPermission permission;

    // Test GPS
    gps = await checkGps();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        requestPermissionWithOpenedSettings();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever && gps == false) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      requestPermissionWithOpenedSettings();
      return;
    }
  }
}
