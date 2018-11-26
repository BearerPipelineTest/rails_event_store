require 'spec_helper'

module RubyEventStore
  RSpec.describe TransformKeys do
    include RubyEventStore::TransformKeys

    let(:hash_with_symbols) { {
      one: 1,
      two: 2.0,
      three: true,
      four: Date.new(2018, 4, 17),
      five: "five",
      six: Time.utc(2018, 12, 13, 11 ),
      seven: true,
      eight: false,
      nein: nil,
      ten: {some: 'hash', with: {nested: 'values'}},
      eleven: [1,{another: 'hash', here: 2},3],
    } }
    let(:hash_with_strings) { {
      'one' => 1,
      'two' => 2.0,
      'three' => true,
      'four' => Date.new(2018, 4, 17),
      'five' => "five",
      'six' => Time.utc(2018, 12, 13, 11 ),
      'seven' => true,
      'eight' => false,
      'nein' => nil,
      'ten' => {'some' => 'hash', 'with' => {'nested' => 'values'}},
      'eleven' => [1,{'another' => 'hash', 'here' => 2},3],
    } }

    it { expect(stringify_keys(hash_with_symbols)).to eq(hash_with_strings) }
    it { expect(stringify_keys(hash_with_strings)).to eq(hash_with_strings) }

    it { expect(symbolize_keys(hash_with_strings)).to eq(hash_with_symbols) }
    it { expect(symbolize_keys(hash_with_symbols)).to eq(hash_with_symbols) }
  end
end
