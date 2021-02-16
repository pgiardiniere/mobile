import 'package:flutter/material.dart';

// We have 2 ways of passing/reading arguments through named routes:
//  ModalRoute.of()     Arguments extracted in the widget being navigated to.
//  onGenerateRoute()   Arguments extracted in the onGenerateRoute() func, passed to widget.

// ModalRoute.of() implementation below:
//    ScreenArguments, ExtractArgumentsScreen.

// onGenerateRoute() implementation below:
//    ScreenArguments, PassArgumentsScreen

// General workflow for defining and passing args
//    1) Define arguments to pass in in some class (or another way you like).
//    2) Define destination widget which does something with those args.
//    3) Define a source widget which passes those args when pushing dest onto Navigator stack.
//      3a) onGenerateRoute unpacks args during route generation
//      3b) ModalRoute.of unpacks args during destination widget build
//    4) Register src/dest widgets in your MaterialApp home, routes, onGeneratedRoute sections.

// Just on looking at this sample, my preference is the ModalRoute implementation.
//    We avoid defining constructor/instance vars, and the route is responsible only for navigation.
//    the destination widget stores the current buildcontext settings into a ScreenArguments typed variable.
//    and accesses these exactly how you'd expect.
//    Basically, it's more terse.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation with Arguments',
      home: HomeScreen(),
      // routes demos the ModalRoute.of() way to pass.
      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
      // onGenerateRoute() demos the so-named way to pass.
      onGenerateRoute: (settings) {
        if (settings.name == PassedArgumentsScreen.routeName) {
          final ScreenArguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return PassedArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        // See the online sample code for full description of this assertion.
        // Essentially, it would get thrown elsewhere in the framework, but this
        // is the most appropriate location for it to be thrown.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // RaisedButton pushes a named route that extracts fed arguments itself.
            // i.e. after route generation.
            RaisedButton(
              child: Text("Navigate to screen that extracts arguments"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Extract Arguments Screen',
                    'This message is extracted in the build method.',
                  ),
                );
              },
            ),
            // RaisedButton pushes a named route, where onGenerateRoute extracts fed arguments.
            // i.e. during route generation.
            RaisedButton(
              child:
                  Text("Navigate through named route that unpacks arguments"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassedArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

class PassedArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  const PassedArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
