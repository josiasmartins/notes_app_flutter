#!/bin/bash

# Função para extrair os três números da versão do arquivo pubspec.yaml
get_version() {
    # Verifica se o arquivo pubspec.yaml existe
    if [ -f "pubspec.yaml" ]; then
        # Usa o comando 'grep' para encontrar a linha que contém 'version'
        # Usa 'cut' para extrair os três números da versão
        version=$(grep "version:" pubspec.yaml | cut -d " " -f 2 | tr -d '"' | cut -d '+' -f 1)
        echo "$version"
    else
        echo "Arquivo pubspec.yaml não encontrado."
    fi
}

# Chamando a função e armazenando o resultado em uma variável
version=$(get_version)

# Imprime os três números da versão
echo "A versão do aplicativo de notas é: $version"

# Função para gerar o build do Flutter
build_flutter() {
    #flutter clean
    echo "Gerando o build do apk"
    flutter build apk --release

    #sleep 4 para o tempo

    echo "finalizado o build do apk"
}

# Função para mover o APK para a pasta 'apks'
move_apk() {
    mkdir -p apks
    echo "Variavel $1"
    mv build/app/outputs/flutter-apk/app-release.apk apks/notes_app_v$version.apk
    echo "Movido para a pasta apks"
}

# # Função para alterar a versão do Flutter no pubspec.yaml
# change_flutter_version() {
#     sed -i '' "s/version: .*/version: $1/" pubspec.yaml
# }

# Função para gerar uma nova tag no Git
create_git_tag() {
    git add .
    git commit -m "Release version $1"
    git tag -a v$1 -m "Version $1"
}

# Versão atual do app
current_version=$(grep "version:" pubspec.yaml | awk '{print $2}')

# Incrementar a versão (pode ser ajustado conforme suas necessidades)
# new_version=$((current_version + 1))

# Gera o build do Flutter
build_flutter

# Move o APK para a pasta 'apks'
move_apk $new_version

# Altera a versão do Flutter no pubspec.yaml
change_flutter_version $new_version

# Cria uma nova tag no Git
# create_git_tag $new_version

echo "Build, versioning, and tagging completed successfully. $new_version"