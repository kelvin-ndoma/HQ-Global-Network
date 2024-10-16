class RenderController < ApplicationController
  def home
    render json: {message: "This is HQ GN API"}
  end
end
