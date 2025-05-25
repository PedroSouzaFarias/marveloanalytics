{{ config (
    materialized='table'
    )
}}

SELECT
    CASE
        WHEN total_paginas_acessadas BETWEEN 1 AND 3 THEN '1-3 páginas'
        WHEN total_paginas_acessadas BETWEEN 4 AND 6 THEN '4-6 páginas'
        WHEN total_paginas_acessadas BETWEEN 7 AND 10 THEN '7-10 páginas'
        ELSE '11-16 páginas'
    END AS qtd_paginas,
    COUNT(id_usuario) AS qtd_usuarios,
    SUM(CASE WHEN valor_total > 0 THEN 1 ELSE 0 END) AS qtd_compradores,
    ROUND(AVG(valor_total), 2) AS media_valor_gasto,
    ROUND(100.0 * SUM(CASE WHEN valor_total > 0 THEN 1 ELSE 0 END) / COUNT(id_usuario), 2) AS taxa_conversao
FROM {{ ref('slv_usuario_comportamento') }}
GROUP BY qtd_paginas
ORDER BY taxa_conversao DESC