# Use Ubuntu base image
FROM ubuntu:22.04

# Evita prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Define variáveis de ambiente para GUI
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# Atualiza o sistema e instala dependências
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-tk \
    x11-apps \
    xauth \
    xvfb \
    libgtk-3-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libfontconfig1 \
    libxrender1 \
    libdbus-1-3 \
    libxi6 \
    libxtst6 \
    libxrandr2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos de dependências
COPY requirements.txt .

# Instala dependências Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Copia o código da aplicação
COPY . .

# Cria usuário não-root para segurança
RUN useradd -m -s /bin/bash appuser && \
    chown -R appuser:appuser /app

# Muda para usuário não-root
USER appuser

# Expõe a porta (caso precise no futuro)
EXPOSE 8080

# Define o comando padrão
CMD ["python3", "main.py"]

