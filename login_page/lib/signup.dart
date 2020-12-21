import 'package:flutter/material.dart';
import 'package:login_page/homePage1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signup extends StatefulWidget {
  @override
  signupstate createState() => signupstate();
}

class signupstate extends State<signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  /*Map data;

  adddata() {
    Map<String, dynamic> data = {"User name": nameController.text,
      "User email": emailController.text,
      "User password": passwordController.text,
    };
    CollectionReference users = FirebaseFirestore.instance.collection('data');
    users.add(data);
  }*/


  @override
  Widget build(BuildContext context) {
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
                      'Sign Up',
                      style: TextStyle(fontFamily: 'montserrat', fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: repasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-enter Password',
                    ),
                  ),
                ),
    /*Container(
    height: 70,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: RaisedButton(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    side: BorderSide(color: Colors.black)
    ),
    textColor: Colors.white,
    color: Colors.black,
    child: Text('ADD', style: TextStyle(fontFamily: 'montserrat1')),
    onPressed: () {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users
          .add({
        'full_name': nameController.text, // John Doe
        'company': emailController.text, // Stokes and Sons
        'age': passwordController.text // 42
      });
    }
    )),*/
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
                      child: Text('Sign Up', style: TextStyle(fontFamily: 'montserrat1')),
                      onPressed: () async {


                        if(passwordController.text!='' && nameController.text!='' && emailController.text!='' && (passwordController.text==repasswordController.text))
                        {

                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);

                            /*CollectionReference users = FirebaseFirestore.instance.collection('users');
                            users
                                .add({
                              'User name': nameController.text,
                              'User email': emailController.text,
                              'User Password': passwordController.text
                            });*/


                           /* firestoreInstance.collection("users").add(
                                {
                                  "User name" : nameController.text,
                                  "User email" : emailController.text,
                                  "User password" : passwordController.text
                                }).then((value){
                              print(value.id);
                            }); */


                            var firebaseUser =  FirebaseAuth.instance.currentUser; // this code is for setting the document id in firestore to the firebase auth userID
                            firestoreInstance.collection("users").doc(firebaseUser.uid).set(
                                {
                                "User name" : nameController.text,
                                "User email" : emailController.text,
                                "User password" : passwordController.text

                                }).then((_){
                              print(firebaseUser.uid);
                            });


                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homePage1()),
                            );
                            Fluttertoast.showToast(
                                msg: "Sign up successsful!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Fluttertoast.showToast(
                                  msg: "Password too weak!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            } else if (e.code == 'email-already-in-use') {
                              Fluttertoast.showToast(
                                  msg: "An account already exists for this email!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          } catch (e) {
                            print(e);
                          }

                        }
                        else {
                          Fluttertoast.showToast(
                              msg: "Please enter all the fields and the passwords correctly!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        /*Map data;

                        addData() {
                          Map<String, dynamic> data = {"User name" : nameController.text,
                            "User email" : emailController.text,
                            "User password" : passwordController.text,
                          };
                          CollectionReference users = FirebaseFirestore.instance.collection('users');
                          users.add(data);
                        }*/
                      },// onPressed
                    )),

              ],
            )));
  }
}
class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'full_name': fullName, // John Doe
        'company': company, // Stokes and Sons
        'age': age // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return FlatButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}