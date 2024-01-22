import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupingapp/ApproximationScreen.dart';
import 'package:groupingapp/BalancedScreen.dart';
import 'package:groupingapp/MainScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:groupingapp/RandomScreen.dart';

void main(){
  runApp(MyApp());
}

//アプリを実行する関数
class MyApp extends StatelessWidget {
   MyApp({super.key});
  final title = 'Grouping App';
  final router = GoRouter(
    initialLocation: '/Main',
    routes: [
      GoRoute(
        path: '/Main',
        builder: (context, state) => MainScreen()
      ),
      GoRoute(
        path: '/Random',
        builder: (context, state) => RandomScreen(),
      ),
      GoRoute(
        path: '/Balanced',
        builder: (context, state) => BalancedScreen(),
      ),
      GoRoute(
        path: '/Approximation',
        builder: (context,state) => ApproximationScreen(),
      )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}


//ランダムでグループ分けをする前に必要事項を入力する画面
