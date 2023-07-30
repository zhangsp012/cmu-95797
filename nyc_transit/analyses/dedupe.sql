select * from events 
qualify row_number() over (partition by event_id order by insert_timestamp desc) = 1