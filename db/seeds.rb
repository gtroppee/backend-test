Company.destroy_all

#### COMPANIES ####
company = Company.create(
  name: 'My Company'
)

#### USERS ####
['Jane (CEO)', 'Peter (CTO)', 'Luke (COO)', 'Guillaume (YOLO)'].each do |name|
  User.create(
    name: name,
    company: company
  )
end

#### PHONE NUMBERS ####

## Companies
['Sales', 'Main Office', 'Support'].each do |name|
  PhoneNumber.create(
    name: name,
    callable_type: 'Company',
    callable_id: company.id
  )
end

## Users
User.all.each do |user|
  PhoneNumber.create(
    name: "#{user} (#{user.phone_numbers.count})",
    callable_type: 'User',
    callable_id: user.id
  )
end
