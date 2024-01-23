import 'package:flutter/material.dart';
import '../AppThemes.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            height: 800,
            right: 0,
            child: Image.asset(
              'assets/images/GetStarted/Screen1/Schluckspecht_GetStarted_background1.png',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: AppCardStyle.innerPadding,
            child: Column(
              
              children: [
                /*
                Card(
                  color: AppColors.backgroundColor,
                  margin: AppCardStyle.cardMargin,
                  child: Padding(
                    padding: AppCardStyle.innerPadding,
                    child: Column( 
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Willkommen beim ',
                                style: TextStyle(
                                  fontSize: AppTextStyle.largeFontSize,
                                  color: AppColors.primaryFontColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Schluckspecht!',
                                style: TextStyle(
                                  fontSize: AppTextStyle.largeFontSize,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ]
                          )
                        ),
                        SizedBox(height: 16.0),
          
                        Text(
                          'Wir sind ein Team engagierter Studenten, das hocheffiziente Fahrzeuge für weltweite Rennen baut.',
                          style: TextStyle(fontSize: AppTextStyle.largeFontSize),
                        ),
                      ],
                    ),
                  ),
                ),
                */
                Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Container(
                    child: Image.asset(
                      'assets/images/GetStarted/Screen2/Schluckspecht_GetStarted_specht2.png', 
                      fit: BoxFit.cover, 
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Container(
                    child: Image.asset(
                      'assets/images/GetStarted/Screen2/Schluckspecht_GetStarted_fahrzeug2.png', 
                      fit: BoxFit.cover, 
                    ),
                  ),
                )
          
          
              ]
            ),
          ),
        ],
      )
    );
  }
}