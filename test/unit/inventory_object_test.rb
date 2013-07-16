require 'test_helper'

class InventoryObjectTest < ActiveSupport::TestCase
  test 'needs version' do
    object = InventoryObject.create(id1: "DELLN03")
    assert(!object.valid?)
  end
  
  test 'needs id1' do
    object = InventoryObject.create()
    assert(!object.valid?)
  end
  
  #TODO, fix these, object is not valid either
  test 'id1 unique' do
    object = InventoryObject.create(id1: inventory_objects(:one).id1,
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id)
    assert(!object.valid?, "object w/o unique id2 not valid")
    object2 = InventoryObject.create(id1: inventory_objects(:one).id1+"D",
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id)
    assert(object2.valid?, "object2 w/ unique id1 not valid")
  end
  
  test 'id2 unique' do
	object = InventoryObject.create(id1: inventory_objects(:one).id1+"B",
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id,
									id2: inventory_objects(:one).id2)
    assert(!object.valid?, "object w/o unique id2 not valid")
    object2 = InventoryObject.create(id1: inventory_objects(:one).id1+"B",
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id,
									id2: inventory_objects(:one).id2+"B")
    assert(object2.valid?, "object2 w/ unique id2 not valid")
  end
  
  test 'id3 unique' do
    object = InventoryObject.create(id1: inventory_objects(:one).id1+"C",
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id,
									id3: inventory_objects(:one).id3)
    assert(!object.valid?, "object w/o unique id3 not valid")
    object2 = InventoryObject.create(id1: inventory_objects(:one).id1+"C",
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id,
									id3: inventory_objects(:one).id3+"C")
    assert(object2.valid?, "object2 w/ unique id3 not valid")
  end
  
  test 'inventory loans' do
	@inventory_object = InventoryObject.find(inventory_objects(:one))
	assert(@inventory_object.inventory_loans.count != 0, "inventory_object :one has non-zero inventory loans")
	assert(@inventory_object.loanees.count != 0, "inventory_object :one has non-zero loanees")
  end
  
  test 'report entries' do
	@inventory_object = InventoryObject.find(inventory_objects(:one))
	assert(@inventory_object.report_entries.count != 0, "inventory_object :one has non-zero report entries")
	assert(@inventory_object.report_entries.open?, "inventory_object :one has open report_entries")
  end
  
  test 'report entries open?' do
	@inventory_object = InventoryObject.create(id1: inventory_objects(:one).id1+"F",
									inventory_object_version_id: inventory_objects(:one).inventory_object_version.id)
	assert(!@inventory_object.report_entries.open?, "new inventory_object has no open report_entries")
  end
  
  test 'inventory object search' do
	res = InventoryObject.search(inventory_objects(:one).id1)
	assert(res.present?, "InventoryObject.search returns present result")
  end
  
  test 'creates audit_log_entry on create' do
	#set Administrator.current
	Administrator.current = administrators(:one)
	inventory_object = InventoryObject.new
	
	assert_difference('inventory_object.audit_log_entries.count') do
		inventory_object.id1 = inventory_objects(:one).id1+"F"
		inventory_object.inventory_object_version_id = inventory_objects(:one).inventory_object_version.id
		inventory_object.save
	end
  end
  
  test 'creates audit_log_entry on status_tag_list update' do
	#set Administrator.current
	Administrator.current = administrators(:one)
	inventory_object = InventoryObject.find(inventory_objects(:one).id)
	
	assert_difference('inventory_object.audit_log_entries.count') do
		inventory_object.status_tag_list = "a, b"
		inventory_object.save 
	end
	
	assert_includes(inventory_object.audit_log_entries.last.message, "added: a", "Incorrect message for status_tag_list add")
	refute_includes(inventory_object.audit_log_entries.last.message, "removed: a")
	
	assert_difference('inventory_object.audit_log_entries.count') do
		inventory_object.status_tag_list = "b"
		inventory_object.save
	end
	
	assert_includes(inventory_object.audit_log_entries.last.message, "removed: a", "Incorrect message for status_tag_list remove")
	refute_includes(inventory_object.audit_log_entries.last.message, "added: b")
  end
end
