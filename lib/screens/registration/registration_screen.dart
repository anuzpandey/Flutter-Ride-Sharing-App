import 'package:cab_rider/assets/resources/brand_colors.dart';
import 'package:cab_rider/components/fill_button.dart';
import 'package:cab_rider/screens/login/login_screen.dart';
import 'package:cab_rider/screens/main_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var fullNameController = TextEditingController();

  var phoneNumberController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async {
    try {
      final UserCredential user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ));

      // check if user registration is successful.
      if (user != null) {
        print('Reg Successful.');
        DatabaseReference newUserRef = FirebaseDatabase.instance
            .reference()
            .child('users/${_auth.currentUser.uid}');

        // prepare data to be saved on users table.
        Map userMap = {
          'fullName': fullNameController.text,
          'email': emailController.text,
          'phone': phoneNumberController.text
        };

        newUserRef.set(userMap);

        // Navigate User to Main Page
        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.routeName, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        showSnackBar("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                        onPressed: () async {
                          // Check Network Availability
                          var connectivityResult =
                              await Connectivity().checkConnectivity();

                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar("No Internet Connectivity.");
                          }

                          if (fullNameController.text.length < 3) {
                            showSnackBar("Please provide your full name.");
                            return;
                          }

                          if (phoneNumberController.text.length < 10) {
                            showSnackBar("Please provide valid phone number.");
                            return;
                          }

                          // if (emailController.text.contains('@')) {
                          //   showSnackBar("Please provide valid email address.");
                          //   return;
                          // }

                          if (passwordController.text.length < 8) {
                            showSnackBar("Password must be 8 character long.");
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
      ),
    );
  }
}
