# Welcome controller
# @controller_name is used for declaring class on html body
# this is how you can make use of your javascript dependent on the conroller
class Welcome
  attr_accessor :controller_name

  def initialize(controller_name = 'welcome')
    @controller_name = controller_name
  end

  def index
    say_hello('This string is created in the controller.')
  end

  def say_hello(word)
    word.to_s
  end
end
