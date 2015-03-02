json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.countOfBeers brewery.beers.count
end