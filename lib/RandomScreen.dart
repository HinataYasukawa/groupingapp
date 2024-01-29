import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:groupingapp/ResltScreen.dart';
import 'dart:io';

import 'package:groupingapp/clustering.dart';
import 'package:groupingapp/main.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  State<RandomScreen> createState() => _RandomScreen1State();
}

class _RandomScreen1State extends State<RandomScreen> {
  get textChanged => null;

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Random',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
                    width: 200,
                    child: TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '人数を入力',
                      ),
                    ),
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('グループ数'),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'グループ数を入力',
                    ),
                  ),
                ),
              ]),
            Consumer(builder: (context, ref, child){
              return ElevatedButton(onPressed: () {//ボタンを押した時の処理↓
                final notifier = ref.read(listProvider.notifier);
                print("pressed 実行!");
                int count = int.parse(controller1.text);
                int group = int.parse(controller2.text);
                print('人数: $count, グループ数: $group');
                notifier.state = select_random_grouping(count, group);
                context.push('/Result');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(),
                  )
                );
              }, child: Text('実行'));
            })
          ],
        )
      ),
    );
  }

//テキストフィールドの入力を削除する関数
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
