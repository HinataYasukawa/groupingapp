import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MyApp());
}

//アプリを実行する関数
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
        body: RandomScreen1()
      ),
    );
  }
}

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

//ランダムでグループ分けをする前に必要事項を入力する画面
class RandomScreen1 extends StatefulWidget {
  const RandomScreen1({Key? key}) : super(key: key);

  @override
  State<RandomScreen1> createState() => _RandomScreen1State();
}

class _RandomScreen1State extends State<RandomScreen1> {
  get textChanged => null;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random')
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('人数'),
                SizedBox(
                  width:200,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '人数を入力',
                    ),
                  ),
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('グループ数'),
                SizedBox(
                  width:200,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'グループ数を入力',
                    ),
                  ),
                ),
              ]
            ),
            ElevatedButton(
                onPressed: pressedExe, 
                child: Text('実行')
            ),
          ],
        )
      ),
    );
  }

  void pressedExe(){
    print("pressed 実行!");
  }
}
