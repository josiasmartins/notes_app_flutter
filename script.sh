#!/bin/bash

# Função para gerar o build do Flutter
build_flutter() {
    flutter clean
    flutter build apk --release
}

# Função para mover o APK para a pasta 'apks'
move_apk() {
    mkdir -p apks
    mv build/app/outputs/flutter-apk/app-release.apk apks/my_app_v$1.apk
}

# Função para alterar a versão do Flutter no pubspec.yaml
change_flutter_version() {
    sed -i '' "s/version: .*/version: $1/" pubspec.yaml
}

# Função para gerar uma nova tag no Git
create_git_tag() {
    git add .
    git commit -m "Release version $1"
    git tag -a v$1 -m "Version $1"
}

# Versão atual do app
current_version=$(grep "version:" pubspec.yaml | awk '{print $2}')

# Incrementar a versão (pode ser ajustado conforme suas necessidades)
new_version=$((current_version + 1))

# Gera o build do Flutter
build_flutter

# Move o APK para a pasta 'apks'
move_apk $new_version

# Altera a versão do Flutter no pubspec.yaml
change_flutter_version $new_version

# Cria uma nova tag no Git
create_git_tag $new_version

echo "Build, versioning, and tagging completed successfully."