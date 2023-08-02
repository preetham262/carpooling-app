import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truvel/global/global.dart';
import 'package:truvel/splashScreen/splash_screen.dart';


class BikeInfoScreen extends StatefulWidget
{


  @override
  State<BikeInfoScreen> createState() => _BikeInfoScreenState();
}


class _BikeInfoScreenState extends State<BikeInfoScreen>
{
  TextEditingController bikeModeltextEditingController = TextEditingController();
  TextEditingController bikeNumbertextEditingController = TextEditingController();
  TextEditingController bikeColortextEditingController = TextEditingController();


  List<String> bikeTypeList = ["Honda activa 6g","Honda shine", "Hero splendor","bmw s1000rr","yamaha Fzs","trimpuh street triple"];
  String? selectedBikeType;

  saveBikeInfo()
  {
    Map bikerInfoMap =
    {
      "bike_color": bikeColortextEditingController.text.trim(),
      "bike_number": bikeNumbertextEditingController.text.trim(),
      "bike_model":bikeModeltextEditingController.text.trim(),
      "type":selectedBikeType,

    };
    DatabaseReference bikersRef = FirebaseDatabase.instance.ref().child("bikers");
    bikersRef.child(currentFirebaseUser!.uid).child("bike_details").set(bikerInfoMap);
    
    
    Fluttertoast.showToast(msg: "Bike details has been saved. Congratulations");
    Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [

              const SizedBox(height: 24,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo5.png"),
              ),

              const SizedBox(height: 10,),

              const  Text(
                "Write Bike Details",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: bikeModeltextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Bike Model",
                  hintText: "Bike Model",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: bikeNumbertextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Bike Number",
                  hintText: "Bike Number",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: bikeColortextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Bike Color",
                  hintText: "Bike Color",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20,),


              DropdownButton(
                iconSize: 26,
                dropdownColor: Colors.black54,
                hint: const Text(
                    "Please Choose Bike Type",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),

                ),
                value: selectedBikeType,
                onChanged: (newVaule)
                {
                  setState(() {
                    selectedBikeType = newVaule.toString();
                  });
                },
                items: bikeTypeList.map((bike){
                   return DropdownMenuItem(
                       child: Text(
                         bike,
                         style: const TextStyle(color: Colors.yellow),
                       ),
                     value: bike,
                   );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {
                  if(bikeColortextEditingController.text.isNotEmpty
                      && bikeNumbertextEditingController.text.isNotEmpty
                      && bikeModeltextEditingController.text.isNotEmpty && selectedBikeType != null)
                  {
                    saveBikeInfo();

                  }

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellowAccent,
                ),
                child: const Text(
                  "Save Now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
