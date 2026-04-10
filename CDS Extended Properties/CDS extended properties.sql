-- NECS Extended CDS properties
-- USE Database_name

SELECT  
    s.name AS [schema_name],
    O.name AS [object_name],
    O.type AS [object_type],
    c.name AS [column_name], 
    ep.name AS [extended_property_key],
    REPLACE(CAST(ep.value AS VARCHAR(8000)),CHAR(13)+CHAR(10),' | ') AS [extended_value]
FROM 
    sys.columns AS c 
    INNER JOIN 
    sys.all_objects O ON c.object_id = O.object_id 
    LEFT JOIN 
    sys.extended_properties EP ON ep.major_id = c.object_id AND ep.minor_id = c.column_id   
    LEFT JOIN
    sys.schemas S ON O.schema_id = S.schema_id
--WHERE s.name in ('APC','OP','ECDS','MHSDS','CSDS')
ORDER BY s.name, o.name, c.name
 