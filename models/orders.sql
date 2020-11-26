with payments_orders as (

    select
        orderid as order_id,
        sum(amount) as order_amount
    from {{ ref('stg_payments') }}
    group by 1
),

final as (

    select

        {{ ref('stg_orders') }}.order_id,
    	{{ ref('stg_orders') }}.customer_id,
    	{{ ref('stg_orders') }}.order_date,
    	{{ ref('stg_orders') }}.status,
    	coalesce(payments_orders.order_amount, 0) as order_amount

    from {{ ref('stg_orders') }}

    left join payments_orders using (order_id)

)

select * from final