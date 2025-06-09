#!/bin/bash

# Script para desenvolvimento com Docker e hot reload

set -e

echo "🐳 Iniciando ambiente de desenvolvimento..."

# Verifica se o Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker primeiro."
    exit 1
fi

# Permite conexões X11
echo "🔧 Configurando X11 forwarding..."
xhost +local:docker > /dev/null 2>&1 || echo "⚠️  Aviso: Não foi possível configurar xhost"

# Define variáveis de ambiente
export DISPLAY=${DISPLAY:-:0}

echo "📦 Construindo imagem de desenvolvimento..."
docker-compose build python-gui-dev

echo "🚀 Iniciando modo desenvolvimento..."
echo "📝 Modo hot reload ativo - a aplicação será reiniciada automaticamente"
echo "🛑 Pressione Ctrl+C para parar"

docker-compose up python-gui-dev

# Cleanup
echo "🧹 Limpando configurações X11..."
xhost -local:docker > /dev/null 2>&1 || true

echo "✅ Desenvolvimento encerrado!"

