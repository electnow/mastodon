# frozen_string_literal: true

# TABLES TO POPULATE
# - states
# - electorates
# - parties
# - leader profiles
# - electorate search mappings
# - electorate census data

# STATES
states = YAML.load_file(Rails.root.join('config', 'electnow_seed_data', 'states.yml'))

db_states = states.map do |_, state|
  Geography::State.create_with(name: state['name'], code: state['code']).find_or_create_by(name: state['name'])
end

# ELECTORATES
electorates = YAML.load_file(Rails.root.join('config', 'electnow_seed_data', 'electorates.yml'))

db_electorates = electorates.map do |_, electorate|
  select_state = db_states.detect { |state| state.code == electorate['state'] }
  Geography::Electorate.create_with(name: electorate['name'], geography_state_id: select_state.id).find_or_create_by(name: electorate['name'])
end

# Parties
parties = YAML.load_file(Rails.root.join('config', 'electnow_seed_data', 'parties.yml'))

db_parties = parties.map  do |_, party|
  Party.create_with(name: party['name']).find_or_create_by(name: party['name'])
end

# Leader profiles
leaders = YAML.load_file(Rails.root.join('config', 'electnow_seed_data', 'leaders.yml'))

def parliament_id(parliamant)
  if parliamant == 'Federal'
    :federal
  elsif parliamant == 'State'
    :state
  end
end

def type_id(type)
  # rubocop:disable Style/HashLikeCase
  case type
  when 'HOA'
    :house_of_assembly
  when 'SEN'
    :senate
  when 'HOR'
    :house_of_representative
  end
  # rubocop:enable Style/HashLikeCase
end

def level_id(level)
  if level == 'Lower'
    :lower
  elsif level == 'Upper'
    :upper
  end
end

leaders.map do |_, leader|
  party_obj = db_parties.detect { |party| party.name == leader['party'] }
  select_state = db_states.detect { |state| state.code == leader['state'] }
  select_electorate = db_electorates.detect { |electorate| electorate.name == leader['electorate'] }

  # enums
  parliment = parliament_id(leader['parliment'])
  type = type_id(leader['type'])
  level = level_id(leader['level'])

  LeaderProfile.create_with(name: leader['name'], type_of_leader: type, level: level, parliament: parliment, geography_state_id: select_state.id, geography_electorate_id: select_electorate ? select_electorate.id : nil, party_id: party_obj ? party_obj.id : nil,
                            account_id: nil).find_or_create_by(name: leader['name'])
end

# Electorate mappings
electorate_mappings = YAML.load_file(Rails.root.join('config', 'electnow_seed_data', 'electorate_mappings.yml'))

electorate_mappings.map do |_, electorate_mapping|
  select_electorate = db_electorates.detect { |electorate| electorate.name == electorate_mapping['electorate'] }
  select_state = db_states.detect { |state| state.code == electorate_mapping['state'] }

  ElectorateMapping.create_with(geography_states_id: select_state.id, geography_electorates_id: select_electorate.id, postal_code: electorate_mapping['postcode'], suburb: electorate_mapping['suburb'])
                   .find_or_create_by(geography_states_id: select_state.id, geography_electorates_id: select_electorate.id, postal_code: electorate_mapping['postcode'], suburb: electorate_mapping['suburb'])
end

# Electorate census
electorate_census = YAML.load_file(Rails.root.join('config', 'electnow_seed_data', 'electorate_census.yml'))

electorate_census.map do |_, electorate_census_data|
  select_electorate = db_electorates.detect { |electorate| electorate.name == electorate_census_data['electorate'] }
  ElectorateCensusData.create_with(
    geography_electorates_id: select_electorate.id,
    population: electorate_census_data['population'],
    average_age: electorate_census_data['age'],
    employment: electorate_census_data['employment'],
    most_common_occupation: electorate_census_data['occupation'],
    most_common_education: electorate_census_data['highest year of school completed'],
    most_common_employment: electorate_census_data['industry of Employment'],
    most_common_religion: electorate_census_data['religion'],
    most_common_birth_country: electorate_census_data['country of Birth'],
    most_common_birth_country_parents: electorate_census_data['country of birth of parents'],
    total_family_income: electorate_census_data['total family Income'],
    mortgage_repayment: electorate_census_data['mortgage Repayments'],
    rent_range: electorate_census_data['rent ranges'],
    language_proficiency: electorate_census_data['proficiency in Spoken English']
  ).find_or_create_by(geography_electorates_id: select_electorate.id)
end
