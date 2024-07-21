import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_tutorial/controller/video_controller.dart';
import 'package:get_x_tutorial/view/screens/commment_screen.dart';
import 'package:get_x_tutorial/view/widgets/album_rotator.dart';
import 'package:get_x_tutorial/view/widgets/profile_button.dart';
import 'package:get_x_tutorial/view/widgets/tiktok_video_player.dart';

class DisplayVideoScreen extends StatefulWidget {
  const DisplayVideoScreen({super.key});

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
            itemCount: videoController.videoList.length,
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemBuilder: (context, index) {
              var videoData = videoController.videoList[index];
              return Stack(
                children: [
                  TiktokVideoPlayer(videoUrl: videoData.videoUrl),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('@${videoData.username}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                        Text(videoData.caption, style: const TextStyle(fontWeight: FontWeight.w500)),
                        Text(videoData.songName),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileButton(profilePhotoUrl: videoData.profilePic),

                          InkWell(
                            onTap: (){
                              videoController.likedVideo(videoData.id);
                            },
                            child: Column(
                              children: [
                                const Icon(Icons.favorite, size: 30, color: Colors.white,),
                                Text(videoData.likes.length.toString(), style: const TextStyle(fontSize: 13, color: Colors.white),),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(id: videoData.id),));
                            },
                            child: Column(
                              children: [
                                const Icon(Icons.comment, size: 30, color: Colors.white,),
                                Text(videoData.commentsCount.toString(), style: const TextStyle(fontSize: 13, color: Colors.white),),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(Icons.reply, size: 30, color: Colors.white,),
                              Text(videoData.shareCount.toString(), style: const TextStyle(fontSize: 13, color: Colors.white),),
                            ],
                          ),
                          AlbumRotator(profilePhotoUrl: videoData.profilePic)
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
      ),
    );
  }
}
