import pandas as pd

# 1. Carregar base bruta (com dados nulos e formatos inconsistentes)
data = {
    'id_cliente': [101, 102, 103, 104, 105, 105],
    'nome': [' Ana Silva ', 'Carlos Souza', 'MARIA OLIVEIRA', 'joão pedro', 'Lucas Lima', 'Lucas Lima'],
    'valor_gasto': ['R$ 150.50', 'R$ 200.00', None, 'R$ 50.00', 'R$ 300.00', 'R$ 300.00'],
    'data_cadastro': ['2026-01-10', '2026-01-12', '2026/01/15', '2026-01-20', '2026-01-22', '2026-01-22']
}

df = pd.DataFrame(data)

print("--- Dados Brutos ---")
print(df)

# 2. Remoção de duplicatas
df = df.drop_duplicates()

# 3. Limpeza de strings (espaços extras e padronização para Capitalize)
df['nome'] = df['nome'].str.strip().str.title()

# 4. Tratamento do campo financeiro (remover 'R$' e converter para float)
df['valor_gasto'] = df['valor_gasto'].str.replace('R$', '', regex=False).astype(float)

# 5. Tratamento de valores ausentes (preenchendo pela média da coluna)
media_gastos = df['valor_gasto'].mean()
df['valor_gasto'] = df['valor_gasto'].fillna(media_gastos).round(2)

# 6. Padronização de datas
df['data_cadastro'] = pd.to_datetime(df['data_cadastro']).dt.strftime('%Y-%m-%d')

print("\n--- Dados Tratados e Limpos ---")
print(df)

# 7. Exportação do resultado limpo
df.to_csv('clientes_limpos.csv', index=False)
print("\nArquivo 'clientes_limpos.csv' gerado com sucesso!")
