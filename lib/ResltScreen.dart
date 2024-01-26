import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groupingapp/main.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final list = ref.watch(listProvider);

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.cyan[700],
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: SingleChildScrollView( 
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(toStringByGroup(list))
            ]
          ),
        ),
      ),
    );
  }

  String toStringByIndividual(List<int> list){
    String str = '';
    for(int i = 0; i < list.length; i++){
      final p = list[i];
      str += '$i: Group$p\n';
    }
    return str;
  }

  String toStringByGroup(List<int> list){
    String str = '';
    int count = 0;
    for(int i = 1; i < list.length; i++){
      if(count < list.length){
        str += 'Group $i\n';
      }
      for(int j = 0; j < list.length; j++){
        if(list[j] == i){
          int k = j + 1;
          str += '$k\n';
          count++;
        }
      }
      str += '\n';
    }
    return str;
  }
}