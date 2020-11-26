
with source as (
    
    select * from {{ source('stripe', 'payments') }}
    
),

renamed_success as (
    
	select    
    	id as payment_id,
    	orderid as order_id,
    	{{ cents_to_dollars('amount') }} as amount_usd,
    	paymentmethod as payment_method,
    	created

	from source where status='success'

)

select * from renamed_success