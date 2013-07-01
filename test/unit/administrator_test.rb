require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
	test 'username validations' do
		admin1 = Administrator.create(username: administrators(:one).username, 
									  fullname: "a",
									  password: 'b',
									  password_confirmation: 'b')
		assert(!admin1.valid?, "admin1 w/o unique username is invalid")
		admin2 = Administrator.create(username: administrators(:one).username+"B", 
									  fullname: "a",
									  password: 'b',
									  password_confirmation: 'b')
		assert(admin2.valid?, "admin2 w/ unique username is valid")
		
		admin3 = Administrator.create(fullname: "a",
									  password: 'b',
									  password_confirmation: 'b')
		assert(!admin3.valid?, "admin2 w/o username is invalid")
	end
	
	test 'fullname validations' do
		admin2 = Administrator.create(username: administrators(:one).username+"C", 
									  password: 'b',
									  password_confirmation: 'b')
		assert(!admin2.valid?, "admin2 w/o fullname is invalid")
	end
	
	test 'password validations' do
		admin2 = Administrator.create(username: administrators(:one).username+"D",
									  fullname: 'a',
									  password: 'b',
									  password_confirmation: 'a')
		assert(!admin2.valid?, "admin2 w/o matching password_confirmation is invalid")
		
		admin2 = Administrator.create(username: administrators(:one).username+"D", 
								      fullname: 'a',
									  password: 'b')
		assert(!admin2.valid?, "admin2 w/o password_confirmation is invalid")
	end
	
	test 'report_entries' do
		@administrator = Administrator.find( administrators(:one).id )
		assert(@administrator.report_entries.count != 0, "admin :one has non-zero report_entries")
		assert(@administrator.report_entry_comments.count != 0, "admin :one has non-zero report_entry_comments")
	end
end
