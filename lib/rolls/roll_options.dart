import 'package:flutter/material.dart';
import 'package:truvel/authentication/bike_info_screen.dart';
import 'package:truvel/mainScreens/main_screen_user.dart';
import './roll_options.dart';



class RollOption extends StatefulWidget {
  const RollOption({Key? key}) : super(key: key);

  @override
  State<RollOption> createState() => _RollOption();
}

class _RollOption extends State<RollOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height * 0.4,0,0),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              const  Text(
                "Choose The Roll",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,

                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                child: Text(
                  "Truveler",
                  textAlign: TextAlign.start,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>  BikeInfoScreen()));

                },
              ),

              const SizedBox(height: 30,),

              ElevatedButton(
                child: Text(
                  "Passenger",
                  textAlign: TextAlign.end,
                ),
                onPressed: (){
                  Navigator.push((context), MaterialPageRoute(builder: (c)=> MainScreenUser()));

                },
              ),
              ],
          ),
        ),
      ),


    );

    Scaffold();
  }
}
