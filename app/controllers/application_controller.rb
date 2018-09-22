require 'csv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!


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
end
