{% macro tratar_string(nome_coluna) %} 
    LEFT(UPPER(TRIM({{ nome_coluna }})), 100)
{% endmacro %}

{% macro extrair_data(nome_coluna) %}
    DATE(DATETIME({{ nome_coluna }}, "America/Sao_Paulo"))
{% endmacro %}

{% macro extrair_hora(nome_coluna) %}
    FORMAT_TIMESTAMP('%H:%M:%S', {{ nome_coluna }}, "America/Sao_Paulo")
{% endmacro %}

{% macro tratar_null(nome_coluna, tipo) %}
    {% set tipo = tipo | lower %}

    {% if tipo == 'string' %}
        coalesce({{ nome_coluna }}, 'N.I')

    {% elif tipo == 'int' %}
        coalesce({{ nome_coluna }}, 0)

    {% elif tipo == 'float' %}
        coalesce({{ nome_coluna }}, 0.0)

    {% elif tipo == 'timestamp' %}
        coalesce({{ nome_coluna }}, '1900-01-01')

    {% else %}
        {{ nome_coluna }}
    {% endif %}
{% endmacro %}