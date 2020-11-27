{% snapshot orders_snapshot %}

{{
    config(
          target_schema='snapshots',
          strategy='check',
          unique_key='id',
          check_cols=['status'],
    )
}}

select * from {{ source('jaffle_shop', 'shop_orders') }}

{% endsnapshot %}