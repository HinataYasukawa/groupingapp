import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

const int SHUFFLE_NUM = 10000;

class Cluster {
  // メンバ変数
  int member_cnt = 0; // クラスターに属している人数
  List<int> member = []; // クラスターに属する人の番号やID

  int get_member_cnt() {
    return member_cnt;
  }

  List<int> get_member() {
    return member;
  }

  int get_member_by_index(int index) {
    // indexは0-indexとする
    if (index < member_cnt) {
      return member[index];
    } else {
      return -1;
    }
  }

  int get_first_member() {
    return get_member_by_index(0);
  }

  int get_last_member() {
    return get_member_by_index(member_cnt - 1);
  }

  void add_member_by_id(int id) {
    member_cnt++;
    member.add(id);
    return;
  }

  void add_member_by_list(List<int> lis) {
    for (int i = 0; i < lis.length; i++) {
      member.add(lis[i]);
      member_cnt++;
    }
    return;
  }

  bool remove_member_by_id(int id) {
    bool ret = member.remove(id);
    if (ret) {
      member_cnt--;
    }
    return ret;
  }

  bool remove_member_by_index(int index) {
    // indexは0-indexとする
    if (index < member_cnt) {
      member.removeAt(index);
      return true;
    } else {
      return false;
    }
  }

  bool remove_first_member() {
    return remove_member_by_index(0);
  }

  bool remove_last_member() {
    return remove_member_by_index(member_cnt - 1);
  }

  void shuffle_member() {
    var rand = Random();
    int i1, i2, tmp;
    for (int i = 0; i < SHUFFLE_NUM; i++) {
      i1 = rand.nextInt(member_cnt);
      i2 = rand.nextInt(member_cnt);
      tmp = member[i1];
      member[i1] = member[i2];
      member[i2] = tmp;
    }
    return;
  }

  void clear() {
    member_cnt = 0;
    member.clear();
    return;
  }
}

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
  for (int i = 0; i < SHUFFLE_NUM; i++) {
    int tmp, i1 = rand.nextInt(target), i2 = rand.nextInt(target);
    tmp = ret[i1];
    ret[i1] = ret[i2];
    ret[i2] = tmp;
  }
  return ret;
}

// 特徴量dataを基にクラスター分析を行い、そこからグループごとの能力が均等になるように割り振る関数
List<int> do_balance_grouping(int target, List<List<int>> data, int group) {
  // クラスター分析の結果を取得（グループごとに別のリストに格納）
  List<List<int>> analysis_result =
      divide_member_by_group(do_cluster_analysis(data, group), group);
  // 結果をClusterクラスに落とし込む
  List<Cluster> cluster = [];
  for (int i = 0; i < group; i++) {
    Cluster tmp = Cluster();
    tmp.add_member_by_list(analysis_result[i]);
    cluster.add(tmp);
  }
  // 実際にグループ分けしていく
  List<Cluster> ret = [];
  for (int i = 0; i < group; i++) {
    // 初期化
    ret.add(Cluster());
  }
  // 全グループに割り振れるクラスターからのみ割り振る
  int shift = 0;
  Cluster overflow_member = Cluster();
  Queue<int> remain_cluster = Queue();
  for (int i = 0; i < group; i++) {
    cluster[i].shuffle_member(); // 一旦シャッフル
    if (cluster[i].get_member_cnt() >= group) {
      while (cluster[i].get_member_cnt() >= group) {
        for (int j = 0; j < group; j++) {
          ret[(shift + j) % group]
              .add_member_by_id(cluster[i].get_first_member());
          cluster[i].remove_first_member();
        }
        shift++;
      }
      // 残っているメンバーをoverflow_memberに移動
      overflow_member.add_member_by_list(cluster[i].get_member());
      cluster[i].clear();
    } else {
      remain_cluster.add(i);
    }
  }
  // あふれたメンバーで補いつつ、全グループに割り振れないクラスターからも割り振る
  overflow_member.shuffle_member();
  while (remain_cluster.isNotEmpty) {
    int cls = remain_cluster.removeFirst();
    // 足りていない人員をoverflow_memberから補充
    for (int i = cluster[cls].member_cnt; i < group; i++) {
      cluster[cls].add_member_by_id(overflow_member.get_first_member());
      overflow_member.remove_first_member();
    }
    // 割り振り
    for (int i = 0; i < group; i++) {
      ret[(shift + i) % group]
          .add_member_by_id(cluster[cls].get_first_member());
      cluster[cls].remove_first_member();
    }
    shift++;
  }
  if (overflow_member.get_member_cnt() > 0) {
    // まだ割り振れていない人がいるなら割り振る
    for (int i = 0; i < overflow_member.get_member_cnt(); i++) {
      ret[(shift + i) % group]
          .add_member_by_id(overflow_member.get_first_member());
      overflow_member.remove_first_member();
    }
  }
  return convert_cluster_to_list(target, ret);
}

// 特徴量dataを基にクラスター分析を行い、そこからメンバーの能力が近くなるように割り振る関数
List<int> do_nearing_grouping(int target, List<List<int>> data, int group) {
  // クラスター分析の結果を取得（グループごとに別のリストに格納）
  List<List<int>> analysis_result =
      divide_member_by_group(do_cluster_analysis(data, group), group);
  // 結果をClusterクラスに落とし込む
  List<Cluster> cluster = [];
  for (int i = 0; i < group; i++) {
    Cluster tmp = Cluster();
    tmp.add_member_by_list(analysis_result[i]);
    cluster.add(tmp);
  }
  // 実際にグループ分けしていく
  List<Cluster> ret = [];
  for (int i = 0; i < group; i++) {
    // 初期化
    ret.add(Cluster());
  }
  // 実際にグループ分けしていく
}

Future<List<int>> do_cluster_analysis(List<List<int>> data, int group) async {
  // Pythonスクリプトのパス
  const pythonScript = 'ClusterAnalysis.py';

  // Pythonに渡すデータをJSON形式に変換
  var dataJson = jsonEncode({'data': data, 'group': group});

  // Pythonスクリプトを実行
  var result = await Process.run('python', [pythonScript, dataJson]);
  if (result.exitCode != 0) {
    throw Exception('Python script did not execute successfully');
  }

  // 結果を解析
  var output = jsonDecode(result.stdout) as List<dynamic>;
  return output.map<int>((e) => e as int).toList();
  print(output);
}

// クラスター番号ごとにリストを分ける関数
List<List<int>> divide_member_by_group(List<int> group_of_member, int group) {
  List<List<int>> ret = [];
  // 初期化
  for (int i = 0; i < group; i++) {
    ret.add([]);
  }
  // グループごとにメンバーを分ける
  for (int i = 0; i < group_of_member.length; i++) {
    ret[group_of_member[i]].add(i);
  }
  return ret;
}

// Cluster型をList<int>に変換する関数
List<int> convert_cluster_to_list(int target, List<Cluster> lis) {
  List<int> ret = List.filled(target, 0); // 0で初期化
  for (int i = 0; i < lis.length; i++) {
    for (int j = 0; j < lis[i].member_cnt; j++) {
      ret[lis[i].get_member_by_index(j)] = i + 1; // 1-indexに戻す
    }
  }
  return ret;
}

void main() {
  final csv = read_file('TestFile.csv');
  print(csv);
  /*print(do_random_grouping(10, 3));*/
}
