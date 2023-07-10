{% macro str_to_bool(field_name) %}
    CASE 
        WHEN {{ field_name }} = 'N' THEN False 
        ELSE True 
    END
{% endmacro %}