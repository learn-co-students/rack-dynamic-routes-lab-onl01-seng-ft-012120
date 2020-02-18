require 'pry'
class Application

  @@items = []
 
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
 
      item = req.path.split("/items/").last #turn /items/apple into apple
      our_item = @@items.find{|i| i.name == item}
      if our_item
        resp.write our_item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
      # binding.pry

    else
      resp.write "Route not found"
      resp.status = 404
    end
 
    resp.finish
  end
end