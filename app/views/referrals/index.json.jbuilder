json.array!(@referrals) do |referral|
  json.extract! referral, :id, :referringUserId, :referredUserId
  json.url referral_url(referral, format: :json)
end
