import 'dart:math';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  static int currentPage = 5; // Keep index of currently snapped page.
  static double page = 5.0; // Track page position when between snaps.

  // These consts handle the sizing and number of label buttons in the carousel.
  static const fullScale = 1.0;
  static const scaleFraction = 0.75;
  static const viewportFraction = 1 / 5;

  final pageController =
      PageController(initialPage: 5, viewportFraction: viewportFraction);
  final List<Map<String, String>> icons = [
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
  Widget build(BuildContext context) {
    final itemHeight = MediaQuery.of(context).size.width * viewportFraction;

    return Scaffold(
      appBar: AppBar(title: Text('demo')),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset('assets/images/img_3.jpg'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              height: itemHeight,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    setState(() {
                      page = pageController.page;
                    });
                  }
                  return false; // DartAnalyzer complains if no return val.
                },
                child: PageView.builder(
                  // pageSnapping: ,
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    // This handles dynamic sizing based on position. 
                    final scale = max(scaleFraction,
                        (fullScale - (index - page).abs()) + viewportFraction);
                    return Container(
                      height: itemHeight * scale,
                      width: itemHeight * scale,
                      alignment: Alignment.bottomCenter,
                      // Before scaling, this line is what created separation b/w buttons.
                      // padding: EdgeInsets.all(itemHeight * 0.05),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(itemHeight / 2),
                        child: Container(
                          height: itemHeight * scale,
                          width: itemHeight * scale,
                          color: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0.0375 * itemHeight * scale), // 15% pad
                          child: (Image.asset(icons[index]['image'], fit: BoxFit.cover)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: RawMaterialButton(
              shape: CircleBorder(
                side: BorderSide(width: itemHeight * .05, color: Colors.purple),
              ),
              elevation: 2.0,
              child: SizedBox(height: itemHeight, width: itemHeight),
              onPressed: () {
                // DoStuff
              },
            ),
          ),
          Text(
            icons[currentPage]['object'],
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
