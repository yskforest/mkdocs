FROM python:3.12-slim

# git (git-revision-date-localized 用)、日本語フォント (PDF 描画用)、libatomic1 (Playwright Node ランタイム用) をインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    fonts-noto-cjk \
    libatomic1 \
    && rm -rf /var/lib/apt/lists/*

# ホストからマウントされたリポジトリに対する git の safe.directory 設定
RUN git config --global --add safe.directory /docs

# MkDocs Material・各種プラグイン・mkdocs-exporter をインストール
RUN pip install --no-cache-dir \
    mkdocs-material \
    mkdocs-git-revision-date-localized-plugin \
    plantuml-markdown \
    mkdocs-exporter

# Playwright の Chromium とシステム依存パッケージをインストール
RUN playwright install --with-deps --only-shell chromium

# 日本語フォント (Noto CJK JP) が優先されるよう fontconfig を設定
RUN printf '%s\n' \
  '<?xml version="1.0"?>' \
  '<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">' \
  '<fontconfig>' \
  '  <alias><family>sans-serif</family><prefer><family>Noto Sans CJK JP</family></prefer></alias>' \
  '  <alias><family>serif</family><prefer><family>Noto Serif CJK JP</family></prefer></alias>' \
  '  <alias><family>monospace</family><prefer><family>Noto Sans Mono CJK JP</family></prefer></alias>' \
  '</fontconfig>' > /etc/fonts/local.conf && fc-cache -fv

WORKDIR /docs
EXPOSE 8000
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
