{% set payment_methods = ['upi', 'credit_card', 'wallet'] %}
with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select
        order_id,
        {% for method in payment_methods %}
        sum(case when payment_method = '{{ method }}' then amount else 0 end) 
            as {{ method }}_amount,
        {% endfor %}
        sum(amount) as total_amount
    from payments
    group by order_id

)
select * from pivoted