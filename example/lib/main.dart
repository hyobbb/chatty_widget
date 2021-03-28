import 'package:flutter/material.dart';
import 'package:chatty_widget/chatty_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatty Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChattyWidget(
                  child: Container(
                      width: 100,
                      height: 50,
                      color: Colors.yellow,
                      child: Center(child: Text('Container'))),
                  text: 'Here is your chat box from top',
                  textBoxColor: Colors.green,
                  chatBoxLocation: BoxLocation.Top,
                ),
                ChattyWidget(
                  child: Text('Just Text'),
                  text: 'Here is your chat box with stroke',
                  textBoxColor: Colors.white,
                  chatBoxStrokeColor: Colors.black,
                  chatBoxStrokeWidth: 3.0,
                  chatBoxLocation: BoxLocation.Bottom,
                ),
                ChattyWidget(
                  child: Icon(Icons.anchor),
                  text: 'Here is your chat box from top',
                  textStyle: TextStyle(color: Colors.white),
                  textBoxColor: Colors.black,
                  chatBoxLocation: BoxLocation.Top,
                  chatBoxWidth: 100,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(count.toString()),
                ChattyWidget(
                  child: Icon(Icons.add),
                  text: 'This will increase count',
                  textStyle: TextStyle(color: Colors.white),
                  textBoxColor: Colors.black,
                  chatBoxLocation: BoxLocation.Top,
                  chatBoxWidth: 100,
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  },
                ),
                ChattyWidget(
                  child: Icon(Icons.remove),
                  text: 'This will decrease count',
                  textStyle: TextStyle(color: Colors.white),
                  textBoxColor: Colors.black,
                  chatBoxLocation: BoxLocation.Top,
                  chatBoxWidth: 100,
                  onTap: () {
                    setState(() {
                      count--;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
