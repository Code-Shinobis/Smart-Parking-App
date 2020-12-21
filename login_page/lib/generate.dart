import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:login_page/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeneratePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage>{

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  var firebaseUser =  FirebaseAuth.instance.currentUser;

  String qrData = "Code Shinobis";// already generated qr code when the page opens

  @override
  Widget build(BuildContext context) {

    final qrdataFeed = firebaseUser.uid; //The qr data is assigned with the user's unique firebase userid so that it would be unique for each user

    return Scaffold(
      resizeToAvoidBottomPadding: false, //added this line to avoid bottom overflow error
        appBar: AppBar(
          backgroundColor: Colors.black,
        title: Text('Your unique QR code',
        style: TextStyle(
        fontFamily: 'montserrat1')),
          actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              //place where the QR Image will be shown
              data: qrData,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "User QR Code Generator",
              style: TextStyle(fontFamily: 'montserrat',fontSize: 20.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {

                  if (qrdataFeed=="") {        //a little validation for the textfield
                    setState(() {
                      qrData = "";
                    });
                  } else {
                    setState(() {
                      qrData = qrdataFeed;
                    });
                  }

                },
                child: Text(
                  "Generate your unique QR",
                  style: TextStyle(fontFamily: 'montserrat',
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }


}
