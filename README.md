# package_b

LeRobot SO-101 を ROS 2 Jazzy で扱うために、`lerobot_ws` と `feetech_ros2_driver` を組み合わせたプロジェクトです。

## 取得元と取り込み版

| 配置先 | 取得元 | ブランチ | 取り込み時点のコミット | 既存ライセンス |
| --- | --- | --- | --- | --- |
| `src/lerobot_ws/` | [Ar-Ray-code/lerobot_ws](https://github.com/Ar-Ray-code/lerobot_ws) | `sts_servo` | [b3987a7](https://github.com/Ar-Ray-code/lerobot_ws/tree/b3987a73de7deb81ce65afc59e29f2c8f20c0e2c) | [Apache-2.0](src/lerobot_ws/LICENSE) |
| `src/feetech_ros2_driver/` | [Ar-Ray-code/feetech_ros2_driver](https://github.com/Ar-Ray-code/feetech_ros2_driver) | `auto_calib` | [a5e8675](https://github.com/Ar-Ray-code/feetech_ros2_driver/tree/a5e8675688e90b859d173c3ced25d2ca21f3dd0e) | [BSD-3-Clause](src/feetech_ros2_driver/LICENSE) |

`lerobot_ws` は上記の版を基に独自修正しています。`feetech_ros2_driver` は上記の版を変更せず取り込んでいます。

各フォークの元となった上流リポジトリは、[Pavankv92/lerobot_ws](https://github.com/Pavankv92/lerobot_ws) と [JafarAbdi/feetech_ros2_driver](https://github.com/JafarAbdi/feetech_ros2_driver) です。ロボットモデルは、取り込み元の記載に従い [TheRobotStudio/SO-ARM100](https://github.com/TheRobotStudio/SO-ARM100) に基づいています。

## 主な独自変更

- 関節名の統一と、Isaac Sim 向けの座標フレームの追加。
- MoveIt・コントローラー設定の調整。
- ポリシーの JointState 指令を JointTrajectory に変換するノードの起動設定の追加。
- `src/Dockerfile`、`src/compose.yaml`、`src/.dockerignore` の新規作成。

## ライセンス

本リポジトリの独自追加・修正部分は、個別に別の指定がある場合を除き、[Apache License 2.0](LICENSE) で提供します。

取り込んだコードには、表に示す各ライセンスが適用されます。既存の LICENSE と著作権・帰属表示を保持しています。各ファイルに個別の表示がある場合は、その表示も参照してください。
