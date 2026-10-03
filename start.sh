#!/bin/bash
echo "==> Atualizando dependências básicas..."
sudo apt update && sudo apt install wget unzip curl -y

echo "==> Baixando o Minecraft Bedrock (Link Direto)..."
rm -rf server
mkdir server
cd server

# Usando link direto do armazenamento para burlar o bloqueio do site da Mojang
wget https://azureedge.net
unzip bedrock-server-1.21.51.02.zip
rm bedrock-server-1.21.51.02.zip
cd ..

echo "==> Baixando versão standalone do Playit.gg..."
# Baixa o executável direto para evitar erros com o serviço do sistema do Codespaces
if [ ! -f "playit" ]; then
    curl -Ao playit https://github.com
    chmod +x playit
fi

echo "==> Iniciando o Playit em segundo plano..."
./playit > playit.log 2>&1 &
sleep 5

echo "==> Procurando link de ativação do Playit..."
if grep -q "visit" playit.log; then
    grep "visit" playit.log
else
    echo "Verificando log do Playit:"
    cat playit.log
fi

echo "==> Iniciando o Servidor de Minecraft..."
cd server
LD_LIBRARY_PATH=. ./bedrock_server
