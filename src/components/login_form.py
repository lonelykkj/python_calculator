"""
Componente de formulário de login.
"""

import customtkinter as ctk
from utils.auth import AuthManager
from utils.validators import validate_username, validate_password


class LoginForm(ctk.CTkFrame):
    """Formulário de login reutilizável."""
    
    def __init__(self, parent):
        super().__init__(parent)
        
        self.parent = parent
        self.auth_manager = AuthManager()
        
        self.setup_form()
        
    def setup_form(self):
        """Configura os elementos do formulário."""
        # Campo de usuário
        self.label_user = ctk.CTkLabel(
            self,
            text="Usuário",
            font=("JetBrains Mono", 16),
            text_color="white"
        )
        self.label_user.pack(pady=(0, 5))
        
        self.entry_user = ctk.CTkEntry(
            self,
            placeholder_text="Digite seu usuário",
            width=300,
            height=40,
            font=("JetBrains Mono", 14)
        )
        self.entry_user.pack(pady=(0, 15))
        
        # Campo de senha
        self.label_password = ctk.CTkLabel(
            self,
            text="Senha",
            font=("JetBrains Mono", 16),
            text_color="white"
        )
        self.label_password.pack(pady=(0, 5))
        
        self.entry_password = ctk.CTkEntry(
            self,
            placeholder_text="Digite sua senha",
            width=300,
            height=40,
            font=("JetBrains Mono", 14),
            show="*"
        )
        self.entry_password.pack(pady=(0, 20))
        
        # Botão de login
        self.login_button = ctk.CTkButton(
            self,
            text="Entrar",
            command=self.handle_login,
            width=300,
            height=45,
            font=("JetBrains Mono", 16, "bold"),
            fg_color="#1f538d",
            hover_color="#14375e"
        )
        self.login_button.pack(pady=(0, 15))
        
        # Label de resultado
        self.result_label = ctk.CTkLabel(
            self,
            text="",
            font=("JetBrains Mono", 12),
            wraplength=280
        )
        self.result_label.pack(pady=10)
        
        # Bind Enter key
        self.entry_password.bind("<Return>", lambda event: self.handle_login())
        self.entry_user.bind("<Return>", lambda event: self.entry_password.focus())
        
    def handle_login(self):
        """Gerencia o processo de login."""
        username = self.entry_user.get().strip()
        password = self.entry_password.get()
        
        # Validações
        if not validate_username(username):
            self.show_error("Nome de usuário inválido")
            return
            
        if not validate_password(password):
            self.show_error("Senha deve ter pelo menos 3 caracteres")
            return
            
        # Tenta fazer login
        if self.auth_manager.authenticate(username, password):
            self.show_success(f"Bem-vindo, {username}!")
            # Chama callback do parent se existir
            if hasattr(self.parent, 'on_login_success'):
                self.parent.on_login_success(username)
        else:
            self.show_error("Usuário ou senha incorretos")
            if hasattr(self.parent, 'on_login_failure'):
                self.parent.on_login_failure("Credenciais inválidas")
                
    def show_success(self, message):
        """Mostra mensagem de sucesso."""
        self.result_label.configure(
            text=message,
            text_color="#00ff00"
        )
        
    def show_error(self, message):
        """Mostra mensagem de erro."""
        self.result_label.configure(
            text=message,
            text_color="#ff6b6b"
        )
        
    def clear_form(self):
        """Limpa o formulário."""
        self.entry_user.delete(0, 'end')
        self.entry_password.delete(0, 'end')
        self.result_label.configure(text="")
        self.entry_user.focus()

