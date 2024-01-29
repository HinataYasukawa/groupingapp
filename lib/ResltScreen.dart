import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groupingapp/main.dart';
import 'package:path_provider/path_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool listview = true;

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(listProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text(
          'Result',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( 
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                listview ? toStringByGroup(list) : toStringByIndividual(list),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Order by No. : Order by Group'),
                  Switch(value: listview,
                  onChanged: (value){
                    setState((){
                      listview = value;
                    });
                  }),
                  Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(30.0),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: listview ? toStringByGroup(list) : toStringByIndividual(list)));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to clipboard')),
                      );
                    },
                    child: Text('Copy to clipboard'),
                  )),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(30.0),
                    child:
                    ElevatedButton(
                    onPressed: () async {
                      String csvData = listview ? toCsvByGroup(list) : toCsvByIndividual(list);
                      final directory = await getApplicationDocumentsDirectory();
                      final pathOfTheFileToWrite = directory.path + "/myCsvFile.csv";
                      File file = File(pathOfTheFileToWrite);
                      file.writeAsString(csvData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('CSV file saved to $pathOfTheFileToWrite')),
                      );
                    },
                    child: Text('Save to CSV'),
                  ))
                ],
              ),
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
      int j  = i + 1;
      str += '$j: Group$p\n';
    }
    return str;
  }

  String toCsvByIndividual(List<int> list){
    String str = '';
    for(int i = 0; i < list.length; i++){
      final p = list[i];
      int j = i + 1;
      str += '$j,Group$p\n';
    }
    return str; 
  }

  String toStringByGroup(List<int> list){
    String str = '';
    int count = 0;
    int flag = 0;
    for(int i = 1; i <= list.length; i++){
      for(int j = 0; j < list.length; j++){
        if(list[j] == i){
          if(count < list.length){
            str += 'Group $i: ';
            flag++;
          }
          int k = j + 1;
          str += '$k\n';
          count++;
        }
      }
      if(flag < list.length){
        str += '\n';
      }
    }
    return str;
  }
  String toCsvByGroup(List<int> list){
    String str = '';
    int count = 0;
    int flag = 0;
    for(int i = 1; i <= list.length; i++){
      for(int j = 0; j < list.length; j++){
        if(list[j] == i){
          if(count < list.length){
            str += 'Group $i,';
            flag++;
          }
          int k = j + 1;
          str += '$k\n';
          count++;
        }
      }
      if(flag < list.length){
        str += '\n';
      }
    }
    return str;
  }
}

