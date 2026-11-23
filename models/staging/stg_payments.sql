with source as (

    select * from {{ source('chaipoint', 'payments') }}

),

renamed as (

    select
        id                                  as payment_id,
        order_id,
        payment_method,
        {{ paise_to_rupees('amount') }}     as amount
    from source

)

select * from renamed