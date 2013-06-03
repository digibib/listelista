# encoding: UTF-8
require "e"
require "http"
require "json"

class App < E
  map '/'

  def index
    lists = Http.get("http://marc2rdf.deichman.no/api/users/mylists")
    @lists = JSON.parse(lists)["mylists"].first
    render
  end
end

App.run