module ItemsHelper
  #options_for_select　カテゴリー用
    def category_choices
      categories = {}
      Category.all.each do |category|
        categories.merge!(category.name => category.id)
      end
      categories
    end
end
