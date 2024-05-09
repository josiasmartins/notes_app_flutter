#!/bin/bash

# Encontra o primeiro arquivo APK na pasta apks
apk_file=$(ls apks/*.apk | head -n 1)

# Verifica se foi encontrado algum APK
if [ -n "$apk_file" ]; then
    # Obtém o nome do arquivo sem o caminho completo
    apk_filename=$(basename "$apk_file")
    
    # Verifica se o README já contém uma seção para os downloads
    if grep -q "### Download do APK" README.md; then
        # Adiciona três linhas em branco antes de adicionar o novo link
        sed -i '/### Download do APK/ a \\n\n\n' README.md
        # Adiciona o novo link para o APK após as três linhas em branco
        sed -i "/### Download do APK/,+3 a \- [Download APK]($apk_filename)" README.md
    else
        # Adiciona uma nova seção de downloads com o link para o APK
        echo "### Download do APK" >> README.md
        echo "- [Download APK]($apk_filename)" >> README.md
    fi

    # Faz commit e push das alterações
    # git add README.md
    # git commit -m "Adicionado link para o APK"
    # git push origin master

    echo "Link para o APK adicionado com sucesso ao README.md."
else
    echo "Nenhum arquivo APK encontrado na pasta apks."
fi
