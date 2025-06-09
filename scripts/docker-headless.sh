#!/bin/bash

# Script para executar a aplicação em modo headless (sem GUI)
# Útil para testes automatizados

set -e

echo "🐳 Iniciando aplicação em modo headless..."

# Verifica se o Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker primeiro."
    exit 1
fi

echo "📦 Construindo imagem Docker..."
docker-compose build python-gui-app-headless

echo "🚀 Executando em modo headless (Xvfb)..."
echo "📊 Útil para testes automatizados e CI/CD"

docker-compose up python-gui-app-headless

echo "✅ Execução headless concluída!"

