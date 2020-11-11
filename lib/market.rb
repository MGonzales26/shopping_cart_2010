class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.find do |inv_item, quantity|
        inv_item == item
      end
    end
  end

  def quantity_total_of_item(item)
    sum = []
    @vendors.map do |vendor|
      vendor.inventory.map do |inv_item, quantity|
        sum << quantity if item == inv_item
      end
    end
    sum.sum
  end

  def total_inventory
    item_hash = Hash.new
    @vendors.map do |vendor|
      vendor.inventory.map do |item, quantity|
        item_hash[item] = Hash.new
        item_hash[item][:quantity] = quantity_total_of_item(item)
        item_hash[item][:vendors] = vendors_that_sell(item)
      end
    end
    item_hash
  end
end