def calcular(expressao):
    try:
        return str(eval(expressao))
    except Exception:
        return "Erro: Expressão inválida"