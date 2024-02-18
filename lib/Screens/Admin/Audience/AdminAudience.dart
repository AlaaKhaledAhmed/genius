import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class AdminAudience extends StatefulWidget {
  const AdminAudience({Key? key}) : super(key: key);

  @override
  State<AdminAudience> createState() => _AdminAudienceState();
}

class _AdminAudienceState extends State<AdminAudience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.audience,
      ),
    );
  }
}
