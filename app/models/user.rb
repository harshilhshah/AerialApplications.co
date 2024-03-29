class User < ActiveRecord::Base
  require 'stripe'
  Stripe.api_key = "sk_test_4xudmwlD9S7Hd4e2X28Ki9dh"
  @email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_save :encrypt_password
  before_create :set_user_type
  before_create :set_stripe_id
  before_create :confirmation_token
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email,:with => @email_regex
  attr_accessor :card_number, :exp_month, :exp_year, :cvc
  has_many :charges
  belongs_to :company
  has_one :company, :foreign_key => :id
  accepts_nested_attributes_for :company

  #after_save :clear_password
  def balance #This should really be implemented
    0
  end
  def name
    self.firstName + " " + self.lastName
  end
  def payout_balance #This should unfortunately be implemented
    0
  end
  def payout_total
    0
  end
  def payment_total
    0
  end
  def encrypt_password
    if password.present?
      self.password_enc= BCrypt::Password.create(password)
    end
    self.password = nil
  end
  def set_stripe_id
    customer = Stripe::Customer.create()
    self.stripe_id = customer.id
  end
  def set_user_type
    if self.userTypeId.nil?
      self.userTypeId = UserType.find_by_description("New User").id
    end
  end
  def add_card(name,number,month,year,cvc)
    begin 
      token = Stripe::Token.create(
        :card => {
        :name=>name,
        :number => number,
        :exp_month => month,
        :exp_year => year,
        :cvc => cvc
        }
      )
      customer = Stripe::Customer.retrieve(self.stripe_id)
      customer.sources.create(source: token) 
      return nil
    rescue => e
      return e.message
    end
  end
  def update_card(card_id, name, month, year)
    begin
      card = Stripe::Customer.retrieve(self.stripe_id).sources.retrieve(card_id)
      card.name = name
      card.exp_month = month
      card.exp_year = year
      card.save
      return nil
    rescue => e
      return e.message
    end
  end
  def remove_card(card_id)
    begin
      Stripe::Customer.retrieve(self.stripe_id).sources.retrieve(card_id).delete()
      return nil
    rescue => e
      return e.message
    end
  end
  def cards
    Stripe::Customer.retrieve(self.stripe_id).sources.all(object: :card).data
  end
  def get_card(card_id)
    Stripe::Customer.retrieve(self.stripe_id).sources.retrieve(card_id)
  end
  def get_default_id
    return Stripe::Customer.retrieve(self.stripe_id).default_source
  end
  def set_default_card(card_id)
    customer = Stripe::Customer.retrieve(self.stripe_id)
    customer.default_source = card_id
    customer.save
  end
  def charge(amount)
    amount_cents = (amount*100).to_i
    response = Stripe::Charge.create(
      amount: amount_cents,
      currency: :usd,
      customer: self.stripe_id
    )
    Rails.logger.debug(response)
    Rails.logger.debug(response.failure_code)
    self.charges.create({amount: amount, refunded: false, last_four: response.source.last4})
    return response.failure_code == nil
  end
  def clear_password
    self.password = nil
  end
  def is_admin?
    return self.userTypeId == UserType.find_by_description("Admin").id
  end
  def is_client?
    return self.userTypeId == UserType.find_by_description("Client").id
  end
  def is_affiliate?
    return self.userTypeId == UserType.find_by_description("Affiliate").id
  end
  def is_sales_rep?
    return self.userTypeId == UserType.find_by_description("Sales Rep").id
  end
  def is_new_user?
    return self.userTypeId == UserType.find_by_description("New User").id
  end
  def self.authenticate(username_or_email="", login_password="")
    if is_email(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end
    if user && user.match_password(login_password, user)
      return user
    else
      return false
    end
  end   
  def match_password(login_password="", user)
    user_pass = BCrypt::Password.new(user.password_enc)
    return user_pass == login_password
  end
  def self.is_email(email)
    (email =~ @email_regex)
  end
  def get_company
    if self.company_id == nil
      return nil
    else
      return Company.find(self.company_id)
    end
  end
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  private
  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
  end
end
