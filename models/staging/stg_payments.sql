select
    id as payment_id,
    orderid,
    amount,
    paymentmethod,
    created

from {{ source('stripe', 'stripe_payments') }} where status='success'