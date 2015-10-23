#### COMPANIES ####
company = Company.create(
  name: 'My Company'
)

#### USERS ####
['Jane (CEO)', 'Peter (CTO)', 'Luke (COO)', 'Guillaume (YOLO)'].each do |name|
  Company.create(
    name: name,
    company: company
  )
end

#### PHONE NUMBERS ####

## Companies
PhoneNumber.create(
  name: company.name,
  callable_type: 'Company',
  callable_id: company.id
)

## Users
User.all.each do |user|
  PhoneNumber.create(
    name: "#{user} (#{user.phone_numbers.count})",
    callable_type: 'User',
    callable_id: user.id
  )
end
