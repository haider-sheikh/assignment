require_relative 'event'

class Calender
  attr_reader :hash
  def initialize
    @hash = {}
  end

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

      print "\n\t\t Wrong Input \n" unless (1..7).include? @choice.to_i

      evaluate
    end
  end

  def take_input
    print "\t\t Enter Month(1..12) : "
    month = gets.to_i

    print "\t\t Enter Day(1..31) : "
    day = gets.to_i

    print "\t\t Enter Year : "
    year = gets.to_i

    [year, month, day]
  end

  def edit_event input
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

        if input.positive? && @hash[date].include?(@hash[date][input - 1])

          event = @hash[date][input - 1]

          puts "\t\t Old event name : #{event.name}"

          puts "\t\t Old event desc : #{event.desc}\n"

          print "\t\t Enter New event name : "
          name_of_event = gets.chomp

          print "\t\t Enter New event desc : "
          desc_of_event = gets.chomp

          event.name = name_of_event
          event.desc = desc_of_event

          puts "\n\t\t Event Updated Successfully......\n"

        else
          puts "\n\t\tInvalid index\n"
        end
      else
        puts "\n\t\tNo Event for this date......\n"
      end
    rescue Date::Error
      puts "\t\tInvalid Date"
    end
  end

  def remove_event input

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

        if input.positive? && @hash[date].include?(@hash[date][input - 1])
          @hash[date].delete_at(input - 1)
          puts "\n\t\tEvent Deleted Successfully......\n"

          @hash.delete(date) if @hash[date].empty?

        else
          puts "\n\t\tInvalid index\n"
        end

      else
        puts "\n\t\tNo Event for this date......\n"
      end
    rescue Date::Error
      puts "\t\tInvalid Date"
      "\t\tInvalid Date" # returning value for unit test cases
    end
  end

  def add_new_event input    
    begin
        date = Date.new(input[0], input[1], input[2])
        date = date.to_s.to_sym
        @hash[date] = [] unless @hash.key? date

        name_of_event = input[3]

        desc_of_event = input[4]

        event = Event.new(name_of_event, desc_of_event)

        @hash[date] << event

        puts "\n\n\t\tEvent Added Successfully\n\n"
        "\n\n\t\tEvent Added Successfully\n\n"
      rescue Date::Error
        puts "\t\tInvalid Date"
        "\t\tInvalid Date"
      end
  end

  def view_specific_event input

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
        "\n\t\tNo Event for this date......\n"# returning value for unit test cases
      end
    rescue Date::Error
      puts "\t\tInvalid Date"
      "\t\tInvalid Date" # returning value for unit test cases
    end
  end

  def get_day(date)
    day = date.wday
    day += 7 if day.zero?
    day
  end

  def print_month_view
    
    print "\t\t Enter Month(1..12) : "
    month = gets.to_i

    print "\t\t Enter Year : "
    year = gets.to_i

    unless (1..12).include?(month)
      puts "\n\t\tInvalid Date"
      return
    end

    all_month_dates = []

    (1..31).each do |x|
      begin
        date = Date.new(year.to_i, month.to_i, x)
      rescue Date::Error
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
      rescue Date::Error
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

    print "\t\t Enter Month(1..12) : "
    month = gets.to_i

    print "\t\t Enter Year : "
    year = gets.to_i

    unless (1..12).include?(month)
      puts "\t\tInvalid Date"
      return
    end

    all_month_dates = []
    (1..31).each do |x|
      begin
        date = Date.new(year.to_i, month.to_i, x)
      rescue Date::Error
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
      puts "\n\t\t****Add New Event****"
      input = take_input

      print "\t\t Enter event name : "
      name_of_event = gets.chomp

      print "\t\t Enter event desc : "
      desc_of_event = gets.chomp

      input << name_of_event << desc_of_event
      add_new_event input
    when 2
      puts "\n\t\t****Remove Event****"
      remove_event take_input
    when 3
      puts "\n\t\t****Edit Event****"
      edit_event take_input
    when 4
      puts "\n\t\t****Specific Month Events (Month View Style) ****"
      print_month_view
    when 5
      puts "\n\t\t****Specific Event****"
      view_specific_event take_input
    when 6
      puts "\n\t\t****Specific Month Events****"
      view_specific_month_event
    end
  end
end