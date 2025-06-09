# Python Graphic Interface Project

## 📝 Descrição
Aplicação de interface gráfica desenvolvida em Python usando CustomTkinter com arquitetura modular e suporte completo ao Docker.

## 🚀 Características
- ✅ Interface moderna com CustomTkinter
- ✅ Arquitetura modular e organizada
- ✅ Sistema de autenticação
- ✅ Validação de dados
- ✅ Temas personalizáveis
- ✅ Suporte completo ao Docker
- ✅ Scripts automatizados com Makefile
- ✅ Ambiente de desenvolvimento com hot reload

## 🛠️ Instalação

### Ambiente Local

1. **Clone o repositório**
   ```bash
   git clone <repository-url>
   cd python_graphic_interface
   ```

2. **Configure o ambiente** (recomendado)
   ```bash
   make setup
   ```

3. **Ou instale manualmente**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Linux/Mac
   # ou
   venv\Scripts\activate  # Windows
   pip install -r requirements.txt
   ```

### Docker

1. **Construir e executar**
   ```bash
   make docker-run
   ```

2. **Modo desenvolvimento**
   ```bash
   make docker-dev
   ```

## 🎮 Uso

### Comandos Disponíveis

```bash
# Mostrar ajuda
make help

# Ambiente Local
make run          # Executar aplicação
make dev          # Modo desenvolvimento
make test         # Executar testes
make lint         # Verificar código
make clean        # Limpar cache

# Docker
make docker-run   # Executar no Docker
make docker-dev   # Desenvolvimento no Docker
make docker-stop  # Parar containers
```

### Credenciais de Teste

| Usuário | Senha    |
|---------|----------|
| admin   | password |
| user    | 123456   |
| demo    | demo     |

## 📁 Estrutura do Projeto

```
python_graphic_interface/
├── 📄 main.py              # Ponto de entrada
├── 📄 Dockerfile           # Configuração Docker
├── 📄 docker-compose.yml   # Orquestração Docker
├── 📄 Makefile            # Scripts automatizados
├── 📄 requirements.txt    # Dependências
├── 📄 README.md           # Documentação
├── 📄 .gitignore          # Arquivos ignorados
├── 📄 .dockerignore       # Arquivos ignorados no Docker
├── 📁 src/                # Código fonte
│   ├── 📄 app.py          # Aplicação principal
│   ├── 📁 components/     # Componentes reutilizáveis
│   │   ├── 📄 __init__.py
│   │   └── 📄 login_form.py
│   ├── 📁 utils/          # Utilitários
│   │   ├── 📄 __init__.py
│   │   ├── 📄 auth.py
│   │   └── 📄 validators.py
│   └── 📁 styles/         # Estilos e temas
│       ├── 📄 __init__.py
│       └── 📄 themes.py
├── 📁 scripts/            # Scripts auxiliares
│   ├── 📄 docker-run.sh
│   ├── 📄 docker-dev.sh
│   └── 📄 docker-headless.sh
├── 📁 config/             # Configurações
├── 📁 assets/             # Recursos
│   ├── 📁 images/
│   └── 📁 icons/
├── 📁 tests/              # Testes
│   └── 📄 __init__.py
└── 📁 venv/               # Ambiente virtual
```

## 🐳 Docker

### Modos de Execução

1. **Modo Normal**
   ```bash
   make docker-run
   ```

2. **Modo Desenvolvimento** (com hot reload)
   ```bash
   make docker-dev
   ```

3. **Modo Headless** (sem GUI, para testes)
   ```bash
   make docker-headless
   ```

### Requisitos para GUI no Docker

**Linux:**
```bash
# Os scripts já fazem isso automaticamente
xhost +local:docker
```

**Windows com WSL2:**
- Instale um servidor X11 (como VcXsrv)
- Configure o DISPLAY adequadamente

**macOS:**
- Instale XQuartz
- Configure o X11 forwarding

## 🧪 Desenvolvimento

### Adicionando Novos Componentes

1. Crie o componente em `src/components/`
2. Importe no `src/app.py`
3. Configure no método `setup_ui()`

### Adicionando Utilitários

1. Crie funções em `src/utils/`
2. Importe nos componentes que precisam

### Modificando Estilos

1. Edite `src/styles/themes.py`
2. Aplique no `src/app.py`

## 📦 Build e Deploy

```bash
# Verificar projeto
make check

# Preparar para produção
make build

# Gerar requirements atualizado
make freeze
```

## 🔧 Troubleshooting

### Problemas Comuns

1. **Erro de tkinter no Ubuntu/Debian**
   ```bash
   sudo apt install python3-tk
   ```

2. **Problema de display no Docker**
   ```bash
   xhost +local:docker
   export DISPLAY=:0
   ```

3. **Permissões de script**
   ```bash
   chmod +x scripts/*.sh
   ```

### Logs do Docker

```bash
# Ver logs
docker-compose logs -f

# Debug container
docker-compose exec python-gui-app bash
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## 🔗 Links Úteis

- [CustomTkinter Documentation](https://customtkinter.tomschimansky.com/)
- [Docker Documentation](https://docs.docker.com/)
- [Python Virtual Environments](https://docs.python.org/3/tutorial/venv.html)

