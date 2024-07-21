import 'package:flutter/material.dart';
import 'package:get_x_tutorial/constants.dart';
import 'package:get_x_tutorial/view/widgets/custom_add_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int pageIdx = 0;
  changePageIdx(int index){
    setState(() {pageIdx = index;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: pageIndex[pageIdx],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          currentIndex: pageIdx,
          onTap: changePageIdx,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 20,), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search, size: 20,), label: "Search"),
            BottomNavigationBarItem(icon: CustomAddIcon(), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.message, size: 20,), label: "Message"),
            BottomNavigationBarItem(icon: Icon(Icons.person, size: 20,), label: "Profile"),
          ]
      ),
    );
  }
}
