require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'validates that a new Product has all required fields' do
      @category = Category.new(
        name: 'Test Products'
      )
      @category.save!
      @product = Product.new(
        name: 'Ball',
        price_cents: 1000,
        quantity: 20,
        category_id: @category[:id]
      )
      @product.save!
      expect(@product).to be_present
    end

    it 'validates that a new Product does not save if :name is nil' do
      @category = Category.new(
        name: 'Test Products'
      )
      @category.save!
      @product = Product.new(
        price_cents: 1000,
        quantity: 20,
        category_id: @category[:id]
      )
      # expect(@product).to_not be_valid
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it 'validates that a new Product does not save if :price is nil' do
      @category = Category.new(
        name: 'Test Products'
      )
      @category.save!
      @product = Product.new(
        name: 'ball',
        quantity: 20,
        category_id: @category[:id]
      )
      # expect(@product).to_not be_valid
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
    end

    it 'validates that a new Product does not save if :quantity is nil' do
      @category = Category.new(
        name: 'Test Products'
      )
      @category.save!
      @product = Product.new(
        name: 'ball',
        price_cents: 1000,
        category_id: @category[:id]
      )
      # expect(@product).to_not be_valid
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it 'validates that a new Product does not save if :category is nil' do
      @category = Category.new(
        name: 'Test Products'
      )
      @category.save!
      @product = Product.new(
        name: 'ball',
        price_cents: 1000,
        quantity: 20,
      )
      # expect(@product).to_not be_valid
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
    end

  end

end