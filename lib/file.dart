import 'dart:io';
import 'dart:convert';

// pathで与えられたファイルを読み込む関数
List<List<String>> read_file(String path) {
  final String importPath = path;
  final File file = File(importPath);
  List<List<String>> ret = [];

  try {
    // 同期的にファイルを文字列として読み込む
    final lines = LineSplitter.split(file.readAsStringSync());

    for (final line in lines) {
      ret.add(line.split(','));
    }
    return ret;
  } catch (e) {
    print('エラー：$e');
    return [];
  }
}

// 行と列を入れ替える関数
List<List<String>> replace_row_column(List<List<String>> data) {
  int col_len = data.length;
  if (col_len <= 0) {
    return data;
  }
  int row_len = data[0].length;
  List<List<String>> ret =
      List.generate(row_len, (index) => List.filled(col_len, ''));
  for (int i = 0; i < col_len; i++) {
    for (int j = 0; j < row_len; j++) {
      ret[j][i] = data[i][j];
    }
  }
  return (ret);
}

// n人をtarget個のグループにランダムに割り振る関数

void main() {
  final csv = read_file('TestFile.csv');
  print(csv);
}
