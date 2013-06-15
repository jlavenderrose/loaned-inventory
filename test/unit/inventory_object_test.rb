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
  
  test 'id1 unique' do
    object = InventoryObject.create(id1: "DELLN02")
    object2 = InventoryObject.create(id1: "DELLN02")
    assert(!object2.valid?)
  end
  
  test 'id2 unique' do
    object = InventoryObject.create(id2: "DELLN02")
    object2 = InventoryObject.create(id2: "DELLN02")
    assert(!object2.valid?)
  end
  
  test 'id3 unique' do
    object = InventoryObject.create(id3: "DELLN02")
    object2 = InventoryObject.create(id3: "DELLN02")
    assert(!object2.valid?)
  end
  
  test 'search single' do
    assert(!InventoryObject.new.search("DELLN01").respond_to?("count"))
  end
  
  test 'search multiple' do
    assert(!InventoryObject.new.search("DELLN").respond_to?("count"))
  end
end
