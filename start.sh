#!/bin/bash
echo "==> Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y
sudo apt install wget unzip curl -y

echo "==> Instalando e configurando o Playit.gg..."
curl -SsL https://github.io | sudo bash
sudo apt install playit -y

echo "==> Baixando a versão estável do Minecraft Bedrock..."
if [ ! -d "server" ]; then
    mkdir server
    cd server
    wget https://minecraft.net
    unzip bedrock-server-1.21.51.02.zip
    rm bedrock-server-1.21.51.02.zip
    cd ..
fi

echo "==> Iniciando o Playit em segundo plano..."
playit > playit.log 2>&1 &
sleep 5

echo "==> Procurando link de ativação do Playit..."
if grep -q "visit" playit.log; then
    grep "visit" playit.log
else
    echo "Playit já configurado ou rodando. Verifique o painel do playit.gg"
fi

echo "==> Iniciando o Servidor de Minecraft..."
cd server
LD_LIBRARY_PATH=. ./bedrock_server
