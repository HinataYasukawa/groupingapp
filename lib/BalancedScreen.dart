import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:groupingapp/ResltScreen.dart';
import 'package:groupingapp/clustering.dart';
import 'package:groupingapp/main.dart';

class BalancedScreen extends StatefulWidget {
  const BalancedScreen({Key? key}) : super(key: key);

  @override
  State<BalancedScreen> createState() => _AverageScreenState();
}

class _AverageScreenState extends State<BalancedScreen> {
  get textChanged => null;

  final controller1 = TextEditingController();

  String file = ''; //読み込んだファイルパスを格納する
  String fileName = ''; //読み込んだファイル名を格納する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Balanced',
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
                    ElevatedButton(
                        onPressed: pickFile, child: Text('CSVファイルを選択')),
                    SizedBox(
                        width: 200,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: fileName),
                        ))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('グループ数'),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'グループ数を入力',
                        ),
                      ),
                    ),
                  ]),
                Consumer(builder: (context, ref, child){
                  return ElevatedButton(onPressed: () async {
                    final notifier = ref.read(listProvider.notifier);
                    print("pressed 実行!");
                    int group = int.parse(controller1.text);
                    print('グループ数: $group');
                    notifier.state = await select_ballance_grouping(file, group);
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
          )),
    );
  }

//テキストフィールドの入力を削除する関数
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

//ファイルを読み込むための関数 エクスプローラーなどを起動する
  Future<void> pickFile() async {
    //現在はCSVファイルのみを読み込むことができるようにしている
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        file = result.files.single.path!;
      });
    } else {
      setState(() {
        fileName = 'Please pick a CSV file.';
      });
    }
  }
}
