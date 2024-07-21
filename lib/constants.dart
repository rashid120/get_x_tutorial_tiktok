import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_x_tutorial/view/screens/add_video.dart';
import 'package:get_x_tutorial/view/screens/display_screen.dart';
import 'package:get_x_tutorial/view/screens/profile_screen.dart';
import 'package:get_x_tutorial/view/screens/search_screen.dart';

//  COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// getRandomColor() => Colors.primaries[Random().nextInt(Colors.primaries.length)];

getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];

var pageIndex = [

  DisplayVideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Text('Messages'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];