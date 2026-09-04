-- ============================================================================
-- SCRIPT DE POPULAÇÃO DE DADOS SINTÉTICOS (PostgreSQL 17 / 18)
-- Workshop pgConf BR - Modelo de Locadora de Veículos Modernizado (v2)
-- ============================================================================

BEGIN;

-- Limpeza de dados prévios respeitando as novas tabelas e dependências
TRUNCATE TABLE pagamento, manutencao_veiculo, aluguel, filial, cliente, veiculo, modelo, montadora RESTART IDENTITY CASCADE;

-- ----------------------------------------------------------------------------
-- 1. MONTADORAS (20 registros)
-- ----------------------------------------------------------------------------
INSERT INTO montadora (nome) VALUES
    ('Toyota'), ('Volkswagen'), ('Chevrolet'), ('Fiat'), ('Hyundai'),
    ('Renault'), ('Ford'), ('Honda'), ('Jeep'), ('BYD'),
    ('Nissan'), ('Mitsubishi'), ('Peugeot'), ('Citroën'), ('Chery'),
    ('Audi'), ('BMW'), ('Mercedes-Benz'), ('Volvo'), ('Ram');

-- ----------------------------------------------------------------------------
-- 2. FILIAIS (10 registros)
-- ----------------------------------------------------------------------------
INSERT INTO filial (nome, endereco)
SELECT 
    'Filial ' || f.cidade AS nome,
    ROW(
        f.uf,
        lpad((floor(random() * 89999 + 10000)::text), 5, '0') || '-' || lpad((floor(random() * 899 + 100)::text), 3, '0'),
        f.cidade,
        'Centro',
        (floor(random() * 2000 + 100))::text,
        'Avenida Principal'
    )::endereco
FROM (VALUES 
    ('São Paulo', 'SP'), ('Rio de Janeiro', 'RJ'), ('Belo Horizonte', 'MG'),
    ('Brasília', 'DF'), ('Curitiba', 'PR'), ('Porto Alegre', 'RS'),
    ('Salvador', 'BA'), ('Recife', 'PE'), ('Goiânia', 'GO'), ('Palmas', 'TO')
) AS f(cidade, uf);

