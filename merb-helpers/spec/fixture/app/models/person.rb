class Person
  include DataMapper::Resource

  property :id, Integer, :serial => true

  property :first_name, String
  property :last_name,  String
  property :age,        Integer
end
