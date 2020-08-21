class Event
  attr_accessor :name, :desc
  def initialize(name, desc)
    @name = name
    @desc = desc
  end

  def show
    print "#{@name}\t\t #{@desc}\n"
  end
end
