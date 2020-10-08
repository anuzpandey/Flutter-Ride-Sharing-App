import 'package:cab_rider/assets/resources/brand_colors.dart';
import 'package:cab_rider/components/fill_button.dart';
import 'package:cab_rider/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void registerUser() async {
    final UserCredential user =
    (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ));

    if (user != null) {
      print('Reg Successful.');
    }
  }

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: scaffoldKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 70),
              Image(
                alignment: Alignment.center,
                height: 100.0,
                width: 100.0,
                image: AssetImage('lib/assets/images/logo.png'),
              ),
              SizedBox(height: 70),
              Text(
                "Create a Rider's Account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 40),
                    FillButton(
                      title: 'Register',
                      color: BrandColors.colorGreen,
                      onPressed: () {
                        // Check Network Availability

                        if (fullNameController.text.length < 3) {
                          showSnackBar("Please provide your full name.");
                          return;
                        }

                        if (phoneNumberController.text.length < 10) {
                          showSnackBar("Please provide valid phone number.");
                          return;
                        }

                        if (emailController.text.contains('@')) {
                          showSnackBar("Please provide valid email address.");
                          return;
                        }

                        if (passwordController.text.length < 8) {
                          showSnackBar("Please provide password which is 8 character long.");
                          return;
                        }

                        registerUser();
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text("Already have an account? Login."))
            ],
          ),
        ),
      ),
    );
  }
}
