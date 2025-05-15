{% snapshot usuario_snapshot %}

{{ config (
    target_schema='snapshot',
    target_database='marveloanalytics',
    unique_key='id_usuario',
    strategy='check',
    check_cols=['nome', 'email', 'genero', 'idade']
    )
}}

select
    id_usuario,
    nome,
    email,
    data_cadastro,
    genero,
    idade,
    id_campanha
from {{ ref('stg_usuario') }}

{% endsnapshot %}