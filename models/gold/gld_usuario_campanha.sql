{{ config (
    materialized='table'
    )
}}

WITH usuario_campanha AS (
  SELECT
    nome_campanha,
    nome_canal,
    mes_cadastro,
    qtd_usuario
  FROM {{ ref('slv_usuario_campanha') }}
),

-- Total de usuários por mês
total_mes AS (
  SELECT
    mes_cadastro,
    SUM(qtd_usuario) AS total_usuarios_mes
  FROM usuario_campanha
  GROUP BY mes_cadastro
),

-- Total de usuários por canal e mês
canal_mes AS (
  SELECT
    nome_canal,
    mes_cadastro,
    SUM(qtd_usuario) AS total_usuarios_canal_mes
  FROM usuario_campanha
  GROUP BY nome_canal, mes_cadastro
)

SELECT
  uc.nome_campanha,
  uc.nome_canal,
  uc.mes_cadastro,
  uc.qtd_usuario AS usuarios_campanha_mes,
  tm.total_usuarios_mes,
  ROUND(uc.qtd_usuario / tm.total_usuarios_mes, 2) AS pct_participacao_total_mes, -- Não multiplicar por 100
  cm.total_usuarios_canal_mes,
  ROUND(uc.qtd_usuario / cm.total_usuarios_canal_mes, 2) AS pct_participacao_dentro_do_canal  -- Não multiplicar por 100
FROM usuario_campanha uc
JOIN total_mes tm
  ON uc.mes_cadastro = tm.mes_cadastro
JOIN canal_mes cm
  ON uc.nome_canal = cm.nome_canal AND uc.mes_cadastro = cm.mes_cadastro
ORDER BY pct_participacao_total_mes DESC