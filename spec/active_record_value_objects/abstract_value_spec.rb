# frozen_string_literal: true

require 'rspec'

RSpec.describe ActiveRecordValueObjects::AbstractValue do
  let(:valid_value) do
    TestValue.new(
      string: 'string',
      integer: 1,
      boolean: true,
      array_boolean: [true, false]
    )
  end

  let(:nested_value) do
    NestedTestValue.new(
      string: 'string',
      nested: {
        string: 'nested string'
      }
    )
  end

  let(:invalid_value) do
    TestValue.new
  end

  class TestValue < ActiveRecordValueObjects::AbstractValue
    attribute :string, Types::String
    attribute :integer, Types::Integer
    attribute :boolean, Types::Bool
    attribute :optional_boolean, Types::Bool.optional
    attribute :array_boolean, Types::Array.of(Types::Bool)
  end

  class NestedTestValue < ActiveRecordValueObjects::AbstractValue
    attribute :string, Types::String
    attribute :nested do
      attribute :string, Types::String
    end
  end

  it 'can be constructed with a hash with all required fields' do
    expect(valid_value.string).to eq('string')
    expect(valid_value.integer).to eq(1)
    expect(valid_value.optional_boolean).to eq(nil)
    expect(valid_value.boolean).to eq(true)
    expect(valid_value.array_boolean).to eq([true, false])
  end

  it 'throws an exception if the a required field is missing' do
    expect { invalid_value }.to raise_error(Dry::Struct::Error)
  end

  it 'casts itself as a table' do
    expect(valid_value.to_table.to_s).to eq(
                                           Terminal::Table.new(headings: [:attribute, :value]) do |t|
                                             t << [:string, 'string']
                                             t << [:integer, 1]
                                             t << [:boolean, true]
                                             t << [:array_boolean, [true, false]]
                                             t << [:optional_boolean, nil]
                                           end.to_s
                                         )
  end

  it 'can be copied with new attributes' do
    new_value = valid_value.copy_with(string: 'new string')
    expect(new_value.string).to eq('new string')
  end

  it 'can be compared to another value object' do
    other_value = valid_value.copy_with
    expect(valid_value.is_equal?(other_value)).to eq(true)
    other_value = valid_value.copy_with(string: 'new string')
    expect(valid_value.is_equal?(other_value)).to eq(false)
  end

  it 'allows to dig into nested attributes' do
    expect(nested_value.dig(:string)).to eq('string')
    expect(nested_value.dig(:nested, :string)).to eq('nested string')
  end
end
