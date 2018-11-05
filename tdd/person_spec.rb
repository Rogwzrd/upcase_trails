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
  def initialize(first_name:, middle_name: nil, last_name:, pineapples_already_in_butt: 0)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
    @rectal_pineapple_count = pineapples_already_in_butt
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
  
  def put_pineapples_in_butt(num_pineapples_to_insert_in_butt)
    @rectal_pineapple_count += num_pineapples_to_insert_in_butt
  end

  def number_of_pineapples_in_butt
    puts @rectal_pineapple_count
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
  
  describe "#put_pineapples_in_butt" do
    it 'inserts the specified number of pineapples into the instance\'s butt' do
      person = Person.new(first_name: "Huey", last_name: "Lewis", pineapples_already_in_butt: 12)
      person.put_pineapples_in_butt(42)
      
      expect(person.number_of_pineapples_in_butt).to eq 54
    end
  end
end
