require "pry" 

def items
	cart= [
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
end

def coupons
	coupons=[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]
end

def consolidate_cart(cart)
 new_cart={} 
 cart.each do |hash| 
   hash.each do |name,description|
     
     if new_cart[name]
       new_cart[name][:count]+=1 
       
       else
        new_cart[name] = description 
        new_cart[name][:count] = 1
        end
    end
  end
  new_cart
end


def apply_coupons(cart,coupons)
  discounted_cart={}
  cart.each do |item,info|
    coupons.each do |coupon|
      if item== coupon[:item] && info
  new_cart=cart
  coupons.each do |coupon| 
    name= coupon[:item]
    num_of_coupons = coupon[:num]
     if cart.include?(name) && cart[name][:count] >= num_of_coupons
       new_cart[name][:count] -= num_of_coupons
         if new_cart["#{name}W/COUPON"]
         new_cart["#{name}W/COUPON"][:count] += 1
       else
          new_cart["#{name} W/COUPON"] = {
           :price => coupon[:cost],
           :clearance => new_cart[name][:clearance],
           :count => 1
         }
       end
     end
   end
   new_cart
end


def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
      if hash[:clearance] 
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  end
  new_cart 
end


def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)

total = 0
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

if total >= 100
    total *= 0.9
  end
  total
end
