#!/bin/bash
echo "==> Atualizando o sistema básico..."
sudo apt update && sudo apt upgrade -y
sudo apt install wget unzip curl -y

echo "==> Instalando o Playit.gg usando o script oficial atualizado..."
# Usando o novo instalador universal automatizado do playit
curl -fsSL https://packages.playit.gg/install.sh | sudo bash

echo "==> Baixando e extraindo o Minecraft Bedrock..."
# Limpando tentativas anteriores falhas
rm -rf server
mkdir server
cd server

# Baixando com o disfarce de navegador (User-Agent)
wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64)" https://minecraft.net
unzip bedrock-server-1.21.51.02.zip
rm bedrock-server-1.21.51.02.zip
cd ..

echo "==> Iniciando o Playit para gerar o link..."
# Executa o playit e joga as informações na tela para você pegar o link de ativação
sudo playit
