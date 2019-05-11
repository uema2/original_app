class ToppagesController < ApplicationController
  def index
    @hobby = Hobby.limit(20).order('created_at DESC')
  end
end
