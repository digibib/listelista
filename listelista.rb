# encoding: UTF-8
require "e"
require "http"
require "json"

require_relative "settings.rb"

class App < E
  map '/'

  auth do |user, pass|
    [user, pass] == [Settings::USER, Settings::PASSWORD]
  end

  def index
    lists = Http.get("http://marc2rdf.deichman.no/api/users/mylists")
    @lists = JSON.parse(lists)["mylists"].first
    render
  end
end

App.run