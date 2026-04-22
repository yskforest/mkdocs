PlantUMLのサンプル集です。Mermaidに比べて記法がより柔軟で、特に大規模なシステム構成や複雑なC++のクラス構造を記述するのに向いています。

Markdownファイル内でPlantUMLを表示するには、VS Codeの「PlantUML」拡張機能や、GitLab/GitHubのプラグイン（環境によります）が必要です。

---

## 1. シーケンス図 (Sequence Diagram)
Mermaidよりも「戻り値」や「並列処理」の表現が強力です。ここでは、開発者が構築中の「ローカルAIによるコードレビュー」のフローを例にします。

```plantuml
@startuml
autonumber
actor "開発者" as Dev
participant "GitLab" as GL
participant "Jenkins" as JK
database "Local AI (Ollama)" as AI

Dev -> GL : Merge Request作成
GL -> JK : Webhook通知 (yml設定に従う)
activate JK

JK -> JK : ソースコード取得
JK -> AI : コード差分を送信 (gemma4:e4b)
activate AI
AI --> JK : 解析結果 (JSON/YAML)
deactivate AI

JK -> GL : レビュー結果をコメント
deactivate JK
GL -> Dev : 通知
@enduml
```

## 2. クラス図 (Class Diagram)
C++の1,200万行を超える大規模プロジェクトの解析結果を整理するのに適した、詳細な定義が可能です。

```plantuml
@startuml
skinparam classAttributeIconSize 0

package "CT Simulator Core" {
    class Simulator {
        - m_currentFrame : int
        + run() : void
        + stop() : void
    }
    
    interface IScanMode {
        + {abstract} execute() : void
    }
    
    class HelicalScan {
        + execute() : void
    }
    
    class DynamicScan {
        + execute() : void
    }
}

Simulator "1" *-- "1" IScanMode : owns >
IScanMode <|.. HelicalScan
IScanMode <|.. DynamicScan

note right of Simulator : 3D CT Simulatorの\nメインロジック
@enduml
```

## 3. コンポーネント図 (Component Diagram)
Ubuntuサーバー上で稼働するDockerコンテナ群の依存関係を可視化します。

```plantuml
@startuml
package "Local Home Server (Ubuntu)" {
    [Samba] <<File Server>>
    [GitLab] <<SCM>>
    [Jenkins] <<CI/CD>>
    
    node "Docker Environment" {
        [Three.js App] as WebApp
        [Ollama] as AI
    }
}

[Samba] <.. [GitLab] : 共有ボリューム
[GitLab] -> [Jenkins] : トリガー
[Jenkins] --> AI : REST API
WebApp -> AI : 推論リクエスト
@enduml
```

## 4. 状態遷移図 (State Diagram)
スキャンモードの切り替えや、解析パイプラインのライフサイクルを定義します。

```plantuml
@startuml
[*] --> Idle

state "Scanning" as Scan {
    [*] --> Initializing
    Initializing --> Capturing : Ready
    Capturing --> Capturing : Tick
}

Idle --> Scan : Start Button
Scan --> Processing : Completed
Processing --> Idle : Save Result
Processing --> Error : Fail

state Error {
    [*] --> LogExport
    LogExport --> [*]
}
@enduml
```

## 5. アクティビティ図 (Activity Diagram)
複雑な条件分岐を伴うアルゴリズムや、CI/CDパイプラインのロジックをフローチャート形式で記述します。

```plantuml
@startuml
start
:Jenkinsビルド開始;
if (YAML設定ファイルは存在するか?) then (yes)
    :静的解析 (SonarQube) 実行;
    if (重要エラーあり?) then (yes)
        :ビルド失敗としてマーク;
        stop
    else (no)
        :ローカルAIコードレビュー;
    endif
else (no)
    :エラー終了;
    stop
endif
:デプロイ完了;
stop
@enduml
```

## 6. デプロイメント図 (Deployment Diagram)
物理的なハードウェア（RTX 4080/3090など）とソフトウェアの配置関係を示します。

```plantuml
@startuml
node "Local Dev Machine" {
    node "NVIDIA RTX 4080 / 3090" {
        [AI Model (gemma4:e4b)]
    }
    node "CPU / RAM" {
        [Jenkins Runner]
    }
}

cloud "GitHub / GitLab" {
    [Repository]
}

[Repository] <--> [Jenkins Runner] : Fetch
[Jenkins Runner] --> [AI Model (gemma4:e4b)] : Local Inference
@enduml
```

---

> **Tips:** PlantUMLはMermaidよりも「配置」の制御が柔軟です。`TD`（上から下）だけでなく、`-right->` や `-down->` を使って矢印の方向を細かく指定することで、複雑な図もきれいに整理できます。
