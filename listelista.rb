# encoding: UTF-8
require "e"
require 'faraday'
require "json"

require_relative "settings.rb"
require_relative "lib/cache.rb"
require_relative "lib/review.rb"

class App < E
  map '/'

  auth do |user, pass|
    [user, pass] == [Settings::USER, Settings::PASSWORD]
  end

  def index
    res = Faraday.get("http://marc2rdf.deichman.no/api/users/mylists")
    lists = JSON.parse(res.body)["mylists"].first
    @lists = []
    lists.each do |list|
      list["items"].map! {
        |uri|
        r = Review.new(uri)
        {:uri => uri, :title => r.book_title, :authors => r.book_authors }
      }
      @lists << list
    end
    render
  end
end