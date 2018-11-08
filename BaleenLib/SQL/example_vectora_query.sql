select * from 
(SELECT     
	dim_text_small_1.dim_value as 'File/Object', 
	dim_text_small_2.dim_value AS F1, 
    dim_text_small_3.dim_value AS F2, 
    dim_text_small_4.dim_value AS F3, 
    dim_text_small_5.dim_value AS F4, 
    dim_text_small.dim_value AS F5,
    baleen_020.type_or_file_key,
    baleen_020.is_line_1
FROM         baleen_020 LEFT OUTER JOIN
dim_text_small ON baleen_020.a_4 = dim_text_small.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_5 ON baleen_020.a_3 = dim_text_small_5.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_4 ON baleen_020.a_2 = dim_text_small_4.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_3 ON baleen_020.a_1 = dim_text_small_3.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_2 ON baleen_020.a_0 = dim_text_small_2.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_1 ON baleen_020.type_or_file_key = dim_text_small_1.dim_id
WHERE     (baleen_020.is_line_1 = 1)
and baleen_020.type_or_file_key = 413214
union
SELECT     
	dim_text_small_1.dim_value as 'File/Object', 
	dim_text_small_2.dim_value AS F1, 
    dim_text_small_3.dim_value AS F2, 
    dim_text_small_4.dim_value AS F3, 
    dim_text_small_5.dim_value AS F4, 
    dim_text_small.dim_value AS F5,
    baleen_020.type_or_file_key,
    baleen_020.is_line_1
FROM         baleen_020 LEFT OUTER JOIN
dim_text_small ON baleen_020.a_4 = dim_text_small.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_5 ON baleen_020.a_3 = dim_text_small_5.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_4 ON baleen_020.a_2 = dim_text_small_4.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_3 ON baleen_020.a_1 = dim_text_small_3.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_2 ON baleen_020.a_0 = dim_text_small_2.dim_id LEFT OUTER JOIN
dim_text_small AS dim_text_small_1 ON baleen_020.type_or_file_key = dim_text_small_1.dim_id
WHERE     (baleen_020.is_line_1 = 0)
and baleen_020.type_or_file_key = 413214) tbl


