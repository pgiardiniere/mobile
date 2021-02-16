import 'dart:math' as math;
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final Future<void> Function() takePhotoCallback;

  Carousel({Key key, @required this.takePhotoCallback}) : super(key: key);

  @override
  State<Carousel> createState() => CarouselState();

  /// Label carousel icon art and descriptive text.
  static const List<Map<String, String>> iconMap = [
    {'image': "assets/art_300.png", 'object': "Art"},
    {'image': "assets/bed_300.png", 'object': "Bed"},
    {'image': "assets/curtains_300.png", 'object': "Curtains"},
    {'image': "assets/desk_300.png", 'object': "Desk"},
    {'image': "assets/dresser_300.png", 'object': "Dresser"},
    {'image': "assets/lamp_300.png", 'object': "Lamp"},
    {'image': "assets/nightstand_300.png", 'object': "Nightstand"},
    {'image': "assets/seating_300.png", 'object': "Seating"},
    {'image': "assets/sink_300.png", 'object': "Sink"},
    {'image': "assets/toilet_300.png", 'object': "Toilet"},
    {'image': "assets/other_300.png", 'object': "Other"},
  ];
}

class CarouselState extends State<Carousel> {
  // These consts handle sizing and number of label buttons in the carousel.
  static const fullScale = 1.0;
  static const scaleFraction = 0.75;
  static const viewportFraction = 1 / 5;

  final pageController = PageController(
    initialPage: currentPage,
    viewportFraction: viewportFraction,
  );

  /// Keep index of currently snapped page.
  static int currentPage = 5;
  set intPage(int n) => currentPage = n;

  /// Track page position when between snaps.
  static double page = 5.0;
  set doublePage(double x) => page = x;

  /// Toggle for button highlight fill.
  bool _buttonIsBlue;

  /// Toggle to prevent button presses from throwing exceptions.
  bool _photoButtonDisabled;

  @override
  void initState() {
    super.initState();
    _buttonIsBlue = false;
    _photoButtonDisabled = false;
  }

  /// onTapDown: The moment a pointer hits screen.
  void _onTapDown(TapDownDetails details) {
    if (!_photoButtonDisabled)
      setState(() {
        _buttonIsBlue = true;
      });
  }

  /// onTapUp: A pointer successfully completed the tap gesture.
  Future<void> _onTapUp(TapUpDetails details) async {
    await Future.delayed(Duration(milliseconds: 150));
    setState(() {
      _buttonIsBlue = false;
    });
  }

  /// onTapCancel: Execute after onTapDown if tap becomes incomplete.
  void _onTapCancel() {
    setState(() {
      _buttonIsBlue = false;
    });
  }

  /// onTap: Called immediately after onTapUp is called
  Future<void> _onTap() async {
    setState(() {
      _photoButtonDisabled = true;
    });
    await widget.takePhotoCallback();
    setState(() {
      _photoButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        // First element is the underlying carousel.
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemHeight = constraints.maxWidth * viewportFraction;
              return SizedBox(
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
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemCount: Carousel.iconMap.length,
                    itemBuilder: (context, index) {
                      // This handles dynamic sizing based on position.
                      double scale = math.max(
                        scaleFraction,
                        (fullScale - (index - page).abs()) + viewportFraction,
                      );
                      return Container(
                        height: itemHeight * scale,
                        width: itemHeight * scale,
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            itemHeight / 2,
                          ),
                          child: Container(
                            height: itemHeight * scale,
                            width: itemHeight * scale,
                            color: Color.fromARGB(255, 255, 255, 255),
                            padding: // 15% pad
                                EdgeInsets.all(0.0375 * itemHeight * scale),
                            child: Image.asset(
                              Carousel.iconMap[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        // Second element is the button.
        //
        // Because we need gesture pass-through, can't use RawMaterialButton/InkWell.
        // Have to define a box with the following gestures:
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final buttonSize = constraints.maxWidth * viewportFraction;

              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                onTap: _photoButtonDisabled ? null : _onTap,
                onTapCancel: _onTapCancel,
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(buttonSize / 2),
                    child: AnimatedContainer(
                      width: buttonSize,
                      height: buttonSize,
                      curve: Curves.easeOut,
                      duration: Duration(milliseconds: 150),
                      color: _buttonIsBlue
                          ? Colors.blue[700].withOpacity(0.8)
                          : Colors.transparent,
                      // Used to be inkwell, now this is just for the border
                      child: Material(
                        color: Colors.transparent,
                        shape: CircleBorder(
                          side: BorderSide(
                              width: buttonSize * 0.03, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Third element is the object text.
        Text(
          Carousel.iconMap[currentPage]['object'],
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
