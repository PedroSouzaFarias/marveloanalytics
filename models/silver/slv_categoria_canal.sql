-- SILVER 
-- Quais categorias de produto mais vendem por canal?
{{ config (
    materialized = 'table'
    )
}}

SELECT
    COALESCE(ca.canal,'FACEBOOK') AS nome_canal,
    pr.categoria,
    SUM(ip.quantidade) AS quantidade_vendida,
    ROUND(SUM(ip.preco_unitario * ip.quantidade), 2) AS valor_total
FROM
    {{ ref('stg_item_pedido') }} ip
JOIN
    {{ ref('stg_produto') }} pr
    ON ip.id_produto = pr.id_produto
LEFT JOIN
    {{ ref('stg_campanha') }} ca
    ON pr.id_campanha = ca.id_campanha
GROUP BY
    ca.canal,
    pr.categoria
ORDER BY
    valor_total DESC