import sys
import json
from sklearn.cluster import KMeans

def do_cluster_analysis(data, group):
    # クラスター分析の実行
    kmeans = KMeans(n_clusters=group)
    kmeans.fit(data)
    return kmeans.labels_.tolist()

if __name__ == '__main__':
    # Dartからの入力を受け取る
    input_json = sys.argv[1]
    input_data = json.loads(input_json)
    data = input_data['data']
    group = input_data['group']

    # クラスター分析を実行
    result = do_cluster_analysis(data, group)

    # 結果を出力
    print(json.dumps(result))
