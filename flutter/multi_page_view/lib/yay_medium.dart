// original code found on:
// https://medium.com/@tonyowen/flutter-pageview-zoom-transition-98c380632b2d
import 'dart:math';
import 'package:flutter/material.dart';

const scaleFraction = 0.7;
const fullScale = 1.0;
const pagerHeight = 216.0;  // HARDCODED to width/5. But we prefer to do:
//    pagerHeight = MediaQuery.of(context).size.width / 5.

class AdvancedPageViewScreen extends StatefulWidget {
  @override
  _AdvancedPageViewScreenState createState() => _AdvancedPageViewScreenState();
}

class _AdvancedPageViewScreenState extends State<AdvancedPageViewScreen> {
  int currentPage = 5;  // Keep index of currently snapped page.
  double page = 5.0;  // Track page position when between snaps.
  double viewportFraction = 0.5;
  PageController pageController;

  List<Map<String, String>> icons = [
    {'image': "assets/art_400.png", 'object': "Art"},
    {'image': "assets/bed_500.png", 'object': "Bed"},
    {'image': "assets/curtains_120.png", 'object': "Curtains"},
    {'image': "assets/desk.png", 'object': "Desk"},
    {'image': "assets/dresser_110.png", 'object': "Dresser"},
    {'image': "assets/lamp_20r.png", 'object': "Lamp"},
    {'image': "assets/nightstand_110.png", 'object': "Nightstand"},
    {'image': "assets/seating_175.png", 'object': "Seating"},
    {'image': "assets/sink.png", 'object': "Sink"},
    {'image': "assets/toilet.png", 'object': "Toilet"},
    {'image': "assets/other_350.png", 'object': "Other"},
  ];

  @override
  void initState() {
    pageController = PageController(
        initialPage: currentPage, viewportFraction: viewportFraction);
    super.initState();
  }

  Widget circleOffer(String image, double scale) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: pagerHeight * scale,
        width: pagerHeight * scale,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: CircleBorder(
              side: BorderSide(color: Colors.grey.shade200, width: 5)),
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Advanced PageView",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(height: 20),
          Container(
            height: pagerHeight,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    page = pageController.page;
                  });
                  return true;
                }
                return false; // DartAnalyzer complains if no return val.
              },
              child: PageView.builder(
                onPageChanged: (pos) {
                  setState(() {
                    currentPage = pos;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  final scale = max(scaleFraction, (fullScale - (index - page).abs()) + viewportFraction);
                  return circleOffer(icons[index]['image'], scale);
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: 
            Text(
              icons[currentPage]['object'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          // ),
        ],
      ),
    );
  }
}
