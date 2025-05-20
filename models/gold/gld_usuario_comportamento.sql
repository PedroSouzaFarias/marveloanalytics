{{ config (
    materialized='table'
    )
}}

SELECT
    CASE 
        WHEN valor_total > 0 THEN 'Comprou'
        ELSE 'Não comprou'
    END AS status_compra,
    COUNT(id_usuario) AS qtd_usuarios,
    ROUND(AVG(total_paginas_acessadas), 2) AS media_total_paginas,
    ROUND(AVG(qtd_paginas_distintas), 2) AS media_paginas_distintas,
    ROUND(AVG(valor_total), 2) AS media_valor_gasto,
FROM {{ ref('slv_usuario_comportamento') }}
GROUP BY status_compra
ORDER BY status_compra