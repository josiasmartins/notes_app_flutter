#!/bin/bash

# Encontra o primeiro arquivo APK na pasta apks
apk_file=$(ls apks/*.apk | head -n 1)

# Verifica se foi encontrado algum APK
if [ -n "$apk_file" ]; then
    # Obtém o nome do arquivo sem o caminho completo
    apk_filename=$(basename "$apk_file")
    
    # Atualiza o README.md com o link para o APK encontrado
    echo "### Download do APK" > README.md
    echo "- [Download APK]($apk_filename)" >> README.md

    # Faz commit e push das alterações
    # git add README.md
    # git commit -m "Adicionado link para o APK"
    # git push origin master

    echo "Link para o APK adicionado com sucesso ao README.md."
else
    echo "Nenhum arquivo APK encontrado na pasta apks."
fi
