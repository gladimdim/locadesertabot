import 'package:flutter/material.dart';
import 'package:teledart/telegram.dart';
import 'package:uibot/bot/server.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Bot UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Telegram Bot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Telegram bot;

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Server server = Server();

  _startBot() async {
    await server.startBot();
  }

  _stopBot() {
    server.stopBot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Last events: ",
              style: TextStyle(fontSize: 22),
            ),
            StreamBuilder(
              stream: server.changes,
              initialData: "Started",
              builder: (context, snapshot) {
                return Column(
                  children: server.lastChanges.toList().map((text) {
                    return Text(text);
                  }).toList(),
                );
              },
            ),
            Text("Control", style: TextStyle(fontSize: 25)),
            FlatButton(
              child: Text("Start"),
              onPressed: _startBot,
            ),
            FlatButton(
              child: Text("Stop"),
              onPressed: _stopBot,
            ),
          ],
        ),
      ),
    );
  }
}
