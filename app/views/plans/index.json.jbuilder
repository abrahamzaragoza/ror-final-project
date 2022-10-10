json.plans do
    json.array! @plans, :id, :plan_name, :price_cents, :price_currency, :plan_members, :plan_duration, :stripe_product_id, :stripe_price_id, :created_at, :updated_at
end
