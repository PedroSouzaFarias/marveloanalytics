-- SILVER 
-- Usuários que acessam mais páginas compram mais? 

{{ config (
    materialized='table'
    )
}}

WITH pedidos AS (
    SELECT
        id_usuario,
        ROUND(SUM(valor_total), 2) AS valor_total
    FROM {{ ref('stg_pedido') }}
    GROUP BY id_usuario
),

logs AS (
    SELECT
        id_usuario,
        COUNT(pagina) AS total_paginas_acessadas,
        COUNT(DISTINCT pagina) AS qtd_paginas_distintas
    FROM {{ ref('stg_log_navegacao') }}
    GROUP BY id_usuario
)

SELECT
    lo.id_usuario,
    lo.total_paginas_acessadas,
    lo.qtd_paginas_distintas,
    COALESCE(pe.valor_total, 0) AS valor_total
FROM logs lo
LEFT JOIN pedidos pe
    ON lo.id_usuario = pe.id_usuario
