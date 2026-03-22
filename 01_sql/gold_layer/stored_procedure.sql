/*==============================================================
Stored Procedure
Refresh materialized view
==============================================================*/

CREATE OR REPLACE PROCEDURE gold.refresh_fact_order_summary()
LANGUAGE plpgsql
AS $$

BEGIN

REFRESH MATERIALIZED VIEW gold.fact_order_summary;

END;

$$;