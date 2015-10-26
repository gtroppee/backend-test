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
  sip_endpoint: 'sip:Office151023164246@phone.plivo.com', 
  users: [jane, peter, luke], 
  companies: [company],
  type: 'CompanyPhoneNumber'
)

sales_number = PhoneNumber.create(
  name: 'Sales',       
  sip_endpoint: 'sip:Sales151023164212@phone.plivo.com', 
  users: [jane, luke], 
  companies: [company],
  type: 'CompanyPhoneNumber'
)

support_number = PhoneNumber.create(
  name: 'Support',     
  sip_endpoint: 'sip:Support151023164303@phone.plivo.com', 
  users: [peter, luke],
  companies: [company],
  type: 'CompanyPhoneNumber'
)

## Users
jane_mobile = PhoneNumber.create(
  name: "Jane's Mobile", 
  sip_endpoint: 'sip:Jane151023163619@phone.plivo.com',
  users: [jane],
  type: 'UserPhoneNumber'
)

jane_desktop = PhoneNumber.create(
  name: "Jane's Desktop", 
  sip_endpoint: 'sip:Jane151026131115@phone.plivo.com',
  users: [jane],
  type: 'UserPhoneNumber'
)

peter_mobile = PhoneNumber.create(
  name: "Peter's Mobile", 
  sip_endpoint: 'sip:Peter151023163804@phone.plivo.com',
  users: [peter],
  type: 'UserPhoneNumber'
)

peter_desktop = PhoneNumber.create(
  name: "Peter's Desktop", 
  sip_endpoint: 'sip:Peter151026131214@phone.plivo.com',
  users: [peter],
  type: 'UserPhoneNumber'
)

luke_mobile = PhoneNumber.create(
  name: "Luke's Mobile", 
  sip_endpoint: 'sip:Luke151023163814@phone.plivo.com',
  users: [luke],
  type: 'UserPhoneNumber'
)

luke_desktop = PhoneNumber.create(
  name: "Luke's Desktop", 
  sip_endpoint: 'sip:Luke151026131144@phone.plivo.com',
  users: [luke],
  type: 'UserPhoneNumber'
)

# puts PhoneNumberAssignment.all.map(&:priority).inspect
