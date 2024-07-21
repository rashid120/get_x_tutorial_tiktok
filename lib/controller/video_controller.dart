import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_x_tutorial/controller/auth_controller.dart';
import 'package:get_x_tutorial/model/video.dart';

class VideoController extends GetxController{

  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;
  
  @override
  void onInit() {
    super.onInit();

    var ref = FirebaseFirestore.instance.collection('tVideos').snapshots().map((QuerySnapshot query){
      List<Video> retVal = [];

      for(var element in query.docs){
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    });
    _videoList.bindStream(ref);
  }

  likedVideo(String id) async{

    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('tVideos').doc(id).get();
    var uid = AuthController.instance.user.uid;

    if((doc.data() as dynamic)['likes'].contains(uid)){
      await FirebaseFirestore.instance.collection('tVideos').doc(id).update({
        'likes' : FieldValue.arrayRemove([uid])
      });
    }else{

      await FirebaseFirestore.instance.collection('tVideo').doc(id).update({
        'likes' : FieldValue.arrayUnion([uid])
      });
    }
  }
}