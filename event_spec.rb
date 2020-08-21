require 'event'

describe Event do
  it 'should return the nil when called to show method' do
    event = Event.new('NewEvent', 'Some Description')
    expect(event.show).to be nil
  end

  it 'Should raise Argument Error' do
    expect { Event.new }.to raise_error(ArgumentError)
  end

  it 'Should raise Argument Error' do
    expect { Event.new('Corona') }.to raise_error(ArgumentError)
  end
end
