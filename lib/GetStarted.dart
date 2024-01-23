import 'package:schluckspecht_app/Feed.dart';
import 'package:schluckspecht_app/GetStartedPages/page1.dart';
import 'package:schluckspecht_app/GetStartedPages/page2.dart';
import 'package:schluckspecht_app/GetStartedPages/page3.dart';
import 'package:schluckspecht_app/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'AppThemes.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  GetStarted({super.key});

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  PageController _controller = PageController();

  bool onLastPage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          
          
          Container(
            alignment: const Alignment(0, 0.9),
            child: 
                onLastPage
                  // GET STARTED
                  ?  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(
                            builder: (context) {
                              return OpenMainpage();
                           },   
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppCardStyle.borderRadiusValue),
                        ),
                        backgroundColor: AppColors.primaryRed, 
                        minimumSize: Size(300, 40),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white, fontSize: AppTextStyle.largeFontSize), 
                      ),
                    )

                    // BOTTOM BAR
                  :  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        //SKIP
                        GestureDetector(
                           onTap: () {
                            _controller.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500), 
                              curve: Curves.easeInOut,  
                            );
                            
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: AppColors.secondaryFontColor,
                              fontSize: AppTextStyle.largeFontSize,
                            ),
                          ),
                        ),
                
                        // INDICATOR DOTS
                        SmoothPageIndicator(
                          controller: _controller, 
                          count: 3,
                          effect: ExpandingDotsEffect(
                            spacing:  10.0,  
                            dotWidth:  10.0,  
                            dotHeight:  10.0,   
                            dotColor:  AppColors.secondaryFontColor,  
                            activeDotColor:  AppColors.primaryRed, 
                          ),
                        ),

                         // NEXT PAGE
                        TextButton(
                          onPressed: () { 
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500), 
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Icon(
                            Icons.navigate_next,
                            color: AppColors.primaryRed,
                            size: 35,
                          )
                        ),
                      ],
                    )
          )                     
        ],
      )
    );
  }
}

