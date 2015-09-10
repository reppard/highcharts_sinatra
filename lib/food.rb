require 'crack' # XML and JSON parsingrequire 'crack/json' # Only JSON parsing
require 'crack/xml' # Only XML parsing
require 'pp'


class FoodData
  DATA_SETS = {
    "Food_Display_Table"             => {
      display_name_key: "Display_Name",
      calories_key:     "Calories",
      solid_fats_key:   "Solid_Fats",
      sat_fats_key:     "Saturated_Fats",
      added_sugar_key:  "Added_Sugar",
      veggies_key:      "condiment_vegetables",
      portion_size_key: "condiment_portion_size"
    },
    "Foods_Needing_Condiments_Table" => {
    },
    "lu_Condiment_Food_Table"        => {
      display_name_key: "display_name",
      calories_key:     "condiment_calories",
      solid_fats_key:   "condiment_solid_fats",
      sat_fats_key:     "condiment_saturated_fats",
      added_sugar_key:  "condiment_added_sugars",
      veggies_key:      "condiment_vegetables",
      portion_size_key: "condiment_portion_size"
    }
  }
  attr_reader :categories, :calories, :solid_fats, :sat_fats, :added_sugar, :veggies
  
  def initialize table
    @table_name  = "#{table}_Table"
    @row_name    = "#{table}_Row"
    @food_data   = get_food_rows
    @categories  = get_categories
    @calories    = get_calories
    @solid_fats  = get_solid_fats
    @sat_fats    = get_sat_fats
    @added_sugar = get_added_sugar
    @veggies     = get_veggies
  end

  def get_veggies
    @food_data.collect{ |entry| entry[data_set[:veggies_key]].to_f }
  end

  def get_added_sugar
    @food_data.collect{ |entry| entry[data_set[:added_sugar_key]].to_f }
  end

  def get_sat_fats
    @food_data.collect{ |entry| entry[data_set[:sat_fats_key]].to_f }
  end

  def get_solid_fats
    @food_data.collect{ |entry| entry[data_set[:solid_fats_key]].to_f }
  end

  def get_calories
    @food_data.collect{ |entry| entry[data_set[:calories_key]].to_f }
  end

  def get_categories
    @food_data.collect{ |entry|
      "#{entry[data_set[:display_name_key]]}(#{entry[data_set[:portion_size_key]]})"
    }
  end

  def data_set
    DATA_SETS[@table_name]
  end

  def collection_size
    @food_data.size
  end

  def data_path
    File.expand_path(File.join(File.dirname(__FILE__), "../data/#{@table_name}.xml"))
  end

  def get_food_rows
    data = Crack::XML.parse(File.read(data_path))
    puts data
    data[@table_name][@row_name]
  end
end
