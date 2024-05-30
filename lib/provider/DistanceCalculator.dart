// import 'package:dio/dio.dart';

// class DistanceMatrixService {
//   // Replace with your actual API key
//   final String apiKey = 'AIzaSyA6ZUMXveSvj4QaSMnYVOIMS9GwfHXJp_Y';

//   Future<double> getDistanceInKilometers(double originLat, double originLon,
//       double destinationLat, double destinationLon) async {
//     final url =
//         'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$originLat,$originLon&destinations=$destinationLat,$destinationLon&key=$apiKey';

//     final dio = Dio();

//     try {
//       final response = await dio.get(url);

//       if (response.statusCode == 200) {
//         final data = response.data;
//         final elements = data['rows'][0]['elements'][0];
//         final distance = elements['distance']['value']; // Distance in meters

//         return distance / 1000.0;
//       } else {
//         throw Exception('Failed to get distance: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw e;
//     }
//   }
// }
