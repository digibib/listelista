# encoding: UTF-8

class Review

  attr_reader :book_authors, :book_title, :invalid

  def initialize(uri)
     raw = Cache.get(uri, :reviews) {
       res = Http.get(Settings::API, :body => {:uri => uri})
       if res["error"] == "no reviews found"
         @invalid = true
         return
       end
       Cache.set(uri, res, :reviews)
     }
    unless raw["works"].size > 0
      @invalid = true
      return
    end

    #review = raw["works"].first["reviews"].first
    work = raw["works"].first

    @book_authors = work["authors"].map { |a| a["name"] }.join(', ')
    @book_title   = work["prefTitle"] || work["originalTitle"]
    @invalid = false
  end


end