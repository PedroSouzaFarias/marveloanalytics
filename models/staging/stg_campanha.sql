{{ config (
  materialized='table'
  )
}}

with source as (
    select * from {{ source('marvelo', 'campanha') }}
),

stg_campanha as (
    select
        id_campanha,
        {{ tratar_string('nome_campanha') }} as nome_campanha,
        {{ tratar_string('canal') }} as canal,
        data_inicio,
        data_fim,
        {{ tratar_string('tipo') }} as tipo
    from source
)

select * from stg_campanha