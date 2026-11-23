{{
    config(
        materialized = 'incremental',
        unique_key = 'order_id',
        incremental_strategy = 'merge',
        on_schema_change = 'append_new_columns'
    )
}}

select
    order_id,
    customer_id,
    order_date,
    status
from {{ ref('stg_orders') }}

{% if is_incremental() %}
  -- re-process the last 3 days so late-arriving rows are picked up
  where order_date >= (
      select {{ dbt.dateadd('day', -3, 'max(order_date)') }} from {{ this }}
  )
{% endif %}