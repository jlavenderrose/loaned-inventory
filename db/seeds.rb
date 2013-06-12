# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admins = Administrator.create(fullname: 'Julian R. Moore', username: 'jmoore', password: 'admin', password_confirmation: 'admin')

computers = InventoryObjectType.create(name: 'Laptops')
dells = computers.versions.create(name: 'Dell Latitude 2120')
mydell = dells.objects.create(id1: 'DELLN47', id2: 'JVTPFT1')

books = InventoryObjectType.create(name: 'Textbooks')
books.versions.create(name: 'Some Awful Textbook')

julian = Loanee.create(fullname: 'Julian R. Moore', idnum: '10082')
mydell.inventory_loans.create(loanee: julian) 
