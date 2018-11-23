require 'csv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  #             0           1             2         3           4           5             6
  STATUS = ["pending", "completed", "confirmed", "packed", "invoiced", "dispatched", "released"]

  private

  def grammify(phrase)
    phrase += " "
    process = []
    process << phrase
    phrase.upcase!
    5.times do
      phrase.gsub!(' .', '.')
    end
    phrase.gsub!(',', ' , ')
    phrase.gsub!('MIDC', 'M. I. D. C.')
    phrase.gsub!('GIDC', 'G. I. D. C.')
    phrase.gsub!(/\WNR\W/,'Near ')
    phrase.gsub!(/\WOP\W/,'Opposite ')
    phrase.gsub!(/\WOPP\W/,'Opposite ')
    phrase.gsub!(/\WTE\W/,'Tehsil ')
    phrase.gsub!(/\WBH\W/,'Behind ')
    phrase.gsub!(/\WBLDG/,'Building ')
    phrase.gsub!(/\WAPT/,'Apartment ')
    phrase.gsub!(/\WBLDG\W/,'Building ')
    phrase.gsub!(/\WAPT\W/,'Apartment ')
    phrase.gsub!(/\WRD/,'Road ')
    phrase.gsub!('BYE PASS', 'Bypass')
    phrase.gsub!('BYEPASS', 'Bypass')
    phrase.gsub!('(', ' (')
    phrase.gsub!(')', ') ')
    phrase.gsub!(';', ':')
    5.times do
      phrase.gsub!(' -', '-')
      phrase.gsub!('- ', '-')
      phrase.gsub!(' :', ':')
      phrase.gsub!(' .', '.')
      phrase.gsub!('( ', '(')
      phrase.gsub!(' )', ')')
      phrase.gsub!(' /', '/')
      phrase.gsub!(' ,', ',')
      phrase.gsub!('/ ', '/')
    end
    # At the end
    phrase.gsub!(/^NR\W/,'Near ')
    phrase.gsub!(/^OP\W/,'Opposite ')
    phrase.gsub!(/^OPP\W/,'Opposite ')
    phrase.gsub!(/^TE\W/,'Tehsil ')
    phrase.gsub!(/^BH\W/,'Behind ')
    phrase.gsub!(':', ': ')
    phrase.gsub!('.', '. ')
    phrase.gsub!(',', ', ')
    10.times do
      if phrase[-1] =~ /\W/
        phrase = phrase[0..(phrase.length - 2)]
      end
    end
    process << phrase.titlecase
    return process
  end

  def calculations (o)

    if o.order_num.nil?
      s = 1
      unless Order.all.length == 1
        a = Order.all.sort_by(&:id)[-2].order_num
        if Date.today.month == (a / 100000) % 100
          s = (a % 1000) + 1
        end
      end
      o.order_num = ((Date.today.year % 2000) * 10000000 ) + ((Date.today.month) * 100000) + ((Date.today.day) * 1000) + s
    end
    o.invoice_subtotal = 0
    o.quantity_kg = 0
    o.quantity_l = 0
    o.sample_kg = 0
    o.sample_l = 0
    o.igst = 0
    o.cgst = 0
    o.sgst = 0
    gst = 0
    o.items.each do |i|
      if i.packing.sample
        if i.product.unit = "Ltr"
          o.sample_l += i.total
        else
          o.sample_kg += i.total
        end
      else
        if i.product.unit = "Ltr"
          o.quantity_l += i.total
        else
          o.quantity_kg += i.total
        end
        gst += i.product.gst * i.rate * i.total / 100
        o.invoice_subtotal += i.rate * i.total
        o.invoice_amount = o.invoice_subtotal + gst
      end
      unless o.courier_charge == 0
        gst += o.courier_charge * 0.18
      end
      address_id = o.company.addresses.where(kind: 1).ids[0]
      address = Address.find(address_id)
      if address.pincode.city.state.code == 27
        o.cgst = gst / 2
        o.sgst = gst / 2
      else
        o.igst = gst
      end
    end

    # if o.company.kind == 3
    #   o.brokerage = calculate_brokerage(o)
    # end
    o
  end

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.name]
    end
    return_array
  end

  def packing_label(cls)
    return_array = []
    cls.each do |p|
      if p.sample
        a = "#{p.pack_size} (Sample)"
      else a = p.pack_size
      end
      return_array << [p.id, a]
    end
    return_array
  end

  def calculate_item(i)
    i.total = i.quantity * i.packing.pack_size
    if i.packing.sample
      i.mrp = 0
      i.rate = 0
      i.gst = 0
      i.amount = 0
      i.discount = 0
    else
      i.mrp = i.product.mrp - i.packing.rebate
      i.rate = i.mrp * (100 - i.discount) / 100
      i.amount = i.total * i.rate
      i.gst = i.amount * i.product.gst
    end
    i
  end

  def calculate_brokerage(o)
    b = 0
    o.items.each do |i|
      b += ((i.product.discount - i.discount) * i.mrp) / 100
    end
    o.brokerage = b
    return o
  end

  def current_financial_year?(d)
    t = Date.today
    if d.year == t.year
      if (t.month > 3 && d.month > 3) || (t.month < 4 && d.month < 4)
        return true
      else
        false
      end
    elsif d.year == t.year - 1
      if d.month > 3
        return true
      else
        return false
      end
    elsif d.year == t.year + 1
      raise
    else
      return false
    end
  end

  def truncate_num(arr, char)
    string = ""
    if arr[0].nil?
      return string
    elsif arr.length == 1
      string << arr[0].num
    else
      string << arr[0].num
      arr.each_with_index do |a, i|
        if i > 0
          string << ", #{arr[i].num}"
        end
      end
    end
    return string.truncate(char)
  end

  def truncate_mail(arr, char)
    string = ""
    if arr[0].nil?
      return string
    end
    if arr.length == 1
      string << arr[0].eadd
    else
      string << arr[0].eadd
      arr.each_with_index do |a, i|
        if i > 0
          string << ", #{arr[i].eadd}"
        end
      end
    end
    return string.truncate(char)
  end
end
