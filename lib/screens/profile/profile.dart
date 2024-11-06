import 'package:ecommerce_app/screens/profile/component/profile_form.dart';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
      ),
      body: const SingleChildScrollView(child: ProfileForm()),
    );
  }
}
