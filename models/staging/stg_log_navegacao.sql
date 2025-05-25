{{ config (
	materialized='table'
	) 
}}

with source as (
    select * from {{ source('marvelo', 'logs_navegacao') }}
),

stg_log_navegacao as (
    select
        id_log,
        id_usuario,
        timestamp as data_hora_navegacao,
        {{ extrair_data('timestamp') }} as data_navegacao,
        {{ extrair_hora('timestamp') }} as hora_navegacao,
        {{ tratar_string('pagina') }} as pagina,
        tempo_sessao_seg,
        {{ tratar_string('dispositivo') }} as dispositivo,
        {{ tratar_string('origem') }} as origem
    from source
)

select * from stg_log_navegacao