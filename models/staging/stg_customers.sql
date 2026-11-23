with source as (

    select * from {{ source('chaipoint', 'customers') }}

),

renamed as (

    select
        id                                   as customer_id,
        first_name,
        last_name,
        first_name || ' ' || last_name       as full_name,
        lower(email)                         as email,
        city,
        cast(created_at as date)             as signup_date
    from source

)

select * from renamed