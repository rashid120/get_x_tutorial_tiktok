
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_x_tutorial/model/user.dart';
import 'package:get_x_tutorial/view/screens/auth/login_screen.dart';
import 'package:get_x_tutorial/view/screens/auth/signup_screen.dart';
import 'package:get_x_tutorial/view/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find();

  late Rx<User?> _user;
  User get user => _user.value!;

  // User state Persistence
  @override
  void onReady() {
    super.onReady();

    // Rx - Observable keyword - Continuously checking Variable is changing or Not.
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges()); // Authentication me changes ko dekhega
    // ever - ye continuously listen karte rehta hai changes ko
    ever(_user, _setInitialView); // ye continuously changes ko dekhega
    // jaise hee change hoga _setInitialView function call hoga aur _user as a argument pass hoga
  }

  _setInitialView(User? user){

    if(user == null){
      Get.offAll(()=> SignUpScreen());
    }else{
      Get.offAll(()=> HomeScreen());
    }
  }

  // user signup
  void signUp(String username, String email, String password, File? image) async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null){
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUri = await _uploadProPic(image);
        
        MyUser user = MyUser(name: username, profilePic: downloadUri, email: email, uid: credential.user!.uid);
        await FirebaseFirestore.instance.collection("tUsers").doc(credential.user!.uid).set(user.toMap());
      }else{
        Get.snackbar("Error Creating Account", "Please fill the all requires fields");
      }
    }catch(e){
      Get.snackbar("Error occurred", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async{
    Reference ref = FirebaseStorage.instance.ref().child("tProfilePics").child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUri = await taskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  File? proImg;

  imagePicker() async{

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image == null) return;
    final img = File(image.path);
    proImg = img;
  }

  userLogin(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar("Error Logging In", "Please fill the all requires fields");
      }
    }catch(e){
      Get.snackbar("Error Logging In", e.toString());
    }
  }

  signOut(){
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }
}