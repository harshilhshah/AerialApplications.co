json.array!(@charges) do |charge|
  json.extract! charge, :id, :amount, :customer_id, :refunded, :last_four
  json.url charge_url(charge, format: :json)
end
