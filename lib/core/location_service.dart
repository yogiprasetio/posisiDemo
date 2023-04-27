part of 'core.dart';

class LocationUser {
  Future getLocation(String alamat) async {
    NotificationWidget.tampilNotifikasi(
      title: "Location Service",
      body: "Detected Location in : $alamat",
    );
  }

  Future<String> getAddressFromLatLng(Position position) async {
    DartPluginRegistrant.ensureInitialized();
    String? alamat;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      return alamat =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      print(e);
      return "Error";
    });
    return alamat!;
  }
}
