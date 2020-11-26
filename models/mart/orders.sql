with payments_orders as (

    select
        order_id,
        sum(amount_usd) as order_amount_usd
    from {{ ref('stg_payments') }}
    group by 1
),

final as (

    select

        {{ ref('stg_orders') }}.order_id,
    	{{ ref('stg_orders') }}.customer_id,
    	{{ ref('stg_orders') }}.order_date,
    	{{ ref('stg_orders') }}.status,
    	coalesce(payments_orders.order_amount_usd, 0) as order_amount_usd

    from {{ ref('stg_orders') }}

    left join payments_orders using (order_id)

)

select * from final