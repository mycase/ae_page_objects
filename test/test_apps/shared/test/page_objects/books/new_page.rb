module PageObjects
  module Books
    class NewPage < ::AePageObjects::Document
      extend HasBookForm

      path :new_book
      path :books

      has_book_form

      def save!
        node.click_button("Create Book")
        AePageObjects::VariableDocument.new(Books::ShowPage, self.class)
      end
    end
  end
end
