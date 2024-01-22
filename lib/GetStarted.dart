import 'package:schluckspecht_app/GetStartedPages/page1.dart';
import 'package:schluckspecht_app/GetStartedPages/page2.dart';
import 'package:schluckspecht_app/GetStartedPages/page3.dart';
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
            alignment: Alignment(0, 0.75),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SKIP
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text('SKIP'),),
                
                // INDICATOR DOTS
                SmoothPageIndicator(controller: _controller, count: 3),

                onLastPage
                  ?  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      },
                      child: Text('done'),
                    )
                  :  GestureDetector(
                      onTap: () {
                      _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn,);
                      },
                      child: Text('>'),
                    )

                // NEXT PAGE
               
                
              ],
            )

          
          )
           
        ],
      )

      
    );
  }
}

