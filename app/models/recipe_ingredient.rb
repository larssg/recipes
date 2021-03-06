class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  
  validates_presence_of :recipe_id
  validates_presence_of :ingredient_id

  def to_s
    [
     self.format_amount,
     self.unit,
     self.name,
     self.extra
    ].select { |i| !i.blank? }.join(' ')
  end
  
  def name
    self.ingredient.andand.name
  end

  def name=(new_name)
    self.ingredient = Ingredient.find_or_create_by_name(new_name)
  end

  protected
  def format_amount
    amount_is_integer? ? self.amount.to_i : self.amount
  end

  def amount_is_integer?
    self.amount.andand.%(1) == 0
  end
end
