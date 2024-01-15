import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final title = 'Grouping App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text(this.title),
          
        ),
        body: MainScreen()
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Grouping App'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('説明'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ElevatedButton(
                onPressed: pressedA, 
                child: const Text('Random')
                ),
              ElevatedButton(
                onPressed: pressedB, 
                child: const Text('Average')
                ),
              ElevatedButton(
                onPressed: pressedC, 
                child: const Text('Approximation')
                )
              ]
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('説明:Random'),
                Text('説明:Average'),
                Text('説明:Approximation')
              ]
            )
          ]
        )
      )
    );
  }

  void pressedA(){
    print('pressed Random!');
  }

  void pressedB(){
    print('pressed Average!');
  }

  void pressedC(){
    print('pressed Approximation!');
  }
}

class RandomScreen1 extends StatefulWidget {
  const RandomScreen1({super.key});

  @override
  State<RandomScreen1> createState() => _RandomScreen1State();
}

class _RandomScreen1State extends State<RandomScreen1> {
  get textChanged => null;

  @override
  Widget build(BuildContext cotext) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Random')
        ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('人数'),
                TextField(
                  onChanged: textChanged,
                  controller: TextEditingController(),
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"
                    ),
                  ),
              ]
            ),

            ],
          )
        )
      );
  }
}