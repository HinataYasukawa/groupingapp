import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApproximationScreen extends StatefulWidget {
  const ApproximationScreen({Key? key}) : super(key: key);

  @override
  State<ApproximationScreen> createState() => _AverageScreenState();
}

class _AverageScreenState extends State<ApproximationScreen> {
  get textChanged => null;

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  File? file;//読み込んだファイルを格納する
  String fileName = '';//読み込んだファイル名を格納する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approximation'),
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
                  onPressed: pickFile, 
                  child: Text('CSVファイルを選択')
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: fileName),
                  )
                )
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
                    controller: controller1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'グループ数を入力',
                    ),
                  ),
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('変数の数'),
                SizedBox(
                  width:200,
                  child: TextField(
                    controller: controller2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '変数の数を入力',
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
    int group = int.parse(controller1.text);
    int variable = int.parse(controller2.text);
    print('グループ数: $group, 変数の数: $variable');
  }

//テキストフィールドの入力を削除する関数
  void dispose(){
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

//ファイルを読み込むための関数 エクスプローラーなどを起動する
  Future<void> pickFile() async {
    //現在はCSVファイルのみを読み込むことができるようにしている
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if(result != null){
      setState((){
        fileName = result.files.single.name;
        file = File(result.files.single.path!);
      });
    }else{
      setState((){
        fileName = 'Please pick a CSV file.';
      });
    }
  }
}
