# SCD Type 1:
## Reference: https://aws.amazon.com/blogs/database/best-practices-for-migrating-oracle-database-merge-statements-to-amazon-aurora-postgresql-and-amazon-rds-postgresql/

INSERT INTO target_scd (product_id, product_name, quantity,modified_date,expired_date)
SELECT product_id, product_name, quantity, current_timestamp as modified_date, '3000-01-01 00:00:00' as expired_date
FROM staging
ON CONFLICT (product_id)
DO UPDATE 
	SET product_name = excluded.product_name,
		quantity = excluded.quantity,
		modified_date = current_timestamp,
		expired_date = '3000-01-01 00:00:00'		
		;
    
# SCD Type 2:
WITH 
insert_new_record as (
			INSERT INTO target_scd (product_id, product_name, quantity, modified_date, expired_date, active_flag)
			SELECT staging.*, current_timestamp, '3000-01-01 00:00:00', 'A'
			FROM staging
			LEFT JOIN target_scd ON (target_scd.product_id = staging.product_id)
			WHERE target_scd.product_id IS NULL
			), 

insert_old_record_with_new_status as (
			INSERT INTO target_scd
			SELECT staging.*, current_timestamp, '3000-01-01 00:00:00', 'A'	
			FROM staging
			JOIN target_scd ON (target_scd.product_id = staging.product_id)
			AND ((target_scd.quantity != staging.quantity) OR (target_scd.product_name != staging.product_name))
			AND target_scd.active_flag = 'A'
		    returning product_id
			)
--Update old_record_with_old_status
UPDATE target_scd
SET expired_date = current_timestamp - interval '1 second',
	active_flag ='I'
FROM staging 
WHERE (target_scd.product_id = staging.product_id)
AND ((target_scd.quantity != staging.quantity) OR (target_scd.product_name != staging.product_name))
AND target_scd.active_flag = 'A'



    
