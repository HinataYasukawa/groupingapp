import pandas as pd
from sklearn.cluster import KMeans
from sklearn.metrics import pairwise_distances
import numpy as np

# ユーザー入力を受け取る
num_clusters = int(input("分けるグループの数を入力してください: "))
num_variables = int(input("変数の数を入力してください: "))

# CSVファイルからデータを読み込む
csv_file = './TestFile.csv'
data = pd.read_csv(csv_file, usecols=range(num_variables))
num_rows = data.shape[0]

# KMeansクラスタリングを実行
kmeans = KMeans(n_clusters=num_clusters, n_init=10)
kmeans.fit(data)

# クラスタリング結果
clusters = kmeans.labels_

# クラスタの重心を計算
centroids = kmeans.cluster_centers_

# クラスタサイズの理想値を計算（整数に丸める）
ideal_cluster_size = round(num_rows / num_clusters)

# 各クラスタのサイズとデータポイントを集計
cluster_sizes = pd.Series(clusters).value_counts()

# 各クラスタのサイズ調整
for _ in range(50):  # ループ回数を減らす
    changes_made = False
    for cluster_id in range(num_clusters):
        if cluster_sizes[cluster_id] <= ideal_cluster_size:
            continue
        cluster_data = data[clusters == cluster_id]
        distances = pairwise_distances(cluster_data, [centroids[cluster_id]])
        farthest_points = distances.argsort(axis=0)[-2:, 0]  # 最も遠い2つのポイントを選択

        for farthest_point_idx in farthest_points:
            other_centroids = [c for i, c in enumerate(centroids) if i != cluster_id and cluster_sizes[i] < ideal_cluster_size]
            if not other_centroids:
                continue
            distances_to_others = pairwise_distances([cluster_data.iloc[farthest_point_idx]], other_centroids)
            new_cluster_id = distances_to_others.argmin()
            clusters[farthest_point_idx] = new_cluster_id
            changes_made = True

        if changes_made:
            cluster_sizes = pd.Series(clusters).value_counts()

    if not changes_made:
        break  # 変更がなければループを終了

# 最終的なクラスタリング結果
print("調整後のクラスタリング結果:")
for i, cluster in enumerate(clusters):
    print(f"データ {i+1}: クラスタ {cluster}")
