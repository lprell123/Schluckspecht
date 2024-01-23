import 'package:flutter/material.dart';
import '../AppThemes.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          heightFactor: 0.7,
          child: Image.asset(
            "assets/images/GetStarted/Screen3/Schluckspecht_GetStarted_specht3.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}