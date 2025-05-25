{{ config (
    materialized='table'
    )
}}

with source as (
    select * from {{ source('marvelo', 'usuario') }}
),

stg_usuario as (
    select
        id_usuario,
        {{ tratar_string('nome') }} as nome,
        {{ tratar_string('email') }} as email,
        data_cadastro,
        {{ tratar_string('genero') }} as genero,
        idade,
        id_campanha
    from source
)

select * from stg_usuario