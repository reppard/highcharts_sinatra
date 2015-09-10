require 'sinatra'
require 'lazy_high_charts'
require './lib/food.rb'

include LazyHighCharts::LayoutHelper


get '/' do
  highchart_example
  erb :index #, :layout => :layout
end

def highchart_example
  #food_data = FoodData.new("lu_Condiment_Food")
  food_data = FoodData.new("Food_Display")
  height    = food_data.collection_size * 25

  puts food_data

  @chart = LazyHighCharts::HighChart.new(
    'graph', { :style => "height: #{height}px" }) do |f|

    f.chart({ type: 'bar'})
    f.title({ text: "Food Chart"})
    f.options[:yAxis][:min] = 0

    f.options[:xAxis][:categories] = food_data.categories
    f.series(:type=> 'column',:name=> "Veggies" ,:data=> food_data.veggies)
    f.series(:type=> 'column',:name=> "Added Sugar(g)" ,:data=> food_data.added_sugar)
    f.series(:type=> 'column',:name=> "Saturated Fats" ,:data=> food_data.sat_fats)
    f.series(:type=> 'column',:name=> "Solid Fats" ,:data=> food_data.solid_fats)
    f.series(:type=> 'column',:name=> "Calories" ,:data=> food_data.calories)
  end
  
end
