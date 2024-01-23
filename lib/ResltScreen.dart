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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: list.map((item) => TextField(
              controller: TextEditingController(text: item.toString()),
            )).toList()
          ),
        ),
      ),
    );;
  }
}