import 'package:flutter/material.dart';

class AlbumRotator extends StatefulWidget {
  AlbumRotator({super.key, required this.profilePhotoUrl});

  String profilePhotoUrl;

  @override
  State<AlbumRotator> createState() => _AlbumRotatorState();
}

class _AlbumRotatorState extends State<AlbumRotator> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    controller.forward();
    controller.repeat();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.grey,
                  Colors.white
                ]),
                borderRadius: BorderRadius.circular(35)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image(image: NetworkImage(widget.profilePhotoUrl), fit: BoxFit.cover,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
