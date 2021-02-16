import 'package:flutter/material.dart';

// Since we are using named routes, we must pass them as args into MaterialApp,
// which is our runApp entrypoint.

// By defining the initialRoute (not 'home:' as before with unnamed routes),
// MaterialApp launches our application.

// When navigate to "/" route, build FirstScreen widget.
// When navigate to "/second" route, build SecondScreen widget.
void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
      },
    ),
  );
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Back to first'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
