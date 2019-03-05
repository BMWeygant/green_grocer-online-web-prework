require "pry"
def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |item, result|
  #binding.pry
  item.each do |type, attributes|
    #binding.pry
    if result[type]
      attributes[:count] += 1
    else
      attributes[:count] = 1
      result[type] = attributes
      end
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
cart
end
def apply_clearance(cart)
  # code here
  cart.each do |item, result|
    #binding.pry
    new_price = nil
      if result[:clearance] == true
        new_price = result[:price] * 0.8
        result[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(cart, coupons)
  subtotal = apply_clearance(applied_coupons)
  total = 0
  subtotal.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
