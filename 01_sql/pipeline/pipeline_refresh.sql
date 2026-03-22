CREATE OR REPLACE PROCEDURE pipeline.pipeline_refresh()
LANGUAGE plpsql
AS $$
BEGIN
	RAISE NOTICE 'Refreshing silver layer....'
	CALL silver.refresh_silver_tables();

	RAISE NOTICE 'Refreshing gold layer....'
	CALL gold.refresh_fact_order_summary();
	
	RAISE NOTICE 'Pipeline completed sucessfully'
END;
$$;