import 'package:flutter/material.dart';
import '../AppThemes.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});
  @override
  Widget build(BuildContext context) {
    return Container (
      color: AppColors.backgroundColor,
      child: Image.asset("assets/images/GetStarted/Screen3/Schluckspecht_GetStarted_specht3.png"),
    );
  }
}