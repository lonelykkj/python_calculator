.PHONY: help install run clean test lint format ruff ruff-check ruff-fix setup dev docker-build docker-run docker-dev docker-stop

# Variáveis
PYTHON = python3
VENV = venv
VENV_BIN = $(VENV)/bin
PIP = $(VENV_BIN)/pip
PYTHON_VENV = $(VENV_BIN)/python
RUFF = $(VENV_BIN)/ruff
DOCKER_IMAGE = python-graphic-interface

# Cores para output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
PURPLE = \033[0;35m
CYAN = \033[0;36m
NC = \033[0m # No Color

help: ## Mostra esta ajuda
	@echo "$(BLUE)Comandos disponíveis:$(NC)"
	@echo ""
	@echo "$(PURPLE)📦 Ambiente Local:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | grep -v docker | grep -v ruff | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(CYAN)⚡ Ruff (Linting & Formatting):$(NC)"
	@grep -E '^ruff[a-zA-Z_-]*:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(PURPLE)🐳 Docker:$(NC)"
	@grep -E '^docker-[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

setup: ## Configura o ambiente de desenvolvimento completo
	@echo "$(YELLOW)Configurando ambiente de desenvolvimento...$(NC)"
	@make clean
	@make install
	@echo "$(GREEN)✓ Ambiente configurado com sucesso!$(NC)"

install: $(VENV)/bin/activate ## Instala dependências
	@echo "$(YELLOW)Instalando dependências...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo "$(GREEN)✓ Dependências instaladas!$(NC)"

$(VENV)/bin/activate: ## Cria ambiente virtual
	@echo "$(YELLOW)Criando ambiente virtual...$(NC)"
	$(PYTHON) -m venv $(VENV)
	@echo "$(GREEN)✓ Ambiente virtual criado!$(NC)"

run: $(VENV)/bin/activate ## Executa a aplicação
	@echo "$(BLUE)🚀 Iniciando aplicação...$(NC)"
	$(PYTHON_VENV) main.py

dev: $(VENV)/bin/activate ## Executa em modo desenvolvimento
	@echo "$(BLUE)🔧 Iniciando em modo desenvolvimento...$(NC)"
	$(PYTHON_VENV) -u main.py

test: $(VENV)/bin/activate ## Executa os testes
	@echo "$(YELLOW)Executando testes...$(NC)"
	$(PYTHON_VENV) -m pytest tests/ -v || echo "$(YELLOW)⚠️  Pytest não encontrado. Instale com: pip install pytest$(NC)"
	@echo "$(GREEN)✓ Testes executados!$(NC)"

# Comandos do Ruff
ruff: $(VENV)/bin/activate ## Executa Ruff (check + format)
	@echo "$(CYAN)⚡ Executando Ruff completo...$(NC)"
	@make ruff-check
	@make ruff-fix
	@echo "$(GREEN)✓ Ruff concluído!$(NC)"

ruff-check: $(VENV)/bin/activate ## Verifica código com Ruff
	@echo "$(CYAN)⚡ Verificando código com Ruff...$(NC)"
	$(RUFF) check src/ tests/ main.py
	@echo "$(GREEN)✓ Verificação Ruff concluída!$(NC)"

ruff-fix: $(VENV)/bin/activate ## Corrige automaticamente com Ruff
	@echo "$(CYAN)⚡ Corrigindo código com Ruff...$(NC)"
	$(RUFF) check --fix src/ tests/ main.py
	$(RUFF) format src/ tests/ main.py
	@echo "$(GREEN)✓ Correções Ruff aplicadas!$(NC)"

ruff-format: $(VENV)/bin/activate ## Formata código com Ruff
	@echo "$(CYAN)⚡ Formatando código com Ruff...$(NC)"
	$(RUFF) format src/ tests/ main.py
	@echo "$(GREEN)✓ Formatação Ruff concluída!$(NC)"

# Comandos legados (mantidos para compatibilidade)
lint: ruff-check ## Executa linting do código (usa Ruff)

format: ruff-format ## Formata o código (usa Ruff)

freeze: $(VENV)/bin/activate ## Gera requirements.txt atualizado
	@echo "$(YELLOW)Gerando requirements.txt...$(NC)"
	$(PIP) freeze > requirements.txt
	@echo "$(GREEN)✓ requirements.txt atualizado!$(NC)"

clean: ## Remove arquivos temporários e cache
	@echo "$(YELLOW)Limpando arquivos temporários...$(NC)"
	rm -rf $(VENV)
	rm -rf __pycache__
	rm -rf src/__pycache__
	rm -rf src/*/__pycache__
	rm -rf tests/__pycache__
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	rm -rf *.pyc
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type d -name "__pycache__" -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Limpeza concluída!$(NC)"

# Comandos Docker
docker-build: ## Constrói a imagem Docker
	@echo "$(BLUE)🐳 Construindo imagem Docker...$(NC)"
	docker-compose build
	@echo "$(GREEN)✓ Imagem Docker construída!$(NC)"

docker-run: ## Executa a aplicação no Docker
	@echo "$(BLUE)🐳 Executando aplicação no Docker...$(NC)"
	@chmod +x scripts/docker-run.sh
	@./scripts/docker-run.sh

docker-dev: ## Executa em modo desenvolvimento no Docker
	@echo "$(BLUE)🐳 Iniciando desenvolvimento no Docker...$(NC)"
	@chmod +x scripts/docker-dev.sh
	@./scripts/docker-dev.sh

docker-headless: ## Executa em modo headless no Docker
	@echo "$(BLUE)🐳 Executando em modo headless...$(NC)"
	@chmod +x scripts/docker-headless.sh
	@./scripts/docker-headless.sh

docker-stop: ## Para todos os containers
	@echo "$(YELLOW)🛑 Parando containers Docker...$(NC)"
	docker-compose down
	@echo "$(GREEN)✓ Containers parados!$(NC)"

docker-clean: ## Remove imagens e containers Docker
	@echo "$(YELLOW)🧹 Limpando recursos Docker...$(NC)"
	docker-compose down --rmi all --volumes --remove-orphans
	@echo "$(GREEN)✓ Limpeza Docker concluída!$(NC)"

info: ## Mostra informações do projeto
	@echo "$(BLUE)📋 Informações do Projeto$(NC)"
	@echo "  Nome: Python Graphic Interface"
	@echo "  Versão Python: $(shell $(PYTHON) --version 2>/dev/null || echo 'Não encontrado')"
	@echo "  Diretório: $(shell pwd)"
	@echo "  Ambiente Virtual: $(if $(wildcard $(VENV)), $(GREEN)✓ Ativo$(NC), $(RED)✗ Não encontrado$(NC))"
	@echo "  Requirements: $(if $(wildcard requirements.txt), $(GREEN)✓ requirements.txt$(NC), $(RED)✗ requirements.txt não encontrado$(NC))"
	@echo "  Ruff: $(shell $(RUFF) --version 2>/dev/null || echo '$(RED)Não instalado$(NC)')"
	@echo "  Docker: $(shell docker --version 2>/dev/null || echo '$(RED)Não instalado$(NC)')"
	@echo "  Docker Compose: $(shell docker-compose --version 2>/dev/null || echo '$(RED)Não instalado$(NC)')"

check: $(VENV)/bin/activate ## Verifica se tudo está funcionando
	@echo "$(YELLOW)Verificando projeto...$(NC)"
	@make ruff-check
	@make test
	@echo "$(GREEN)✓ Projeto verificado com sucesso!$(NC)"

.PHONY: help install run clean test lint format setup dev

# Variáveis
PYTHON = python3
VENV = venv
VENV_BIN = $(VENV)/bin
PIP = $(VENV_BIN)/pip
PYTHON_VENV = $(VENV_BIN)/python

# Cores para output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

help: ## Mostra esta ajuda
	@echo "$(BLUE)Comandos disponíveis:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'

setup: ## Configura o ambiente de desenvolvimento completo
	@echo "$(YELLOW)Configurando ambiente de desenvolvimento...$(NC)"
	@make clean
	@make install
	@echo "$(GREEN)✓ Ambiente configurado com sucesso!$(NC)"

install: $(VENV)/bin/activate ## Instala dependências
	@echo "$(YELLOW)Instalando dependências...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo "$(GREEN)✓ Dependências instaladas!$(NC)"

$(VENV)/bin/activate: ## Cria ambiente virtual
	@echo "$(YELLOW)Criando ambiente virtual...$(NC)"
	$(PYTHON) -m venv $(VENV)
	@echo "$(GREEN)✓ Ambiente virtual criado!$(NC)"

run: $(VENV)/bin/activate ## Executa a aplicação
	@echo "$(BLUE)🚀 Iniciando aplicação...$(NC)"
	$(PYTHON_VENV) main.py

dev: $(VENV)/bin/activate ## Executa em modo desenvolvimento com hot reload
	@echo "$(BLUE)🔧 Iniciando em modo desenvolvimento...$(NC)"
	$(PYTHON_VENV) -u main.py

test: $(VENV)/bin/activate ## Executa os testes
	@echo "$(YELLOW)Executando testes...$(NC)"
	$(PYTHON_VENV) -m pytest tests/ -v
	@echo "$(GREEN)✓ Testes executados!$(NC)"

lint: $(VENV)/bin/activate ## Executa linting do código
	@echo "$(YELLOW)Executando linting...$(NC)"
	$(PYTHON_VENV) -m flake8 src/ --max-line-length=88
	@echo "$(GREEN)✓ Linting concluído!$(NC)"

format: $(VENV)/bin/activate ## Formata o código
	@echo "$(YELLOW)Formatando código...$(NC)"
	$(PYTHON_VENV) -m black src/ tests/
	@echo "$(GREEN)✓ Código formatado!$(NC)"

freeze: $(VENV)/bin/activate ## Gera requirements.txt atualizado
	@echo "$(YELLOW)Gerando requirements.txt...$(NC)"
	$(PIP) freeze > requirements.txt
	@echo "$(GREEN)✓ requirements.txt atualizado!$(NC)"

clean: ## Remove arquivos temporários e cache
	@echo "$(YELLOW)Limpando arquivos temporários...$(NC)"
	rm -rf $(VENV)
	rm -rf __pycache__
	rm -rf src/__pycache__
	rm -rf src/*/__pycache__
	rm -rf tests/__pycache__
	rm -rf .pytest_cache
	rm -rf *.pyc
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	@echo "$(GREEN)✓ Limpeza concluída!$(NC)"

info: ## Mostra informações do projeto
	@echo "$(BLUE)📋 Informações do Projeto$(NC)"
	@echo "  Nome: Python Graphic Interface"
	@echo "  Versão Python: $(shell $(PYTHON) --version)"
	@echo "  Diretório: $(shell pwd)"
	@echo "  Ambiente Virtual: $(if $(wildcard $(VENV)), $(GREEN)✓ Ativo$(NC), $(RED)✗ Não encontrado$(NC))"
	@echo "  Dependências: $(if $(wildcard requirements.txt), $(GREEN)✓ requirements.txt$(NC), $(RED)✗ requirements.txt não encontrado$(NC))"

check: $(VENV)/bin/activate ## Verifica se tudo está funcionando
	@echo "$(YELLOW)Verificando projeto...$(NC)"
	@make lint
	@make test
	@echo "$(GREEN)✓ Projeto verificado com sucesso!$(NC)"

build: ## Prepara para distribuição
	@echo "$(YELLOW)Preparando para distribuição...$(NC)"
	@make clean
	@make setup
	@make check
	@echo "$(GREEN)✓ Projeto pronto para distribuição!$(NC)"

