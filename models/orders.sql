select
*
from {{ source('jaffle_shop', 'jaffle_shop_orders') }}

left join {{ source('jaffle_shop', 'jaffle_shop_customers') }} using (id)
