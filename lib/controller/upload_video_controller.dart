import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/video.dart';

class UploadVideoController extends GetxController{

  static UploadVideoController instance = Get.find();
//Methods
  //Main Video Upload
  //Video To Storage
  //Video Compress
  //Video Thumb Generate
  //Video Thumb To Storage

  var uuid = const Uuid();    // Video - uuid

  uploadVideo(String songName, String caption, File videoPath) async{
    try{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("tUsers").doc(uid).get();
    String id = uuid.v1();
    String videoUrl = await _uploadVideoToStorage(id, videoPath);
    // String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);

    print((userDoc.data()! as Map<String , dynamic>).toString());

    Video video = Video(
        uid: uid,
        username: (userDoc.data()! as Map<String , dynamic>)['name'],
        videoUrl: videoUrl,
        songName: songName,
        shareCount: 0,
        commentsCount: 0,
        likes: [],
        profilePic: (userDoc.data()! as Map<String , dynamic>)['profilePic'],
        caption: caption,
        id: id
    );
    await FirebaseFirestore.instance.collection("tVideos").doc(id).set(video.toMap());
    Get.snackbar("Video Uploaded Successfully", "Thank You Sharing Your Content");
    Get.back();
    }catch(e) {
      print(e);
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }

  // Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async{
  //
  //   Reference reference = FirebaseStorage.instance.ref().child("tThumbnail").child(id);
  //   UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUri = await snapshot.ref.getDownloadURL();
  //   return downloadUri;
  // }

  // Future<File> _getThumb(String videoPath) async{
  //   final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
  //   return thumbnail;
  // }

  Future<String> _uploadVideoToStorage(String videoId, File videoPath) async{

    Reference reference = FirebaseStorage.instance.ref().child("tVideos").child(videoId);
    UploadTask uploadTask = reference.putFile(videoPath);
    // UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUri = await snapshot.ref.getDownloadURL();
    return downloadUri;
  }

  // Future _compressVideo(String videoPath) async{
  //   final compressedVideo = await VideoCompress.compressVideo(videoPath, quality: VideoQuality.MediumQuality);
  //   return compressedVideo!.file;
  // }
}

