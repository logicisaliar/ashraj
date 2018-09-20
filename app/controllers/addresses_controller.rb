class AddressesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def new
    @address = Address.new
    @pincodes = class_label(Pincode.all.sort_by &:pin)
    @companies = Company.all.sort_by &:name
  end

  def create
    @address = Address.new(address_params)
    @address.street = grammify(@address.street)[0]
    raise
    if @address.save!
      redirect_to addresses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to host_address_path(@address)
    else
      render :edit
    end
  end

  def index
    @addresses = Address.all
  end

  def show
  end

  private

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.pin]
    end
    return_array
  end

  def address_params
    params.require(:address).permit(:type, :street, :pincode_id, :company_id)
  end

  def set_address
    @address = Address.find(params[:address_id])
  end

  def grammify(phrase)
    phrase += " "
    process = []
    process << phrase
    phrase.upcase!
    phrase.gsub!(',', ' ,')
    phrase.gsub!('MIDC', 'M. I. D. C.')
    phrase.gsub!('GIDC', 'G. I. D. C.')
    phrase.gsub!(/\WNR\W/,'Near ')
    phrase.gsub!(/\WOP\W/,'Opposite ')
    phrase.gsub!(/\WOPP\W/,'Opposite ')
    phrase.gsub!(/\WTE\W/,'Tehsil ')
    phrase.gsub!(/\WBH\W/,'Behind ')
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
    phrase.gsub!(/^RD/,'Road ')
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

end
