import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truvel/authentication/sign_up_screen.dart';
import 'package:truvel/mainScreens/main_screen_user.dart';
import 'package:truvel/ptDetails/t_details.dart';
import 'package:truvel/splashScreen/splash_screen.dart';
import 'package:truvel/widgets/progress_dialog.dart';

import '../global/global.dart';


class LoginScreen extends StatefulWidget
{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();


  validateForm()
  {

    if(!emailtextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not vaild.");
    }

    else if(passwordtextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginBikerNow();

    }
  }

  loginBikerNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message:"Processing, Please Wait",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));



    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo5.png"),
              ),

              const SizedBox(height: 10,),

              const  Text(
                "Login ",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: emailtextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
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
                controller: passwordtextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
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

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                  Navigator.push(context, MaterialPageRoute(builder: (c) => Truveler()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellowAccent,
                ),
                child: const Text(
                  "Login as Truveler",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),

                ),
              ),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreenUser()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellowAccent,
                ),
                child: const Text(
                  "Login as passenger",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),

                ),
              ),
              TextButton(
                child: Text(
                  "Do Not Have an Account? Register Here ",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                },
              ),
              TextButton(
                child: Text(
                  "Forget Password ?",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                },
              ),

            ],

          ),
        ),

      ),
    );
  }
}