-- ----------------------------------------------------------------------------
-- 3. MODELOS (100 registros - 5 por montadora)
-- ----------------------------------------------------------------------------
INSERT INTO modelo (montadora_id, nome, categoria, portas, ar_condicionado) VALUES
    (1, 'Corolla', 'sedan', 4, true), (1, 'Yaris', 'hatch', 4, true), (1, 'Yaris Sedan', 'sedan', 4, true), (1, 'Hilux', 'picape', 4, true), (1, 'Corolla Cross', 'suv', 4, true),
    (2, 'Polo', 'hatch', 4, true), (2, 'Virtus', 'sedan', 4, true), (2, 'T-Cross', 'suv', 4, true), (2, 'Nivus', 'suv', 4, true), (2, 'Saveiro', 'picape', 2, false),
    (3, 'Onix', 'hatch', 4, true), (3, 'Onix Plus', 'sedan', 4, true), (3, 'Tracker', 'suv', 4, true), (3, 'S10', 'picape', 4, true), (3, 'Spin', 'minivan', 4, true),
    (4, 'Strada', 'picape', 2, true), (4, 'Argo', 'hatch', 4, true), (4, 'Cronos', 'sedan', 4, true), (4, 'Pulse', 'suv', 4, true), (4, 'Toro', 'picape', 4, true),
    (5, 'HB20', 'hatch', 4, true), (5, 'HB20S', 'sedan', 4, true), (5, 'Creta', 'suv', 4, true), (5, 'Tucson', 'suv', 4, true), (5, 'HR', 'van', 2, false),
    (6, 'Kwid', 'hatch', 4, true), (6, 'Stepway', 'hatch', 4, true), (6, 'Duster', 'suv', 4, true), (6, 'Kardian', 'suv', 4, true), (6, 'Master', 'van', 2, true),
    (7, 'Ranger', 'picape', 4, true), (7, 'Territory', 'suv', 4, true), (7, 'Maverick', 'picape', 4, true), (7, 'Bronco Sport', 'suv', 4, true), (7, 'Mustang', 'esportivo', 2, true),
    (8, 'City Hatch', 'hatch', 4, true), (8, 'City Sedan', 'sedan', 4, true), (8, 'Civic', 'sedan', 4, true), (8, 'HR-V', 'suv', 4, true), (8, 'ZR-V', 'suv', 4, true),
    (9, 'Renegade', 'suv', 4, true), (9, 'Compass', 'suv', 4, true), (9, 'Commander', 'suv', 4, true), (9, 'Wrangler', 'suv', 4, true), (9, 'Gladiator', 'picape', 4, true),
    (10, 'Dolphin', 'hatch', 4, true), (10, 'Dolphin Mini', 'hatch', 4, true), (10, 'Yuan Plus', 'suv', 4, true), (10, 'Song Plus', 'suv', 4, true), (10, 'Seal', 'sedan', 4, true),
    (11, 'Kicks', 'suv', 4, true), (11, 'Versa', 'sedan', 4, true), (11, 'Frontier', 'picape', 4, true), (11, 'Sentra', 'sedan', 4, true), (11, 'Leaf', 'hatch', 4, true),
    (12, 'L200 Triton', 'picape', 4, true), (12, 'Eclipse Cross', 'suv', 4, true), (12, 'Pajero Sport', 'suv', 4, true), (12, 'Outlander', 'suv', 4, true), (12, 'ASX', 'suv', 4, true),
    (13, '208', 'hatch', 4, true), (13, '2008', 'suv', 4, true), (13, '3008', 'suv', 4, true), (13, 'Partner Rapid', 'van', 2, true), (13, 'Expert', 'van', 2, true),
    (14, 'C3', 'hatch', 4, true), (14, 'C3 Aircross', 'suv', 4, true), (14, 'C4 Cactus', 'suv', 4, true), (14, 'Jumpy', 'van', 2, true), (14, 'Berlingo', 'van', 2, true),
    (15, 'Tiggo 2', 'suv', 4, true), (15, 'Tiggo 5X', 'suv', 4, true), (15, 'Tiggo 7', 'suv', 4, true), (15, 'Tiggo 8', 'suv', 4, true), (15, 'Arrizo 6', 'sedan', 4, true),
    (16, 'A3 Sedan', 'sedan', 4, true), (16, 'A4', 'sedan', 4, true), (16, 'Q3', 'suv', 4, true), (16, 'Q5', 'suv', 4, true), (16, 'e-tron GT', 'esportivo', 4, true),
    (17, 'Série 3', 'sedan', 4, true), (17, 'Série 5', 'sedan', 4, true), (17, 'X1', 'suv', 4, true), (17, 'X3', 'suv', 4, true), (17, 'X5', 'suv', 4, true),
    (18, 'Classe A', 'hatch', 4, true), (18, 'Classe C', 'sedan', 4, true), (18, 'GLA', 'suv', 4, true), (18, 'GLC', 'suv', 4, true), (18, 'Sprinter', 'van', 2, true),
    (19, 'XC40', 'suv', 4, true), (19, 'XC60', 'suv', 4, true), (19, 'XC90', 'suv', 4, true), (19, 'EX30', 'suv', 4, true), (19, 'S60', 'sedan', 4, true),
    (20, 'Rampage', 'picape', 4, true), (20, '1500', 'picape', 4, true), (20, '2500', 'picape', 4, true), (20, '3500', 'picape', 4, true), (20, 'Classic', 'picape', 4, true);

-- ----------------------------------------------------------------------------
-- 4. VEÍCULOS (200 registros com gerador de Chassi único)
-- ----------------------------------------------------------------------------
INSERT INTO veiculo (modelo_id, placa, chassi, ano_fabricacao, cor, valor_diaria_base, status, data_aquisicao, km_rodados)
SELECT 
    m.id AS modelo_id,
    chr(floor(random() * 26 + 65)::int) || 
    chr(floor(random() * 26 + 65)::int) || 
    chr(floor(random() * 26 + 65)::int) || 
    floor(random() * 10)::text || 
    chr(floor(random() * 26 + 65)::int) || 
    lpad(floor(random() * 100)::text, 2, '0') AS placa,
    
    -- Gerador sintético de Chassi (17 caracteres)
    '9BR' || chr(floor(random() * 26 + 65)::int) || chr(floor(random() * 26 + 65)::int) || 
    lpad(i::text, 4, '0') || 'Z' || lpad(floor(random() * 999999)::text, 6, '0') AS chassi,
    
    (2022 + floor(random() * 4))::integer AS ano_fabricacao,
    (ARRAY['prata', 'branco', 'preto', 'cinza', 'vermelho', 'azul'])[floor(random() * 6 + 1)]::cor_veiculo AS cor,
    round((random() * 250 + 120)::numeric, 2) AS valor_diaria_base,
    (ARRAY['disponivel', 'alugado', 'manutencao', 'inativo'])[
        CASE 
            WHEN i <= 150 THEN 1
            WHEN i <= 180 THEN 2
            WHEN i <= 193 THEN 3
            ELSE 4
        END
    ]::st_veiculo AS status,
    (CURRENT_DATE - (floor(random() * 700 + 30) || ' days')::interval)::date AS data_aquisicao,
    round((random() * 50000)::numeric, 0)::integer AS km_rodados
