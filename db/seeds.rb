# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)
user1 = User.create!(email: 'rudi@afeefa.de', forename: 'Rudi', surname: 'Dutschke', password: 'password1')
user2 = User.create!(email: 'steve@afeefa.de', forename: 'Steve', surname: 'Reinke', password: 'password1')
user3 = User.create!(email: 'joschka@afeefa.de', forename: 'Joschka', surname: 'Heinrich', password: 'password2')
user4 = User.create!(email: 'peter@afeefa.de', forename: 'Peter', surname: 'Hirsch', password: 'password3')
user5 = User.create!(email: 'benny@afeefa.de', forename: 'Benny', surname: 'Thomä', password: 'password4')
user6 = User.create!(email: 'felix@afeefa.de', forename: 'Felix', surname: 'Schönfeld', password: 'password5')
user7 = User.create!(email: 'anna@afeefa.de', forename: 'Anna', surname: 'Neumann', password: 'password1')

orga0 = Orga.new(title: 'Oberoberorga', description: 'Nothing goes above', category: 'welcome_ini')
orga0.save!(validate: false)
orga1 = Orga.create!(title: 'Afeefa', description: 'Eine Beschreibung für Afeefa', category: 'welcome_ini', parent_orga: orga0)
orga2 = Orga.create!(title: 'Dresden für Alle e.V.', description: 'Eine Beschreibung für Dresden für Alle e.V.', category: 'welcome_ini', parent_orga: orga1)
orga3 = Orga.create!(title: 'TU Dresden', description: 'Eine Beschreibung für TU Dresden', category: 'welcome_ini', parent_orga: orga1)
orga4 = Orga.create!(title: 'Ausländerrat', state: 'inactive', category: 'welcome_ini', parent_orga: orga1)
orga5 = Orga.create!(title: 'Frauentreff "Hand in Hand"', state: 'inactive', category: 'welcome_ini', parent_orga: orga1)
Orga.create!(title: 'Integrations- und Ausländerbeauftragte', category: 'welcome_ini', parent_orga: orga1)
Orga.create!(title: 'Übersetzer Deutsch-Englisch-Französisch', state: 'inactive', category: 'welcome_ini', parent_orga: orga1)
Orga.create!(title: 'Interkultureller Frauentreff', category: 'welcome_ini', parent_orga: orga4, state: 'inactive')
Orga.create!(title: 'Außenstelle Adlergasse', category: 'welcome_ini', parent_orga: orga4, state: 'active')


# Role.create!(user: user6, orga: orga1, title: Role::ORGA_ADMIN)
# Role.create!(user: user7, orga: orga1, title: Role::ORGA_ADMIN)
# Role.create!(user: user1, orga: orga1, title: Role::ORGA_MEMBER)
# Role.create!(user: user2, orga: orga1, title: Role::ORGA_MEMBER)
# Role.create!(user: user3, orga: orga1, title: Role::ORGA_MEMBER)
# Role.create!(user: user4, orga: orga1, title: Role::ORGA_MEMBER)
# Role.create!(user: user5, orga: orga1, title: Role::ORGA_MEMBER)
#
# Role.create!(user: user3, orga: orga2, title: Role::ORGA_ADMIN)
# Role.create!(user: user1, orga: orga2, title: Role::ORGA_MEMBER)
#
# Role.create!(user: user4, orga: orga3, title: Role::ORGA_ADMIN)
# Role.create!(user: user1, orga: orga3, title: Role::ORGA_MEMBER)
# Role.create!(user: user3, orga: orga3, title: Role::ORGA_MEMBER)
# Role.create!(user: user5, orga: orga3, title: Role::ORGA_MEMBER)

event1 = Event.create!(title: 'Big Afeefa-Event', state: 'active', category: 'community', creator: user1)
event2 = Event.create!(title: 'Kuefa im AZ-Conni', state: 'active', category: 'community', creator: user1)
event3 = Event.create!(title: 'Playing Football', state: 'active', category: 'community', creator: user1)
event4 = Event.create!(title: 'Cooking for All', state: 'active', category: 'community', creator: user1)
event5 = Event.create!(title: 'Sommerfest', category: 'welcome_ini', parent_id: orga4, state: 'inactive', creator: user1)
event6 = Event.create!(title: 'Deutschkurs', category: 'welcome_ini', parent_id: orga5, state: 'inactive', creator: user1)
event7 = Event.create!(title: 'Kulturtreff', category: 'welcome_ini', parent_id: orga5, state: 'inactive', creator: user1)
event8 = Event.create!(title: 'Offenes Netzwerktreffen Dresden für Alle', category: 'welcome_ini', parent_id: orga2, state: 'inactive', creator: user1)

OwnerThingRelation.create!(ownable: event1, thingable: orga1)
OwnerThingRelation.create!(ownable: event2, thingable: user1)
OwnerThingRelation.create!(ownable: event3, thingable: orga1)
OwnerThingRelation.create!(ownable: event4, thingable: orga1)
OwnerThingRelation.create!(ownable: event5, thingable: orga1)
OwnerThingRelation.create!(ownable: event6, thingable: orga1)
OwnerThingRelation.create!(ownable: event7, thingable: orga2)
OwnerThingRelation.create!(ownable: event8, thingable: orga3)

Annotation.create!(title: 'Übersetzung fehlt', annotateable: orga0)