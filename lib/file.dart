import 'dart:io';
import 'dart:convert';
import 'dart:math';

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

// 文字列データである特徴量群dataについて、整数型の特徴量群に整形する関数
List<List<int>> format_data(List<List<String>> data) {}

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

// target人に対して、前から順に1~groupの番号を割り振る関数
List<int> do_order_grouping(int target, int group) {
  List<int> ret = [];
  int cnt = 1;
  for (int i = 0; i < target; i++) {
    ret.add(cnt);
    cnt = (cnt % group) + 1;
  }
  return ret;
}

// target人をgroup個のグループにランダムに割り振る関数
List<int> do_random_grouping(int target, int group) {
  var rand = Random();
  List<int> ret;

  // 一時的に1~groupの番号を割り振る
  ret = do_order_grouping(target, group);
  // 場所を入れ替えてランダムっぽくする
  int max_swap = 10000;
  for (int i = 0; i < max_swap; i++) {
    int tmp, i1 = rand.nextInt(target), i2 = rand.nextInt(target);
    tmp = ret[i1];
    ret[i1] = ret[i2];
    ret[i2] = tmp;
  }
  return ret;
}

// 特徴量dataを基にクラスター分析を行い、そこからグループごとの能力が均等になるように割り振る関数
List<int> do_balance_grouping(List<List<int>> data, int group) {
  // クラスター分析の結果を取得
  List<int> cls = do_cluster_analysis(data, group);
}

// 特徴量dataを基にクラスター分析を行い、そこからメンバーの能力が近くなるように割り振る関数
List<int> do_nearing_grouping(List<List<int>> data, int group) {
  // クラスター分析の結果を取得
  List<int> cls = do_cluster_analysis(data, group);
}

// 特徴量dataを基にクラスター数groupでクラスター分析を行う関数
List<int> do_cluster_analysis(List<List<int>> data, int group) {
  // ここでpythonを呼び出してクラスター分析を実施
  // List<int> res = execute(ClusterAnalysis.py); <- ここ嘘なので直して
  // return res;
  return [];
}

void main() {
  final csv = read_file('TestFile.csv');
  print(csv);
  /*print(do_random_grouping(10, 3));*/
}
