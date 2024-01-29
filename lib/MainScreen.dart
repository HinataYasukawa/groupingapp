import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        backgroundColor: Colors.cyan[700],
        title: const Text(
          'Grouping App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'このサイトはグループ分けをするためのサイトです。\n全体の人数および、各グループの人数を指定し、ランダムにグループ分け、csvファイルを読み込ませることで実力に近い順でグループ分け、実力が均等になるようにグループ分けをする三つのグループ分けの方法があります。\n人数が多い場合は、グループ分けに時間がかかることがありますのでご容赦ください。\n結果はこのサイト上でも確認できますが、csvファイルもダウンロードが可能です。是非ご活用ください。',
              textAlign: TextAlign.center,
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: pressedA, 
                    child: const Text(
                      'ランダムに\nグループ分け',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                    )
                  ),
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: pressedB, 
                    child: const Text(
                      '総合力を均等に\nグループ分け',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                    )
                  ),
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: pressedC, 
                    child: const Text(
                      'メンバーの能力を同質に\nグループ分け',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                    )
                  ),
                ],
              )
              
              ]
            ),
          ]
        )
      )
    );
  }

  void pressedA(){
    print('pressed Random!');
    context.push('/Random');
  }

  void pressedB(){
    print('pressed Balanced!');
    context.push('/Balanced');
  }

  void pressedC(){
    print('pressed Approximation!');
    context.push('/Approximation');
  }
}
