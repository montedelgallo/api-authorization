class HomeController < ApplicationController
  def index

    render json: { message: "This is home"}
  end
end
