

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';




class locationservice{
  final String key = "AIzaSyBpftW1v7CXq4_82IQE9hc_pL2lQ1TnftA";

  Future<String> GetPlaceId(String input) async{
    final String url =
        'https://console.cloud.google.com/google/maps-apis/overview?project=stone-arcade-353613';

    var response = await http.get(Uri.https(url,''));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id']as String;

    return placeId;

  }


  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await GetPlaceId(input);
    final String url=
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;
  }
}