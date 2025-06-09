"""
Temas e estilos da aplicação.
"""

import customtkinter as ctk


class AppTheme:
    """Gerencia temas da aplicação."""
    
    # Cores do tema escuro
    DARK_THEME = {
        "bg_color": "#212121",
        "fg_color": "#2b2b2b",
        "button_color": "#1f538d",
        "button_hover_color": "#14375e",
        "text_color": "white",
        "success_color": "#00ff00",
        "error_color": "#ff6b6b",
        "warning_color": "#ffaa00"
    }
    
    # Cores do tema claro
    LIGHT_THEME = {
        "bg_color": "#f0f0f0",
        "fg_color": "white",
        "button_color": "#3b82f6",
        "button_hover_color": "#2563eb",
        "text_color": "black",
        "success_color": "#10b981",
        "error_color": "#ef4444",
        "warning_color": "#f59e0b"
    }
    
    # Fontes
    FONTS = {
        "title": ("JetBrains Mono", 24, "bold"),
        "heading": ("JetBrains Mono", 18, "bold"),
        "body": ("JetBrains Mono", 14),
        "small": ("JetBrains Mono", 12),
        "button": ("JetBrains Mono", 14, "bold")
    }
    
    @staticmethod
    def apply_dark_theme():
        """Aplica tema escuro."""
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")
        
    @staticmethod
    def apply_light_theme():
        """Aplica tema claro."""
        ctk.set_appearance_mode("light")
        ctk.set_default_color_theme("blue")
        
    @staticmethod
    def get_font(font_type: str):
        """Retorna fonte específica."""
        return AppTheme.FONTS.get(font_type, AppTheme.FONTS["body"])
        
    @staticmethod
    def get_color(color_type: str, theme: str = "dark"):
        """Retorna cor específica do tema."""
        theme_colors = AppTheme.DARK_THEME if theme == "dark" else AppTheme.LIGHT_THEME
        return theme_colors.get(color_type, "#ffffff")

