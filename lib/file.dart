import 'dart:io';
import 'dart:async';
import 'dart:convert';

// pathで与えられたファイルを読み込む関数
Future<List<List>> read_file(String path) async {
  final String importPath = path;
  final File importFile = File(importPath);
  List<List> importList = [];

  Stream fread = importFile.openRead();

  // Read lines one by one, and split each ','
  await fread.transform(utf8.decoder).transform(LineSplitter()).listen(
    (String line) {
      importList.add(line.split(','));
    },
  ).asFuture();

  return Future<List<List>>.value(importList);
}

// 行と列を入れ替える関数
Future<List<List>> replace_row_column(List<List> data) async {
  int col_len = data.length;
  if (col_len <= 0) {
    return Future<List<List>>.value(data);
  }
  int row_len = data[0].length;
  List<List> ret = List.generate(row_len, (index) => List.filled(col_len, ''));
  for (int i = 0; i < col_len; i++) {
    for (int j = 0; j < row_len; j++) {
      ret[j][i] = data[i][j];
    }
  }
  return (ret);
}

void main() async {
  final csv = await read_file('TestFile.csv');
  print(csv);
  final csv2 = await replace_row_column(csv);
  print(csv2);
}
