import 'package:developerslife_flutter/routing/routing_data.dart';

//extension StringExtension on String {
//  RoutingData get getRoutingData {
//    var uriData = Uri.parse(this);
//    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
//
//    return RoutingData(
//      queryParameters: uriData.queryParameters,
//      route: uriData.path,
//    );
//  }
//}

RoutingData getRoutingData(String string) {
  var uriData = Uri.parse(string);
  print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');

  return RoutingData(
    queryParameters: uriData.queryParameters,
    route: uriData.path,
  );
}