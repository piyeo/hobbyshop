module ItemsHelper
  #options_for_select　カテゴリー用
    def category_choices
      categories = {}
      Category.all.each do |category|
        categories.merge!(category.name => category.id)
      end
      categories
    end

  #検索用
    def q_category_choices
      categories = {}
      categories.merge!("すべて" => 0)
      Category.all.each do |category|
        categories.merge!(category.name => category.id)
      end
      categories
    end
end
