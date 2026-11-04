-- ============================================================
-- BANCO DE DADOS: GESTÃO DE CHAMADOS DE TI & SUPORTE
-- ============================================================

DROP TABLE IF EXISTS chamados;

CREATE TABLE chamados (
    id_chamado INT PRIMARY KEY,
    cliente VARCHAR(100),
    categoria VARCHAR(50),
    prioridade VARCHAR(20),
    data_abertura DATETIME,
    data_fechamento DATETIME,
    status VARCHAR(20)
);

INSERT INTO chamados VALUES
(1, 'Empresa Alfa', 'Hardware', 'Alta', '2026-03-01 08:30:00', '2026-03-01 10:30:00', 'Fechado'),
(2, 'Tech Gamma', 'Software', 'Média', '2026-03-01 09:15:00', '2026-03-01 15:45:00', 'Fechado'),
(3, 'Logística Beta', 'Redes', 'Crítica', '2026-03-02 11:00:00', '2026-03-02 12:30:00', 'Fechado'),
(4, 'Varejo Delta', 'Hardware', 'Baixa', '2026-03-02 14:00:00', NULL, 'Em Andamento'),
(5, 'Farmácia Zeta', 'Software', 'Alta', '2026-03-03 10:00:00', '2026-03-03 12:00:00', 'Fechado'),
(6, 'Empresa Alfa', 'Redes', 'Média', '2026-03-03 13:20:00', '2026-03-04 09:00:00', 'Fechado');

-- ------------------------------------------------------------
-- CONSULTAS ANALÍTICAS (INDICADORES DE TI)
-- ------------------------------------------------------------

-- 1. Resumo Geral de Chamados por Status
SELECT 
    status, 
    COUNT(*) AS quantidade
FROM chamados
GROUP BY status;

-- 2. Volume de Chamados por Categoria e Prioridade
SELECT 
    categoria,
    prioridade,
    COUNT(*) AS total_chamados
FROM chamados
GROUP BY categoria, prioridade
ORDER BY total_chamados DESC;

-- 3. Tempo Médio de Resolução (TMR) em Horas para Chamados Fechados
SELECT 
    categoria,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, data_abertura, data_fechamento) / 60.0), 2) AS tmr_horas
FROM chamados
WHERE status = 'Fechado'
GROUP BY categoria;
