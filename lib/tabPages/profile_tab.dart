import 'package:flutter/material.dart';
import 'package:truvel/global/global.dart';
import 'package:truvel/splashScreen/splash_screen.dart';


class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: (
        Center(
          child: ElevatedButton(
            child: Text(
              "sign Out",
              textAlign: TextAlign.start,
            ),
            onPressed: (){
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

            },
          ),
        )
      ),
    );
  }
}
