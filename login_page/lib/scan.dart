import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String qrCodeResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Scanner", style: TextStyle(
        fontFamily: 'montserrat1')),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "RESULT :",
              style: TextStyle(fontFamily: 'montserrat',fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {

                  String codeScanner = await BarcodeScanner.scan();    //qr scanner
                  qrCodeResult = "UserXYZ - UserXYZ@gmail.com"; // default user data stored as scan result in case scan is not possible
                  var firebaseUser =  FirebaseAuth.instance.currentUser; // this code is for setting the document id in firestore to the firebase auth userID
                  firestoreInstance.collection("parking").doc(firebaseUser.uid).set(
                      {
                        "User info" : qrCodeResult
                      }).then((_){
                    print(firebaseUser.uid);
                  });


              },
              child: Text(
                "Open Scanner",
                style:
                    TextStyle(fontFamily: 'montserrat',color: Colors.black, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }
}
