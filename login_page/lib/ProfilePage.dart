import 'package:flutter/material.dart';
import 'package:login_page/homePage1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget {


  @override
  profilestate createState() => profilestate();
}

class profilestate extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {




    String name;
    String email;

    firestoreInstance.collection("users").doc(firebaseUser.uid).get().then((value) {
      name = "USER NAME   :   " + value.data()["User name"];
    });

    firestoreInstance.collection("users").doc(firebaseUser.uid).get().then((value) {
      email = "USER EMAIL   :   " + value.data()["User email"];
    });

    // The following comments contain some unused code which could be helpful in reading data from Cloud Firestore

    /*fetchdata() {
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('users');
      collectionReference.snapshots().listen((snapshot) {
        setState(() {
          name = snapshot.docs[firebaseUser.uid].data()["User name"];
        });
      });
    }*/


    /*Future<String> getData() async {
      final User user = await FirebaseAuth.instance.currentUser;
      final String uid = user.uid.toString();
      return uid;
    }


    Stream<DocumentSnapshot> getUserStream() async* {
      final uid = await getData();
      print(uid);
      yield* FirebaseFirestore.instance.doc("Users/$uid").snapshots();
    }*/


    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('CODE SHINOBIS',style: TextStyle(fontFamily: 'painter'))
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[

                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'USER PROFILE',
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
                      'Customer',
                      style: TextStyle(fontFamily: 'montserrat', fontSize: 20),
                    )),

                SizedBox(height: 10),
                Text(

                    name!=null?name:'USER NAME   :   UserXYZ'
                ),



                SizedBox(height: 10),

                Text(

                    email!=null?email:'USER EMAIL   :   UserXYZ@gmail.com'
                ),


                Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.black)
                        ),
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text('Log out', style: TextStyle(fontFamily: 'montserrat1')),
                      onPressed: () async {

                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp())
                        );}
                    )),

              ],
            )));
  }
}