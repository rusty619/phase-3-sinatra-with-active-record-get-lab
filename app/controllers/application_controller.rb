class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  # add routes
  get '/bakeries' do 
    # get all the barkeries from the database
    barkies = Bakery.all
    # send them back as a JSON array
    barkies.to_json
  end

  get '/bakeries/:id' do 
    barkies = Bakery.find(params[:id])
    barkies.to_json(only: [:id,:name], 
      include: {baked_goods: {only: [:id, :name, :price]}})
  end

  get '/baked_goods/by_price' do 
    baked_goods = BakedGood.order("price desc")
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do 
    baked_goods = BakedGood.order("price desc").first 
    baked_goods.to_json
  end

end
