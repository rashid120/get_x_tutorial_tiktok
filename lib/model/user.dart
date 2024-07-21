import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{

  String name;
  String profilePic;
  String email;
  String uid;

  MyUser({required this.name, required this.profilePic, required this.email, required this.uid});

  factory MyUser.fromMap(Map<String, dynamic> map)
  =>MyUser(
      name: map['name'],
      profilePic: map['profilePic'],
      email: map['email'],
      uid: map['uid'],
  );

  // App - Firebase(Map)
  Map<String, dynamic> toMap() => {
    'name' : name,
    'profilePic' : profilePic,
    'email' : email,
    'uid' : uid,
  };

  static MyUser fromSnap(DocumentSnapshot snap){

    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
      name: snapshot['name'],
      profilePic: snapshot['profilePic'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}