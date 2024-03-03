import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.profile,
      ),
    );
  }
}
