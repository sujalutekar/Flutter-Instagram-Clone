import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

// import '../providers/user_provider.dart';
import '../utils/colors.dart';
// import '../models/user.dart' as model;
import '../pages/upload_page.dart';
import 'feed_page.dart';
import './profile_page.dart';

class InstagramPage extends StatefulWidget {
  const InstagramPage({super.key});

  @override
  State<InstagramPage> createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  String username = "";
  int _page = 0;
  late PageController pageController;
  double selectedIconSize = 33;
  double unSelectedIconSize = 30;

  @override
  void initState() {
    super.initState();
    // getUsername();
    // refreshingUser();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // refreshingUser() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);

  //   await _userProvider.refreshUser();
  // }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   print(snap.data());

  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          FeedPage(),
          Text('Search'),
          UploadPage(),
          Text('Likes'),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: _page == 0 ? selectedIconSize : unSelectedIconSize,
              color: _page == 0 ? Colors.white : Colors.grey,
            ),
            label: "",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: _page == 1 ? selectedIconSize : unSelectedIconSize,
              color: _page == 1 ? Colors.white : Colors.grey,
            ),
            label: "",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              size: _page == 2 ? selectedIconSize : unSelectedIconSize,
              color: _page == 2 ? Colors.white : Colors.grey,
            ),
            label: "",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              size: _page == 3 ? selectedIconSize : unSelectedIconSize,
              color: _page == 3 ? Colors.white : Colors.grey,
            ),
            label: "",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: _page == 4 ? selectedIconSize : unSelectedIconSize,
              color: _page == 4 ? Colors.white : Colors.grey,
            ),
            label: "",
            backgroundColor: Colors.white,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
