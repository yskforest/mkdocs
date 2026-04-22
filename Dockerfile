FROM squidfunk/mkdocs-material:latest
RUN pip install mkdocs-kroki-plugin
RUN pip install plantuml-markdown
