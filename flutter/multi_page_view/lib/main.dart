import 'dart:math';
import 'package:flutter/material.dart';
import './yay_medium.dart';
import './ugh.dart';

void main() {
  runApp(MaterialApp(
    title: 'Multi-page-view carousels',
    // home: Demo1(),
    home: DemoScreen(),
    // home: AdvancedPageViewScreen(),
  ));
}

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _itemWidth = MediaQuery.of(context).size.width / 5;
    final carousel = Carousel();

    return Scaffold(
      appBar: AppBar(title: Text('demo')),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset('assets/images/img_3.jpg'),
          Container(height: 20), // Push Carousel up by 20 px
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: carousel,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: RawMaterialButton(
              shape: CircleBorder(
                side: BorderSide(width: _itemWidth * .025, color: Colors.white),
              ),
              elevation: 2.0,
              child: SizedBox(height: _itemWidth, width: _itemWidth),
              onPressed: () {
                // DoStuff
              },
            ),
          ),
          // Container(height: 20, width: 20, color: Colors.red,),
          // Text(
          //   carousel.currentIcon.objectText,
          //   style: TextStyle(fontSize: 20, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  // NOTE: if you use this constructor, use 'widget.icons' in the state class.
  // final icons;
  // Carousel()
  //     : this.icons = <CarouselIcon>[
  //         CarouselIcon('assets/art_400.png', 'Art'),
  //         CarouselIcon('assets/bed_500.png', 'Bed'),
  //         CarouselIcon('assets/curtains_120.png', 'Curtains'),
  //         CarouselIcon('assets/desk.png', 'Desk'),
  //         CarouselIcon('assets/dresser_110.png', 'Dresser'),
  //         CarouselIcon('assets/lamp_20r.png', 'Lamp'),
  //         CarouselIcon('assets/nightstand_110.png', 'Nightstand'),
  //         CarouselIcon('assets/seating_175.png', 'Seating'),
  //         CarouselIcon('assets/sink.png', 'Sink'),
  //         CarouselIcon('assets/toilet.png', 'Toilet'),
  //         CarouselIcon('assets/other_350.png', 'Other'),
  //       ];

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentPage = 5;

  final icons = <CarouselIcon>[
    CarouselIcon('assets/art_400.png', 'Art'),
    CarouselIcon('assets/bed_500.png', 'Bed'),
    CarouselIcon('assets/curtains_120.png', 'Curtains'),
    CarouselIcon('assets/desk.png', 'Desk'),
    CarouselIcon('assets/dresser_110.png', 'Dresser'),
    CarouselIcon('assets/lamp_20r.png', 'Lamp'),
    CarouselIcon('assets/nightstand_110.png', 'Nightstand'),
    CarouselIcon('assets/seating_175.png', 'Seating'),
    CarouselIcon('assets/sink.png', 'Sink'),
    CarouselIcon('assets/toilet.png', 'Toilet'),
    CarouselIcon('assets/other_350.png', 'Other'),
  ];

  CarouselIcon get currentIcon => icons[currentPage];

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 5;

    return SizedBox(
      height: itemWidth,
      child: PageView(
          // pageSnapping: false,  // set to false for custom scrolls
          physics: BouncingScrollPhysics(),
          controller: PageController(
            viewportFraction: 1 / 5,
            initialPage: currentPage,
          ),
          children: icons),
    );
  }
}

class CarouselIcon extends StatelessWidget {
  final String assetFilepath;
  final String _objectText;
  CarouselIcon(this.assetFilepath, this._objectText);

  String get objectText => _objectText;

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 5;
    final radius = itemWidth / 2;

    return Padding(
      padding: EdgeInsets.all(itemWidth * 0.05), // Take 2x this off child cont.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: itemWidth,
          width: itemWidth,
          color: Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.all(itemWidth * 0.0375),
          child: Image.asset(assetFilepath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
