import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Pulse Animator",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool hideFeature1;
  TextStyle _titleSix, _bodyTwo;

  @override
  void initState() {
    super.initState();
    hideFeature1 = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleSix =
          Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);
      _bodyTwo =
          Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(title: Text("Animationators")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ramen_dining, size: 30),
        onPressed: () {
          setState(() {
            hideFeature1 = !hideFeature1;
          });
        },
      ),
      body: Stack(
        children: [
          Align(child: Slider()),
          // Center(child: PulsatingButton(size: 56)),
          // Fader(
          //   child: Container(
          //     width: 30,
          //     height: 30,
          //     color: Colors.white,
          //   ),
          // ),
          hideFeature1
              ? Container()
              : Align(
                  alignment: Alignment(0, -0.7),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return IgnorePointer(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: constraints.maxWidth * 0.15,
                              right: constraints.maxWidth * 0.15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.blue[700].withOpacity(0.9),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Placing Labels: 1", style: _titleSix),
                                Text(
                                    "\nDrag from the center crosshair " +
                                        "to move the label region.\n",
                                    style: _bodyTwo),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

/// Slider things

class Slider extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    // controller = AnimationController(
    //   duration: Duration(seconds: 3),
    //   vsync: this,
    // )..addListener(() => setState(() {}));
    // animation = Tween(begin: -500.0, end: 500.0).animate(controller);
    // controller.forward();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
    )..repeat(reverse: true);

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlider(animation: animation);
  }
}

class AnimatedSlider extends AnimatedWidget {
  AnimatedSlider({
    Key key,
    @required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Transform.translate(
      offset: Offset(animation.value * 250 - 125, 0),
      child: Container(width: 45, height: 45, color: Colors.black),
    );
  }
}

/// Fader things

class Fader extends StatefulWidget {
  final Widget child;

  Fader({@required this.child});

  @override
  State<StatefulWidget> createState() => FaderState();
}

class FaderState extends State<Fader> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 2,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFader(animation: controller, child: widget.child);
  }
}

class AnimatedFader extends AnimatedWidget {
  final Widget child;

  AnimatedFader({
    Key key,
    @required Animation<double> animation,
    @required this.child,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Opacity(
      opacity: animation.value < 1 ? 0 : animation.value - 1,
      child: child,
    );
  }
}

/// Pulsing button things

class PulsatingButton extends StatefulWidget {
  final double size;

  PulsatingButton({Key key, @required this.size}) : super(key: key);

  @override
  _PulsatingButtonState createState() => _PulsatingButtonState();
}

class _PulsatingButtonState extends State<PulsatingButton>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 2,
    );

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPulsatingButton(
      animation: controller,
      size: widget.size,
    );
  }
}

class AnimatedPulsatingButton extends AnimatedWidget {
  final double size;

  AnimatedPulsatingButton({
    Key key,
    @required Animation<double> animation,
    @required this.size,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Stack(
      alignment: Alignment.center,
      children: [
        // When reversed, display a growing white underlay that fades out.
        animation.status != AnimationStatus.reverse
            ? Container()
            : Container(
                width: animation.value < 1 ? 0 : size * (4 - animation.value),
                height: animation.value < 1 ? 0 : size * (4 - animation.value),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(
                    animation.value < 1 ? 0 : animation.value - 1,
                  ),
                ),
              ),
        // Display the primary pulsing button.
        Container(
          width: animation.value < 1 ? size : size * animation.value,
          height: animation.value < 1 ? size : size * animation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}
