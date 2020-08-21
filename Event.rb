class Event
  attr_accessor :name, :desc
  def initialize(name, desc)
    @name, @desc = name, desc
  end

  def show
    print "#{@name}\t\t #{@desc}\n"
  end
end
