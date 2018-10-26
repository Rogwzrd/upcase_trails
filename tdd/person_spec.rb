# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  # this class represents a person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  # implement your behavior here
  def full_name
    name_array.compact.join(' ')
  end

  def full_name_with_middle_initial
    name_array.map do |name| 
      name = initialize_name(name) if name == @middle_name 
      name
    end.compact.join(' ')
  end

  def initials
    name_array.map do |name| 
      initialize_name(name)
    end.join('')
  end

  private

  def name_array
    [@first_name, @middle_name, @last_name]
  end

  def initialize_name(name)
    name[0].upcase << '.' 
  end
end

RSpec.describe Person do
  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces"do
      person = Person.new(first_name: 'John', middle_name: 'Mark', last_name: 'Smith')

      expect(person.full_name).to eq 'John Mark Smith'
    end
    it "does not add extra spaces if middle name is missing" do
      person = Person.new(first_name: 'John', last_name: 'Smith')

      expect(person.full_name).to eq 'John Smith'

    end
  end

  describe "#full_name_with_middle_initial" do
    it 'concatenates the first name, middle initial, an dlast name with spaces' do
      person = Person.new(first_name: 'John', middle_name: 'Mark', last_name: 'Smith')

      expect(person.full_name_with_middle_initial).to eq 'John M. Smith'
    end
  end
  
  describe "#initials" do
    it 'concatenates the first, middle and last initial with spaces' do
      person = Person.new(first_name: 'John', middle_name: 'Mark', last_name: 'Smith')

      expect(person.initials).to eq 'J.M.S.'
    end
  end
end