{{ config (
  materialized='table'
  ) 
}}

with source as (
    select * from {{ source('marvelo', 'item_pedido') }}
),

stg_item_pedido as (
    select
        id_item,
        id_pedido,
        id_produto,
        quantidade,
        preco_unitario
    from source
)

select * from stg_item_pedido