FROM generate_series(1, 200) AS i
CROSS JOIN LATERAL (
    SELECT id FROM modelo ORDER BY hashtext(i::text || random()::text) LIMIT 1
) m;

-- ----------------------------------------------------------------------------
-- 5. CLIENTES (600 registros com telefone e data de nascimento)
-- ----------------------------------------------------------------------------
INSERT INTO cliente (nome, documento, tipo_pessoa, email, telefone, data_nascimento, endereco)
SELECT 
    nome_final,
    documento_final,
    tipo_p,
    (
        LOWER(
            REGEXP_REPLACE(
                TRANSLATE(
                    SPLIT_PART(nome_final, ' ', 1) || '.' || COALESCE(NULLIF(SPLIT_PART(nome_final, ' ', 2), ''), 'cli'),
                    'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ',
                    'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC'
                ),
                '[^a-zA-Z0-9.]', '', 'g'
            )
        ) || i || '@exemplo.com.br'
    )::email,
    '(' || lpad((floor(random() * 89 + 11)::text), 2, '0') || ') 9' || lpad((floor(random() * 8999 + 1000)::text), 4, '0') || '-' || lpad((floor(random() * 8999 + 1000)::text), 4, '0') AS telefone,
    CASE WHEN tipo_p = 'F' THEN (CURRENT_DATE - (floor(random() * 15000 + 6500) || ' days')::interval)::date ELSE NULL END AS data_nascimento,
    ROW(
        uf_sigla,
        lpad((floor(random() * 89999 + 10000)::text), 5, '0') || '-' || lpad((floor(random() * 899 + 100)::text), 3, '0'),
        cidade_nome,
        bairro_nome,
        (floor(random() * 4500 + 10))::text,
        logra_tipo || ' ' || logra_nome
    )::endereco
