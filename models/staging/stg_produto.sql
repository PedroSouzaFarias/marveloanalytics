{{ config (
  materialized='table'
  )
}}

with source as (
    select * from {{ source('marvelo', 'produto') }}
),

stg_produto as (
    select
        id_produto,
        {{ tratar_string('nome_produto') }} as nome_produto,
        {{ tratar_string('categoria') }} as categoria,
        preco,
        estoque,
        id_campanha
    from source
)

select * from stg_produto