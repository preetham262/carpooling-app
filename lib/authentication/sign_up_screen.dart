import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truvel/authentication/bike_info_screen.dart';
import 'package:truvel/authentication/login_screen.dart';
import 'package:truvel/global/global.dart';
import 'package:truvel/rolls/roll_options.dart';
import 'package:truvel/widgets/progress_dialog.dart';


class SignUpScreen extends StatefulWidget
{

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();


  validateForm()
  {
    if(nametextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "name must be atleast 3 characters");

      }
    else if(!emailtextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email address is not vaild.");
      }
    else if(phonetextEditingController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Phone Number is required.");
      }
    else if(phonetextEditingController.text.length < 10)
      {
        Fluttertoast.showToast(msg: "Phone Number invaild");
      }

    else if(passwordtextEditingController.text.length < 8)
      {
        Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
      }
    else{
      saveBikerInfonow();
    }
  }


  saveBikerInfonow() async
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
        await fAuth.createUserWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      Map bikerMap =
      {
        "id": firebaseUser.uid,
        "name": nametextEditingController.text.trim(),
        "email":emailtextEditingController.text.trim(),
        "phone":phonetextEditingController.text.trim(),
      };

      DatabaseReference bikersRef = FirebaseDatabase.instance.ref().child("bikers");
      bikersRef.child(firebaseUser.uid).set(bikerMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created");
      Navigator.push(context, MaterialPageRoute(builder: (c) => RollOption()));



    }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account has not been Created ");
      }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo5.png"),
              ),
              const SizedBox(height: 10,),

             const  Text(
                "Register as a Truveler",
                 style: TextStyle(
                  fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),

              TextField(
            controller: nametextEditingController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Name",
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
                controller: phonetextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
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

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellowAccent,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),

                ),
              ),

              TextButton(
                child: Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              ),



            ],
          ),
        ),
      ),
    );
  }
}
