  
class Application

    @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/) # We should only be using this route
            diff_items = req.path.split("/items/").last # this variable will split items after the last '/'
            item = @@items.find{|i| i.name == diff_items} # Now this will set each path equal to what is afer 'items/'
            if item #item is now branching off into a route like: '/items/Figs'
                resp.write item.price #if item exists it will return a 200 code and its price.
            else
                resp.write "Item not found" #if item does not exist it will return a 400 code error.
                resp.status = 400
            end
        else
            resp.write "Route not found" #if route doesn't exist it will return error 404.
            resp.status = 404
        end
        resp.finish
    end
end