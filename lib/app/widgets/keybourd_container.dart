// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeybourdContainer extends StatelessWidget {
  KeybourdContainer({super.key, this.text});

  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xffBCBCBC),
        ),
        alignment: Alignment.center,
        height: 54.0,
        width: 80.0,
        child: Text(
          "",
          style:
              GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
      ),
    );
  }
}
