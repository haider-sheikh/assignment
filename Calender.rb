require_relative 'Event'

class Calendar
  def initialize
    @hash = {}
  end

  public

  def display_portal
    loop do
      puts "\n\t\t****Welcome to Calendar****"
      puts "\t\t 1. Add New Event"
      puts "\t\t 2. Remove Event"
      puts "\t\t 3. Edit Event"
      puts "\t\t 4. Print Month View"
      puts "\t\t 5. Events on speicific date"
      puts "\t\t 6. View All Events of a month"
      puts "\t\t 7. Exit\n\n"

      print "\t\t Enter Choice : "
      @choice = gets.chomp

      break if @choice.eql? '7'

      print "\n\t\t Wrong Input \n" if !((1..7).include? @choice.to_i)

      evaluate
    end
  end

  protected

  def take_input
    print "\t\t Enter Month(1..12) : "
    month = gets.to_i

    print "\t\t Enter Day(1..31) : "
    day = gets.to_i

    print "\t\t Enter Year : "
    year = gets.to_i

    [year, month, day]
  end

  def edit_event
    puts "\n\t\t****Edit Event****"

    input = take_input

    begin
      date = Date.new(input[0], input[1], input[2])
      date = date.to_s.to_sym

      if @hash.key? date
        print "\t\t\t\t Events on #{date}\n"
        puts "\t\tIndex \t\t Event Name \t Event Desc"

        @hash[date].each_with_index do |event, idx|
          print "\t\t#{idx + 1}\t\t"
          event.show
        end

        print "\n\t\tEnter index to edit : "
        input = gets.chomp.to_i

        if input > 0 && @hash[date].include?(@hash[date][input - 1])

          event = @hash[date][input - 1]

          puts "\t\t Old event name : #{event.name}"

          puts "\t\t Old event desc : #{event.desc}\n"

          print "\t\t Enter New event name : "
          name_of_event = gets.chomp

          print "\t\t Enter New event desc : "
          desc_of_event = gets.chomp

          event.name, event.desc = name_of_event, desc_of_event

          puts "\n\t\t Event Updated Successfully......\n"

        else
          puts "\n\t\tInvalid index\n"
        end
      else
        puts "\n\t\tNo Event for this date......\n"
      end
    rescue
      puts "\t\tInvalid Date"
    end
  end

  def remove_event
    puts "\n\t\t****Remove Event****"

    input = take_input

    begin
      date = Date.new(input[0], input[1], input[2])
      date = date.to_s.to_sym

      if @hash.key? date
        print "\t\t\t\t Events on #{date}\n"
        puts "\t\tIndex \t\t Event Name \t Event Desc"

        @hash[date].each_with_index do |event, idx|
          print "\t\t#{idx + 1}\t\t"
          event.show
        end

        print "\n\t\tEnter index to remove : "
        input = gets.chomp.to_i

        if input > 0 && @hash[date].include?(@hash[date][input - 1])
          @hash[date].delete_at(input - 1)
          puts "\n\t\tEvent Deleted Successfully......\n"

          @hash.delete(date) if @hash[date].empty?

        else
          puts "\n\t\tInvalid index\n"
        end

      else
        puts "\n\t\tNo Event for this date......\n"
      end
    rescue
      puts "\t\tInvalid Date"
    end
  end

  def add_new_event
    puts "\n\t\t****Add New Event****"

    input = take_input

    begin
      date = Date.new(input[0], input[1], input[2])
      date = date.to_s.to_sym
      @hash[date] = [] unless (@hash.key? date)

      print "\t\t Enter event name : "
      name_of_event = gets.chomp

      print "\t\t Enter event desc : "
      desc_of_event = gets.chomp

      event = Event.new(name_of_event, desc_of_event)

      @hash[date] << event

      puts "\n\n\t\tEvent Added Successfully\n\n"
    rescue
      puts "\t\tInvalid Date"
    end
  end

  def view_specific_event
    puts "\n\t\t****Specific Event****"

    input = take_input

    begin
      date = Date.new(input[0], input[1], input[2])
      date = date.to_s.to_sym

      if @hash.key? date
        puts "\t\tDate \t\t Event Name \t Event Desc"
        print "\t\t #{date}\n"
        @hash[date].each do |event|
          print "\t\t\t\t"
          event.show
        end
      else
        puts "\n\t\tNo Event for this date......\n"
      end
    rescue
      puts "\t\tInvalid Date"
    end
  end

  def get_day(date)
    day = date.wday
    day += 7 if day == 0
    day
  end

  def print_month_view
    puts "\n\t\t****Specific Month Events (Month View Style) ****"
    print "\t\t Enter Month(1..12) : "
    month = gets.to_i

    print "\t\t Enter Year : "
    year = gets.to_i

    if !(1..12).include?(month)
      puts "\t\tInvalid Date"
      return
    end

    all_month_dates = []

    (1..31).each do |x|
      begin
        date = Date.new(year.to_i, month.to_i, x)
      rescue
        date = nil
      end
      all_month_dates << date.to_s.to_sym unless date.to_s.eql? ''
    end

    count = get_day(Date.new(year, month, 1))
    count -= 1
    puts "\n\t\t\t Month View"
    puts "M\tT\tW\tT\tF\tS\tS"
    (0...count).each do
      print "\t"
    end

    (1...32).each do |x|
      begin
        Date.new(year, month, x)
      rescue
        next
      end
      if count == 7
        print "\n"
        count = 0
      end

      if @hash.key? all_month_dates[x - 1]
        print "#{x}(#{@hash[all_month_dates[x - 1]].count})    "
      else
        print "#{x}\t"
      end
      count += 1
    end
  end

  def view_specific_month_event
    puts "\n\t\t****Specific Month Events****"
    print "\t\t Enter Month(1..12) : "
    month = gets.to_i

    print "\t\t Enter Year : "
    year = gets.to_i

    if !(1..12).include?(month)
      puts "\t\tInvalid Date"
      return
    end

    all_month_dates = []
    (1..31).each do |x|
      begin
        date = Date.new(year.to_i, month.to_i, x)
      rescue
        date = nil
      end
      all_month_dates << date.to_s.to_sym unless date.to_s.eql? ''
    end

    puts "\t\tDate \t\t Event Name \t Event Desc"
    all_month_dates.each do |month_date|
      if @hash.key? month_date
        print "\t\t #{month_date}\n"
        @hash[month_date].each do |event|
          print "\t\t\t\t"
          event.show
        end
      end
    end
  end

  def evaluate
    case @choice.to_i
    when 1
      add_new_event
    when 2
      remove_event
    when 3
      edit_event
    when 4
      print_month_view
    when 5
      view_specific_event
    when 6
      view_specific_month_event
    end
  end
end
