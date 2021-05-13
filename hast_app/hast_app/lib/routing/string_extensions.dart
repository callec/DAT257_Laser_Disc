import 'package:hast_app/routing/routing_data.dart';

/// Adds a new method to the String class that picks out Query parameters
/// and the Route

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    //print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
