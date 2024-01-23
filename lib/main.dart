import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupingapp/ApproximationScreen.dart';
import 'package:groupingapp/BalancedScreen.dart';
import 'package:groupingapp/MainScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:groupingapp/RandomScreen.dart';
import 'package:groupingapp/ResltScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(){

  runApp(ProviderScope(child: MyApp()));
}

final listProvider = StateProvider<List<int>>(
  (ref){
    return [];
  }
);

//アプリを実行する関数
class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/Main',
      routes: [
        GoRoute(
          path: '/Main',
          builder: (context, state) => MainScreen(),
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
        ),
        GoRoute(
          path: '/Result',
          builder: (context, state) => ResultScreen(),
        )
      ]
    );
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}