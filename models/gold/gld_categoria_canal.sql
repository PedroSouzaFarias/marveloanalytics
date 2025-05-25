{{ config (
    materialized='table'
    )
}}

WITH categoria_canal AS (
  SELECT
    nome_canal,
    categoria,
    quantidade_vendida,
    valor_total
  FROM {{ ref('slv_categoria_canal') }}
),

ranking AS (
  SELECT
    *,
    RANK() OVER (PARTITION BY nome_canal ORDER BY valor_total DESC) AS posicao,
    ROUND(valor_total / NULLIF(quantidade_vendida, 0), 2) AS ticket_medio
  FROM categoria_canal
)

SELECT
  nome_canal,
  categoria,
  quantidade_vendida,
  valor_total,
  ticket_medio,
  posicao
FROM ranking
ORDER BY nome_canal, posicao