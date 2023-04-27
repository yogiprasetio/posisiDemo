part of 'core.dart';

const task = "backgroundTask";
LatLng? post;
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    DartPluginRegistrant.ensureInitialized();
    //simpleTask will be emitted here.
    LocationUser _locUser = LocationUser();
    Position? currentPosition;
    switch (taskName) {
      case 'backgroundTask':
        {
          DartPluginRegistrant.ensureInitialized();
          await Geolocator.getCurrentPosition(
                  forceAndroidLocationManager: false,
                  desiredAccuracy: LocationAccuracy.bestForNavigation)
              .then((Position position) {
            print("lat ${position!.latitude} ||long ${position!.longitude}");
            return currentPosition = position;
          }).catchError((e) {
            print(e);
          });
          String? alamat =
              await _locUser.getAddressFromLatLng(currentPosition!);
          _locUser.getLocation(alamat);
        }
        break;
    }
    print(taskName);
    return Future.value(true);
  });
}
