{% macro str_to_bool(field_name, true_value="Y", false_value="N", null_value=" ") %}
(    CASE 
        when {{field_name}} = '{{true_value}}' then true
        when {{field_name}} = '{{false_value}}' then false
        when {{field_name}} = '{{null_value}}' then null
        when {{field_name}} is null then null
        else {{field_name}}
    END) :: bool
{% endmacro %}