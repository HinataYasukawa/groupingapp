import 'package:flutter/material.dart';

//アプリのメイン画面
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
        centerTitle: true,
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
