health_funds = [
  'Bupa',
  'ACA',
  'AHM',
  'ARHG',
  'Australian Unity',
  'CBHS',
  'CDH',
  'CUA',
  'Defence Health',
  'Frank Health Insurance',
  'GMHBA',
  'HBF',
  'HCF',
  'Health Care Insurance',
  'Health Insurance Fund of Australia',
  'Health Partners',
  'Latrobe Health',
  'Medibank Private',
  'Mildura Health Fund',
  'Navy Health',
  'NIB',
  'Peoplecare',
  'Phoenix Health Fund',
  'Police Health',
  'Queensland Country Health Fund',
  'Railway and Transport Health Fund',
  'Reserve Bank Health Society',
  'St.Lukes Health',
  'Teachers Health',
  'Transport Health',
  'Westfund Limited'
]

health_funds.each do |name|
  HealthFund.find_or_create_by(name: name)
end