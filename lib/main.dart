import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupingapp/AverageScreen.dart';
import 'package:groupingapp/RandomScreen.dart';

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
          centerTitle: true,
          
        ),
        body: AverageScreen()
      ),
    );
  }
}


//ランダムでグループ分けをする前に必要事項を入力する画面
