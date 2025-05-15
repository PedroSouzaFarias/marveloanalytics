{% macro tratar_string(nome_coluna) %} 
    UPPER(TRIM({{ nome_coluna }})) 
{% endmacro %}

{% macro extrair_data(nome_coluna) %}
    DATE(DATETIME({{ nome_coluna }}, "America/Sao_Paulo"))
{% endmacro %}

{% macro extrair_hora(nome_coluna) %}
    FORMAT_TIMESTAMP('%H:%M:%S', {{ nome_coluna }}, "America/Sao_Paulo")
{% endmacro %}