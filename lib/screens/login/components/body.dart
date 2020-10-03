import 'package:cab_rider/assets/resources/brand_colors.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                "Sign In as a Rider",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
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
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25),
                      ),
                      color: BrandColors.colorGreen,
                      textColor: Colors.white,
                      onPressed: () {},
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand-Bold',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text("Don\'t have an account? Sign Up here."))
            ],
          ),
        ),
      ),
    );
  }
}
