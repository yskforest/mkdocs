# プロジェクト名 (Project Name)

## 概要 (Overview)

このリポジトリは、MkDocsを使用してドキュメンテーションサイトを構築し、Docker Composeを利用してビルドおよび公開するための環境をセットアップしたものです。

MkDocsはMarkdown形式でドキュメントを記述でき、テーマ（Material for MkDocsなど）を適用することで、プロフェッショナルなドキュメントサイトを簡単に作成できます。

Docker Composeを使用することで、ローカル環境に依存せず、再現性の高いビルド・デプロイ環境を構築できます。

## 🚀 使い方 (Usage)

### 1. 前提条件 (Prerequisites)

*   Docker Engine がインストールされていること。
*   Docker Compose がインストールされていること。

### 2. ドキュメントの準備 (Prepare Documentation)

ドキュメントのソースファイルは `docs/` ディレクトリ内にMarkdown形式（`.md`）で記述してください。

**例:** `docs/index.md` にメインページの内容を記述します。

### 3. ビルドの実行 (Build the Site)

以下のコマンドを実行すると、`Dockerfile` に基づいてDockerイメージがビルドされ、`mkdocs build` コマンドが実行されます。これにより、静的HTMLファイルが `./site` ディレクトリに生成されます。

```bash
docker compose up --build build
```

### 4. サイトの公開 (Serve the Site)

ビルドが完了したら、以下のコマンドを実行することで、Nginxコンテナが起動し、ローカルホストのポート80（または指定したポート）でサイトを公開します。

```bash
docker compose up --build serve
```

ブラウザで `http://localhost` にアクセスしてください。

### 💡 ファイル構成 (File Structure)

*   `mkdocs.yml`: MkDocsのメイン設定ファイル。
*   `docs/`: ドキュメントのソースファイル（Markdown）。
*   `Dockerfile`: ビルド環境を定義するDockerファイル。
*   `docker-compose.yml`: サービス（ビルド、公開）を定義するファイル。
*   `site/`: **（ビルド後に生成される）** 実際に公開される静的HTMLファイル群。
