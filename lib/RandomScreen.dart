import 'package:flutter/material.dart';
import 'dart:io';

class RandomScreen1 extends StatefulWidget {
  const RandomScreen1({Key? key}) : super(key: key);

  @override
  State<RandomScreen1> createState() => _RandomScreen1State();
}

class _RandomScreen1State extends State<RandomScreen1> {
  get textChanged => null;

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random'),
        centerTitle: true,
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
                    controller: controller1,
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
                    controller: controller2,
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
    int count = int.parse(controller1.text);
    int group = int.parse(controller2.text);
    print('人数: $count, グループ数: $group');
  }

//テキストフィールドの入力を削除する関数
  void dispose(){
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}