import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.Cardcolor,
      child: ListView(
        children: const [
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
