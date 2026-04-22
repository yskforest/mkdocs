Markdownファイルとしてそのままコピー＆ペーストして使用できる、Mermaidの主要なグラフを網羅したサンプル集です。

プレビュー機能のあるエディタ（VS CodeやGitLabなど）に貼り付けることで、各種図表が即座にレンダリングされます。

---

## 1. フローチャート (Flowchart)
システム全体の処理の流れや、パイプラインの構造を表現するのによく使われます。

```mermaid
graph TD
    A[開発者: コードPush] --> B{GitLab CI / Jenkins}
    B -->|ビルド成功| C[Dockerイメージ作成]
    B -->|ビルド失敗| D[開発者へ通知]
    C --> E[ローカルサーバーへデプロイ]
    E --> F[自動テスト実行]
```

## 2. シーケンス図 (Sequence Diagram)
複数システム間のAPI呼び出しや、非同期処理のやり取りを時系列で表現します。

```mermaid
sequenceDiagram
    autonumber
    actor Dev as 開発者
    participant GL as GitLab
    participant CI as Jenkins
    participant AI as ローカルLLM

    Dev->>GL: Merge Request作成
    GL->>CI: Webhook トリガー
    CI->>AI: 変更分のコードを送信 (プロンプト)
    AI-->>CI: レビュー結果の返却
    CI-->>GL: MRへコメントをポスト
    GL-->>Dev: レビュー完了通知
```

## 3. クラス図 (Class Diagram)
オブジェクト指向設計におけるクラスの構造や、インターフェースの依存関係を整理します。

```mermaid
classDiagram
    class SimulatorCore {
        -int currentFrame
        +initialize()
        +runSimulation()
        -updateUI()
    }
    class ScanMode {
        <<interface>>
        +executeScan()
    }
    class HelicalScan {
        +executeScan()
        +calculatePitch()
    }
    class DynamicScan {
        +executeScan()
    }

    SimulatorCore *-- ScanMode : 構成
    ScanMode <|-- HelicalScan : 実装
    ScanMode <|-- DynamicScan : 実装
```

## 4. 状態遷移図 (State Diagram)
プロセスやタスクが、どのような条件でどの状態に変化するかを定義します。

```mermaid
stateDiagram-v2
    [*] --> Open : MR作成
    Open --> Reviewing : CIパイプライン開始
    
    state Reviewing {
        [*] --> StaticAnalysis
        StaticAnalysis --> LLMReview : SonarQube Pass
        LLMReview --> [*]
    }
    
    Reviewing --> Approved : 問題なし
    Reviewing --> ChangesRequested : 修正が必要
    ChangesRequested --> Reviewing : 新規コミット
    Approved --> Merged : マージ実行
    Merged --> [*]
```

## 5. ガントチャート (Gantt Chart)
プロジェクトのスケジュールや、タスクの依存関係を可視化します。

```mermaid
gantt
    title 大規模コードベース解析プロジェクト
    dateFormat  YYYY-MM-DD
    axisFormat  %m/%d
    
    section インフラ準備
    コンテナ環境構築       :done,    env1, 2026-04-10, 3d
    Jenkins連携設定        :done,    env2, after env1, 4d
    
    section 解析フェーズ
    静的解析ツールの導入   :active,  ana1, 2026-04-18, 5d
    ローカルAIによる解析   :         ana2, after ana1, 7d
    
    section レポート
    解析結果のドキュメント化:         doc1, after ana2, 3d
```

## 6. Gitグラフ (Git Graph)
ブランチの分岐、コミット履歴、マージの運用フロー（Git Flowなど）を図示します。

```mermaid
gitGraph
    commit
    branch develop
    checkout develop
    commit
    
    branch feature/llm-review
    checkout feature/llm-review
    commit id: "add python script"
    commit id: "update jenkinsfile (yml)"
    checkout develop
    merge feature/llm-review
    
    checkout main
    merge develop tag: "v1.2.0"
```

## 7. ER図 (Entity Relationship Diagram)
データベースのテーブル構造や、エンティティ間のリレーション（1対多など）を表現します。

```mermaid
erDiagram
    DEVELOPER ||--o{ MERGE_REQUEST : "作成する"
    MERGE_REQUEST ||--|{ REVIEW_COMMENT : "含む"
    
    DEVELOPER {
        int id PK
        string name
        string role "例: 主任"
    }
    MERGE_REQUEST {
        int id PK
        string target_branch
        string status
    }
    REVIEW_COMMENT {
        int id PK
        text content
        boolean is_ai_generated
    }
```

## 8. 円グラフ (Pie Chart)
リソースの割合や、データの構成比をシンプルに示します。

```mermaid
pie title プロジェクトのコード行数 (言語別割合)
    "C++" : 65
    "Python" : 15
    "YAML" : 10
    "Shell" : 5
    "Other" : 5
```

---
