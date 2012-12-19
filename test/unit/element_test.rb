require 'unit_helper'

module AePageObjects
  class ElementTest < ActiveSupport::TestCase
  
    def test_new
      pet_class   = ::AePageObjects::Document.new_subclass
      kitty_class = ::AePageObjects::Element.new_subclass
      
      document_stub = mock
      pet           = pet_class.new(document_stub)
      
      kitty_page_object = mock
      document_stub.expects(:find).with("#tiger").returns(kitty_page_object)
      kitty = kitty_class.new(pet, :tiger)
      
      assert_equal pet, kitty.parent
      assert_equal kitty_page_object, kitty.node
      assert_equal "tiger", kitty.full_name
      assert_equal "tiger", kitty.name
      assert kitty.using_default_locator?
    end
    
    def test_new__using
      pet_class   = ::AePageObjects::Document.new_subclass
      kitty_class = ::AePageObjects::Element.new_subclass
      
      document_stub = mock
      pet           = pet_class.new(document_stub)
      
      kitty_page_object = mock
      document_stub.expects(:find).with("#jonka").returns(kitty_page_object)
      kitty = kitty_class.new(pet, :tiger, :name => "jonka")
      
      assert_equal pet, kitty.parent
      assert_equal kitty_page_object, kitty.node
      assert_equal "jonka", kitty.full_name
      assert_equal "jonka", kitty.name
      assert kitty.using_default_locator?
    end
    
    def test_new__locator
      pet_class   = ::AePageObjects::Document.new_subclass
      kitty_class = ::AePageObjects::Element.new_subclass
      
      document_stub = mock
      pet           = pet_class.new(document_stub)
      
      kitty_page_object = mock
      document_stub.expects(:find).with("J 2da K").returns(kitty_page_object)
      kitty = kitty_class.new(pet, :tiger, :locator => "J 2da K")
      
      assert_equal pet, kitty.parent
      assert_equal kitty_page_object, kitty.node
      assert_equal "tiger", kitty.full_name
      assert_equal "tiger", kitty.name
      assert_false kitty.using_default_locator?
    end
    
    def test_document
      kitty_page_class = ::AePageObjects::Document.new_subclass
      kitty_class      = ::AePageObjects::Element.new_subclass
      
      document_stub = stub
      kitty_page    = kitty_page_class.new(document_stub)
      assert_equal kitty_page, kitty_page.document
      
      document_stub.stubs(:find).returns(document_stub)
      
      kitty1 = kitty_class.new(kitty_page, :tiger)
      kitty2 = kitty_class.new(kitty1,     :tiger)
      kitty3 = kitty_class.new(kitty2,     :tiger)
      
      assert_equal kitty_page, kitty1.parent
      assert_equal kitty1, kitty2.parent
      assert_equal kitty2, kitty3.parent

      assert_equal kitty_page, kitty1.document
      assert_equal kitty_page, kitty2.document
      assert_equal kitty_page, kitty3.document
    rescue => e
      puts e.backtrace.join("\n")
      raise e
    end
  end
end