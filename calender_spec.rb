require 'calender'
require 'date'

describe Calender do
  it 'should return the 4 when called to get_day method with 1998-7-9 date' do
    day = Calender.new.get_day(Date.new(1998,7,9))
    expect(day).to be 4
  end

  it 'Should raise Date::Error when called to add_new_event method' do
    cal = Calender.new
    expect { cal.add_new_event [2020,14,23]}.to raise_error(Date::Error)
  end

  # it 'Should raise Argument Error' do
  #   expect { Event.new('Corona') }.to raise_error(ArgumentError)
  # end
end
