import 'package:cloud_firestore/cloud_firestore.dart';

class Video{

  String username;
  String uid;
  String id;
  List likes;
  int commentsCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String profilePic;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentsCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() => {
    'username' : username,
    'uid' : uid,
    'id' : id,
    'likes' : likes,
    'commentsCount' : commentsCount,
    'shareCount' : shareCount,
    'songName' : songName,
    'caption' : caption,
    'videoUrl' : videoUrl,
    'profilePic' : profilePic,
  };

  static Video fromSnap(DocumentSnapshot  snap){

    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        commentsCount: snapshot['commentsCount'],
        shareCount: snapshot['shareCount'],
        songName: snapshot['songName'],
        caption: snapshot['caption'],
        videoUrl: snapshot['videoUrl'],
        profilePic: snapshot['profilePic']
    );
  }
}