FROM generate_series(1, 600) AS i
CROSS JOIN LATERAL (
    SELECT CASE WHEN (i % 3 = 0) THEN 'J'::tipo_pessoa ELSE 'F'::tipo_pessoa END AS tipo_p
) tp
CROSS JOIN LATERAL (
    SELECT cidade_nome, uf_sigla 
    FROM (VALUES 
        ('Rio Branco', 'AC'), ('Maceió', 'AL'), ('Macapá', 'AP'), ('Manaus', 'AM'),
        ('Salvador', 'BA'), ('Fortaleza', 'CE'), ('Brasília', 'DF'), ('Vitória', 'ES'),
        ('Goiânia', 'GO'), ('São Luís', 'MA'), ('Cuiabá', 'MT'), ('Campo Grande', 'MS'),
        ('Belo Horizonte', 'MG'), ('Belém', 'PA'), ('João Pessoa', 'PB'), ('Curitiba', 'PR'),
        ('Recife', 'PE'), ('Teresina', 'PI'), ('Rio de Janeiro', 'RJ'), ('Natal', 'RN'),
        ('Porto Alegre', 'RS'), ('Porto Velho', 'RO'), ('Boa Vista', 'RR'), ('Florianópolis', 'SC'),
        ('São Paulo', 'SP'), ('Aracaju', 'SE'), ('Palmas', 'TO')
    ) AS t(cidade_nome, uf_sigla) 
    ORDER BY md5(i::text || random()::text) LIMIT 1
) loc
CROSS JOIN LATERAL (
    SELECT 
        (ARRAY['Lucas', 'Gabriel', 'Beatriz', 'Rafael', 'Camila', 'Rodrigo', 'Juliana', 'Thiago', 'Fernanda', 'Bruno', 'Aline', 'Caio', 'Daniela', 'Eduardo', 'Mariana', 'Gustavo', 'Leticia', 'Matheus', 'Patricia', 'Vinicius'])[floor(abs(hashtext(i::text || random()::text)) % 20 + 1)] AS pf_n,
        (ARRAY['Silva', 'Santos', 'Oliveira', 'Souza', 'Rodrigues', 'Ferreira', 'Almeida', 'Pereira', 'Carvalho', 'Gomes', 'Martins', 'Ribeiro', 'Barbosa', 'Lima', 'Araújo', 'Costa', 'Melo', 'Castro'])[floor(abs(hashtext(i::text || 's1' || random()::text)) % 18 + 1)] AS pf_s1,
        (ARRAY['Resende', 'Valente', 'Esteves', 'Uchoa', 'Nogueira', 'Ornellas', 'Teixeira', 'Xavier', 'Holanda', 'Sampaio', 'Azevedo', 'Camargo', 'Inácio', 'Paiva', 'Machado', 'Menezes'])[floor(abs(hashtext(i::text || 's2' || random()::text)) % 16 + 1)] AS pf_s2,
        (ARRAY['Solucoes', 'Inovacao', 'Sistemas', 'Consultoria', 'Servicos', 'Logistica', 'Distribuidora', 'Comercio', 'Engenharia', 'Grupo', 'Tecnologia'])[floor(abs(hashtext(i::text || 'pjp' || random()::text)) % 11 + 1)] AS pj_p,
        (ARRAY['Digital', 'Avancada', 'Master', 'Top', 'Brasil', 'Nacional', 'Integrada', 'Global', 'Tecnica', 'Estrategica'])[floor(abs(hashtext(i::text || 'pjr' || random()::text)) % 10 + 1)] AS pj_r,
        (ARRAY['Ltda', 'SA', 'Eireli', 'ME', 'EPP'])[floor(abs(hashtext(i::text || 'pjs' || random()::text)) % 5 + 1)] AS pj_s
) nomes
CROSS JOIN LATERAL (
    SELECT 
        CASE WHEN tipo_p = 'J' THEN pj_p || ' ' || pj_r || ' ' || pj_s
             ELSE pf_n || ' ' || pf_s1 || ' ' || pf_s2 END AS nome_final,
        CASE WHEN tipo_p = 'J' THEN 
            lpad((floor(random() * 89999999 + 10000000)::text), 2, '0') || '.' ||
            lpad((floor(random() * 899 + 100)::text), 3, '0') || '.' ||
            lpad((floor(random() * 899 + 100)::text), 3, '0') || '/0001-' ||
            lpad((floor(random() * 89 + 10)::text), 2, '0')
        ELSE 
            lpad((floor(random() * 899 + 100)::text), 3, '0') || '.' ||
            lpad((floor(random() * 899 + 100)::text), 3, '0') || '.' ||
            lpad((floor(random() * 899 + 100)::text), 3, '0') || '-' ||
            lpad((floor(random() * 89 + 10)::text), 2, '0')
        END AS documento_final
) doc
CROSS JOIN LATERAL (
    SELECT 
        (ARRAY['Rua', 'Avenida', 'Alameda', 'Praça', 'Travessa', 'Rodovia'])[floor(abs(hashtext(i::text || 'log' || random()::text)) % 6 + 1)] AS logra_tipo,
        (ARRAY['7 de Setembro', 'Brasil', 'XV de Novembro', 'Paulista', 'Dom Pedro II', 'JK', 'Castro Alves', 'São José'])[floor(abs(hashtext(i::text || 'log_n' || random()::text)) % 8 + 1)] AS logra_nome,
        (ARRAY['Centro', 'Jardim América', 'Setor Sul', 'Planalto', 'Industrial', 'Bela Vista'])[floor(abs(hashtext(i::text || 'bai' || random()::text)) % 6 + 1)] AS bairro_nome
) end_data;

