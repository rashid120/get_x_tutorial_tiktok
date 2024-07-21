import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_tutorial/constants.dart';
import 'package:get_x_tutorial/view/screens/add_caption_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOpt(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor
            ),
            child: const Center(child: Text("Add video", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
        ),
      ),
    );
  }

  showDialogOpt(BuildContext context){

    return showDialog(context: context, builder: (context) => SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed:(){ videoPicker(ImageSource.gallery); Get.back();},
          child: const ListTile(title: Text("Gallery"), leading: Icon(Icons.photo_outlined),),
        ),
        SimpleDialogOption(
          onPressed: (){ videoPicker(ImageSource.camera); Get.back();},
          child: const ListTile(title: Text("Camera"), leading: Icon(Icons.camera_alt_outlined),),
        ),
        SimpleDialogOption(
          onPressed: (){Navigator.pop(context);},
          child: const Align(alignment: Alignment.centerRight,child: Text("Cancel"),),
        ),
      ],
    ),);
  }

  videoPicker(ImageSource source) async{

    final video = await ImagePicker().pickVideo(source: source);
    
    if(video != null){
      Get.snackbar("Video Selected", video.path);
      Get.to(AddCaptionScreen(videoFile: File(video.path), videoPath: video.path));
    }else{
      Get.snackbar("Error", "Please try again");
    }
  }
}
