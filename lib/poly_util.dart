library google_maps_util;
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A Helper Class Regarding PolyLine in google_maps_flutter
class PolyUtil{
  /// This method converts overview_polyline points from Google Directions Api to Array of PolyLine in Flutter
  /// For more info on overview PolyLine refer
  /// https://developers.google.com/maps/documentation/directions/start
  decode (String overviewPolylinePoints){
    int len = overviewPolylinePoints.length;
    List<LatLng> path = new List<LatLng>();
    int index = 0;
    int lat = 0;
    int lng = 0;
    while (index < len) {
      int result = 1;
      int shift = 0;
      int b;
      do {
        b = overviewPolylinePoints[index++].codeUnitAt(0) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      result = 1;
      shift = 0;
      do {
        b = overviewPolylinePoints[index++].codeUnitAt(0) - 63 - 1;
        result += b << shift;
        shift += 5;
      } while (b >= 0x1f);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      path.add(new LatLng(lat * 1e-5, lng * 1e-5));
    }
    ///Returns An Array of LatLng corresponding to the overview_polyline
    return path;
  }
}