-- ----------------------------------------------------------------------------
-- 6. ALUGUÉIS CONSISTENTES (Com filiais de retirada e devolução)
-- ----------------------------------------------------------------------------
WITH RECURSIVE contratos_gerados AS (
    SELECT 
        v.id AS veiculo_id,
        v.modelo_id,
        1 AS sequencia,
        (v.data_aquisicao + (floor(random() * 5 + 1) || ' days')::interval)::date AS dt_inicio,
        ((v.data_aquisicao + (floor(random() * 5 + 1) || ' days')::interval)::date + (floor(random() * 7 + 1)::integer))::date AS dt_fim
    FROM veiculo v
    WHERE v.status IN ('disponivel', 'alugado')

    UNION ALL

    SELECT 
        proximo_passo.veiculo_id,
        proximo_passo.modelo_id,
        proximo_passo.sequencia + 1,
        proximo_passo.nova_dt_inicio,
        (proximo_passo.nova_dt_inicio + proximo_passo.dias_duracao)::date AS dt_fim
    FROM (
        SELECT 
            cg.veiculo_id,
            cg.modelo_id,
            cg.sequencia,
            (cg.dt_fim + (floor(random() * 3 + 1)::integer))::date AS nova_dt_inicio,
            floor(random() * 8 + 1)::integer AS dias_duracao
        FROM contratos_gerados cg
        WHERE cg.dt_fim < CURRENT_DATE AND cg.sequencia < 10
    ) proximo_passo
)
INSERT INTO aluguel (cliente_id, veiculo_id, modelo_id, filial_retirada_id, filial_devolucao_id, data_inicio, data_fim, valor_diaria, status)
SELECT 
    floor(random() * 600 + 1)::integer AS cliente_id,
    cg.veiculo_id,
    cg.modelo_id,
    floor(random() * 10 + 1)::integer AS filial_retirada_id,
    floor(random() * 10 + 1)::integer AS filial_devolucao_id,
    cg.dt_inicio,
    cg.dt_fim,
    round((random() * 280 + 120)::numeric, 2) AS valor_diaria,
    CASE 
        WHEN cg.dt_fim < CURRENT_DATE THEN 'concluido'::st_aluguel
        WHEN CURRENT_DATE BETWEEN cg.dt_inicio AND cg.dt_fim THEN 'em_andamento'::st_aluguel
        ELSE 'reservado'::st_aluguel
    END AS status
FROM contratos_gerados cg
WHERE cg.dt_inicio <= cg.dt_fim;

-- ----------------------------------------------------------------------------
-- 7. PAGAMENTOS (Associados aos aluguéis gerados)
-- ----------------------------------------------------------------------------
INSERT INTO pagamento (aluguel_id, valor, metodo, data_pagamento)
SELECT 
    a.id AS aluguel_id,
    round(((a.data_fim - a.data_inicio + 1) * a.valor_diaria)::numeric, 2) AS valor,
    (ARRAY['cartao_credito', 'cartao_debito', 'pix', 'dinheiro'])[floor(random() * 4 + 1)]::forma_pgto AS metodo,
    (a.data_inicio - (floor(random() * 3) || ' days')::interval)::timestamptz AS data_pagamento
FROM aluguel a
WHERE a.status IN ('concluido', 'em_andamento');

-- ----------------------------------------------------------------------------
-- 8. MANUTENÇÕES DOS VEÍCULOS
-- ----------------------------------------------------------------------------
INSERT INTO manutencao_veiculo (veiculo_id, data_manutencao, descricao, custo, tipo)
SELECT 
    v.id AS veiculo_id,
    (v.data_aquisicao + (floor(random() * 300 + 15) || ' days')::interval)::date AS data_manutencao,
    (ARRAY[
        'Troca de óleo do motor e filtros de ar/combustível',
        'Substituição das pastilhas e discos de freio dianteiros',
        'Alinhamento, balanceamento e rotação dos pneus',
        'Revisão do sistema elétrico e substituição de bateria',
        'Higienização do ar-condicionado e troca do filtro de cabine',
        'Troca de amortecedores e buchas da suspensão'
    ])[floor(random() * 6 + 1)] AS descricao,
    round((random() * 1200 + 150)::numeric, 2) AS custo,
    (ARRAY['preventiva', 'corretiva'])[
        CASE WHEN random() > 0.3 THEN 1 ELSE 2 END
    ] AS tipo
FROM veiculo v
CROSS JOIN generate_series(1, 2) AS m_seq
WHERE v.data_aquisicao < (CURRENT_DATE - INTERVAL '6 months');

COMMIT;