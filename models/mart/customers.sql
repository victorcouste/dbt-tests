
with customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from {{ ref('stg_orders') }}

    group by 1

),


final as (

    select
        {{ ref('stg_customers') }}.customer_id,
        {{ ref('stg_customers') }}.first_name,
        {{ ref('stg_customers') }}.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from {{ ref('stg_customers') }}

    left join customer_orders using (customer_id)

)

select * from final