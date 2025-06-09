"""
Gerenciador de autenticação.
"""

import hashlib
from typing import Dict, Optional


class AuthManager:
    """Gerencia autenticação de usuários."""
    
    def __init__(self):
        # Em um projeto real, isso viria de um banco de dados
        self.users = {
            "admin": self._hash_password("password"),
            "user": self._hash_password("123456"),
            "demo": self._hash_password("demo")
        }
        
    def _hash_password(self, password: str) -> str:
        """Hash da senha usando SHA256."""
        return hashlib.sha256(password.encode()).hexdigest()
        
    def authenticate(self, username: str, password: str) -> bool:
        """Autentica usuário."""
        if username not in self.users:
            return False
            
        hashed_password = self._hash_password(password)
        return self.users[username] == hashed_password
        
    def add_user(self, username: str, password: str) -> bool:
        """Adiciona novo usuário."""
        if username in self.users:
            return False
            
        self.users[username] = self._hash_password(password)
        return True
        
    def change_password(self, username: str, old_password: str, new_password: str) -> bool:
        """Altera senha do usuário."""
        if not self.authenticate(username, old_password):
            return False
            
        self.users[username] = self._hash_password(new_password)
        return True
        
    def get_users(self) -> list:
        """Retorna lista de usuários cadastrados."""
        return list(self.users.keys())

