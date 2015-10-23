Company.destroy_all

#### COMPANIES ####
company = Company.create(
  name: 'My Company'
)

#### USERS ####
guillaume = User.create(
  name: 'Guillaume (YOLO)',
  company: company
)

jane = User.create(
  name: 'Jane (CEO)',
  company: company
)

peter = User.create(
  name: 'Peter (CTO)',
  company: company
)

luke = User.create(
  name: 'Luke (COO)',
  company: company
)

#### PHONE NUMBERS ####

## Companies
company.phone_numbers.create(name: 'Main Office', sip_endpoint: 'Office151023164246')
company.phone_numbers.create(name: 'Sales',       sip_endpoint: 'Sales151023164212')
company.phone_numbers.create(name: 'Support',     sip_endpoint: 'Support151023164303')

## Users
jane.phone_numbers.create(name: 'Jane', sip_endpoint: 'Jane151023163619')
peter.phone_numbers.create(name: 'Peter', sip_endpoint: 'Peter151023163804')
luke.phone_numbers.create(name: 'Luke', sip_endpoint: 'Luke151023163814')
guillaume.phone_numbers.create(name: 'Guillaume', sip_endpoint: 'Guillaume151023163828')
