class RenderController < ApplicationController
  def index
    render json: {message: "This is HQ GN API"}
  end
end
