
{% macro calculate_window_day_metrics(column_name, window_definition) %}
    min({{ column_name }}) OVER {{ window_definition }} AS seven_day_min_{{ column_name }}, 
    max({{ column_name }}) OVER {{ window_definition }} AS seven_day_max_{{ column_name }}, 
    avg({{ column_name }}) OVER {{ window_definition }} AS seven_day_avg_{{ column_name }}, 
    sum({{ column_name }}) OVER {{ window_definition }} AS seven_day_sum_{{ column_name }}
{% endmacro %}