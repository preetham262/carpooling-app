import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truvel/global/location_services.dart';
import 'package:truvel/mainScreens/main_screen.dart';
import 'package:truvel/mainScreens/main_screen_user.dart';



class Truveler extends StatefulWidget {
  const Truveler({Key? key}) : super(key: key);

  @override
  State<Truveler> createState() => _TruvelerState();
}

class _TruvelerState extends State<Truveler> {
  late GoogleMapController newGoogleMapController;
  TextEditingController _destinationController = TextEditingController();
  final Completer<GoogleMapController> _controllerGoogleMaps = Completer();

  TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Page")),
        body:
        Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.width*0.4,0,0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    height:50,
                    child: TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        hintText: "Enter Destination point",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height:50,
                    child: TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        hintText: "Enter Depature point",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                    ),
                  ),
                  TextButton(
                    child: Text("submit"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controllerGoogleMaps.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }
}