import 'package:flutter/material.dart';
import 'package:login_page/homePage1.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgotPass extends StatefulWidget {
  @override
  forgotPassstate createState() => forgotPassstate();
}

class forgotPassstate extends State<forgotPass> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('CODE SHINOBIS', style: TextStyle(fontFamily: 'painter'))
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Smart Parking System',
                      style: TextStyle(
                            fontFamily: 'montserrat1',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(fontFamily: 'montserrat',fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Please enter your email',
                    ),
                  ),
                ),



                Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.black)
                        ),
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text('Send OTP', style: TextStyle(fontFamily: 'montserrat1')),
                      onPressed: () {
                        if(emailController.text!='') {
                          Fluttertoast.showToast(
                              msg: "OTP sent!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        else
                          {
                            Fluttertoast.showToast(
                                msg: "Please enter an email id!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        } //onPressed

                    )),

              ],
            )));
  }
}