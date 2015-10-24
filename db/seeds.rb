Company.destroy_all

#### COMPANIES ####
company = Company.create(
  name: 'My Company'
)

#### USERS ####
jane = User.create(
  name: 'Jane',
  company: company
)

peter = User.create(
  name: 'Peter',
  company: company
)

luke = User.create(
  name: 'Luke',
  company: company
)

#### PHONE NUMBERS ####

## Companies
main_number = PhoneNumber.create(
  name: 'Main Office', 
  sip_endpoint: 'Office151023164246', 
  users: [jane, peter, luke], 
  companies: [company]
)

sales_number = PhoneNumber.create(
  name: 'Sales',       
  sip_endpoint: 'Sales151023164212', 
  users: [jane, luke], 
  companies: [company]
)

support_number = PhoneNumber.create(
  name: 'Support',     
  sip_endpoint: 'Support151023164303', 
  users: [peter, luke], 
  companies: [company]
)

## Users
jane_number = PhoneNumber.create(
  name: 'Jane', 
  sip_endpoint: 'Jane151023163619',
  users: [jane]
)

peter_number = PhoneNumber.create(
  name: 'Peter', 
  sip_endpoint: 'Peter151023163804',
  users: [peter]
)

luke_number = PhoneNumber.create(
  name: 'Luke', 
  sip_endpoint: 'Luke151023163814',
  users: [luke]
)

puts PhoneNumberAssignment.all.map(&:priority).inspect

#### PHONE NUMBER ASSIGNMENTS ####

## Companies
# main_number.phone_number_assignments.create(
#   sip_endpoint: 'Office151023164246',
#   callables: [jane, peter, luke]
# )

# PhoneNumber.create(name: 'Sales',       sip_endpoint: 'Sales151023164212')
# PhoneNumber.create(name: 'Support',     sip_endpoint: 'Support151023164303')

# ## Users
# PhoneNumber.create(name: 'Jane', sip_endpoint: 'Jane151023163619')
# PhoneNumber.create(name: 'Peter', sip_endpoint: 'Peter151023163804')
# PhoneNumber.create(name: 'Luke', sip_endpoint: 'Luke151023163814')
