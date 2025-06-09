"""
Funções de validação.
"""

import re
from typing import Optional


def validate_username(username: str) -> bool:
    """Valida nome de usuário."""
    if not username or len(username.strip()) < 3:
        return False
        
    # Permite apenas letras, números e underscore
    pattern = r'^[a-zA-Z0-9_]+$'
    return bool(re.match(pattern, username.strip()))


def validate_password(password: str) -> bool:
    """Valida senha."""
    if not password or len(password) < 3:
        return False
    return True


def validate_email(email: str) -> bool:
    """Valida endereço de email."""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))


def validate_phone(phone: str) -> bool:
    """Valida número de telefone brasileiro."""
    # Remove caracteres não numéricos
    numbers_only = re.sub(r'\D', '', phone)
    
    # Verifica se tem 10 ou 11 dígitos (com ou sem DDD)
    return len(numbers_only) in [10, 11]


def sanitize_input(text: str) -> str:
    """Remove caracteres perigosos da entrada."""
    if not text:
        return ""
    
    # Remove caracteres de controle e espaços extras
    sanitized = re.sub(r'[\x00-\x1f\x7f-\x9f]', '', text)
    return sanitized.strip()

