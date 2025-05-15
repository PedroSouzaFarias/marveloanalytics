{{ config (
  materialized='table'
  )
}}

with source as (
    select * from {{ source('marvelo', 'pedido') }}
),

stg_pedido as (
    select
        id_pedido,
        id_usuario,
        data_pedido as data_hora_pedido,
        {{ extrair_data('data_pedido') }} as data_pedido,
        {{ extrair_hora('data_pedido') }} as hora_pedido,
        {{ tratar_string('status') }} as status,
        valor_total
    from source
)

select * from stg_pedido