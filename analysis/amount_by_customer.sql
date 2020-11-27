-- analysis/running_total_by_account.sql

with orders as (

  select *
  from {{ ref('stg_orders') }}

), payments_orders as (

  select *
  from {{ ref('stg_payments') }}

)

select
  orders.customer_id,
  order_id,
  payment_id,
  payment_method,
  orders.order_date,
  sum(amount_usd) over (partition by orders.customer_id order by order_id rows unbounded preceding)
from payments_orders
right join orders using (order_id)
order by orders.customer_id