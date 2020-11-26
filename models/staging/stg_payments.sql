select
    id as payment_id,
    orderid,
    amount,
    paymentmethod,
    created

from {{ source('stripe', 'payments') }} where status='success'