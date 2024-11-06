import 'package:geolocator/geolocator.dart';

class Services {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kiểm tra nếu dịch vụ vị trí đã được bật
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Nếu không bật dịch vụ, yêu cầu người dùng bật nó
      await Geolocator.openLocationSettings();
      return Future.error('Location disbaled');
    }

    // Kiểm tra quyền truy cập vị trí
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Yêu cầu quyền nếu nó bị từ chối
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Quyền vẫn bị từ chối
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Quyền bị từ chối vĩnh viễn, không thể yêu cầu lại
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Lấy vị trí hiện tại
    return await Geolocator.getCurrentPosition();
  }
}
