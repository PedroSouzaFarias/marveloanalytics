-- SILVER 
-- Quais campanhas estão trazendo mais usuários para a plataforma?

{{ config (
    materialized='table'
    )
}}

SELECT
    coalesce(ca.nome_campanha, 'N.I') as nome_campanha,
    coalesce(ca.canal, 'N.I') as nome_canal,
    EXTRACT(MONTH FROM us.data_cadastro) AS mes_cadastro,
    COUNT(us.id_usuario) AS qtd_usuario
FROM {{ ref('stg_usuario') }} us
LEFT JOIN {{ ref('stg_campanha') }} ca
    ON us.id_campanha = ca.id_campanha
GROUP BY
    ca.nome_campanha,
    ca.canal,
    EXTRACT(MONTH FROM us.data_cadastro)
ORDER BY qtd_usuario DESC