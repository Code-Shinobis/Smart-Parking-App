import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/ProfilePage.dart';
import 'package:login_page/generate.dart';
import 'package:login_page/scan.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homePage1 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<homePage1> {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Smart Parking System", style: TextStyle(
        fontFamily: 'montserrat1')),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
            child : IconButton(

             icon: Icon(Icons.settings),
             tooltip: 'Settings',
             onPressed: () {
               FirebaseAuth.instance
                   .authStateChanges()
                   .listen((User user) {
                 if (user == null) {
                   Fluttertoast.showToast(
                       msg: "No user found for that email!",
                       toastLength: Toast.LENGTH_LONG,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Colors.blue,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );
                 } else {
                   Fluttertoast.showToast(
                       msg: "User found for that email!",
                       toastLength: Toast.LENGTH_LONG,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Colors.blue,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );
                 }
               });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()),
                             );
                           }
             )),


            Image(image: NetworkImage("https://media.istockphoto.com/vectors/qr-code-scan-phone-icon-in-comic-style-scanner-in-smartphone-vector-vector-id1166145556")),
            flatButton("Scan QR CODE", ScanPage()),
            SizedBox(height: 20.0,),
            flatButton("Generate QR CODE", GeneratePage()),
          ],
        ),
      ),
    );
  }
  

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black,width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
