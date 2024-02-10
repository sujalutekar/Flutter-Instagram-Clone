import 'package:flutter/material.dart ';

import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../providers/user_provider.dart';
import '../models/user.dart' as model;
// import '../pages/upload_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileAppBarColor,
        title: Text(user.username),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(user.email),
      ),
    );
  }
}
