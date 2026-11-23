with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('int_payments_pivoted_to_orders') }}

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(payments.upi_amount, 0)          as upi_amount,
        coalesce(payments.credit_card_amount, 0)  as credit_card_amount,
        coalesce(payments.wallet_amount, 0)       as wallet_amount,
        coalesce(payments.total_amount, 0)        as amount
    from orders
    left join payments using (order_id)

)

select * from final