#!/bin/bash

# Script para executar a aplicação GUI no Docker
# Este script configura o X11 forwarding automaticamente

set -e

echo "🐳 Configurando Docker para aplicação GUI..."

# Verifica se o Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker primeiro."
    exit 1
fi

# Permite conexões X11 do localhost
echo "🔧 Configurando X11 forwarding..."
xhost +local:docker > /dev/null 2>&1 || echo "⚠️  Aviso: Não foi possível configurar xhost"

# Define variáveis de ambiente
export DISPLAY=${DISPLAY:-:0}

echo "📦 Construindo imagem Docker..."
docker-compose build python-gui-app

echo "🚀 Iniciando aplicação..."
docker-compose up python-gui-app

# Cleanup
echo "🧹 Limpando configurações X11..."
xhost -local:docker > /dev/null 2>&1 || true

echo "✅ Concluído!"

