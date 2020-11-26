
{% set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}

with payments_method_orders as (

	select
    	order_id,
    	{% for payment_method in payment_methods %}
    	sum(case when payment_method = '{{payment_method}}' then amount_usd end) as {{payment_method}}_amount_usd,
    	{% endfor %}
    	sum(amount_usd) as total_amount_usd
	from {{ ref('stg_payments') }}
	group by 1

),

final as (

    select

        {{ ref('stg_orders') }}.order_id,
    	{{ ref('stg_orders') }}.customer_id,
    	{{ ref('stg_orders') }}.order_date,
    	{% for payment_method in payment_methods %}
    	coalesce(payments_method_orders.{{payment_method}}_amount_usd, 0) as {{payment_method}}_amount_usd,
    	{% endfor %}
    	{{ ref('stg_orders') }}.status

    from {{ ref('stg_orders') }}

    left join payments_method_orders using (order_id)

)

select * from final




