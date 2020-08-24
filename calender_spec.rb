require 'calender'
require 'date'

describe Calender do
  it 'should return the 4 when called to get_day method with 1998-7-9 date' do
    day = Calender.new.get_day(Date.new(1998,7,9))
    expect(day).to be 4
  end

  it 'Should display Invalid Date error' do
    expect(Calender.new.add_new_event [2020,14,23,'Corona','Description of corona']).to eq "\t\tInvalid Date"
  end

  it 'Should add event successfully' do
    expect(Calender.new.add_new_event [2020,11,23,'Corona','Description of corona']).to eq "\n\n\t\tEvent Added Successfully\n\n"
  end

  it 'Should display Invalid Date when called to remove_event method' do
    expect(Calender.new.remove_event [2020,14,23]).to eq "\t\tInvalid Date"
  end

  it 'Should display Invalid Date when called to view_specific_event method' do
    expect(Calender.new.view_specific_event [2020,14,23]).to eq "\t\tInvalid Date"
  end

  it 'Should display No Event to show when called to view_specific_event method' do
    expect(Calender.new.view_specific_event [2020, 1, 23]).to eq "\n\t\tNo Event for this date......\n"
  end
end
