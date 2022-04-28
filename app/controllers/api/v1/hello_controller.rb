class Api::V1::HelloController < ActionController::API

  def hello
    render json: {
      message: 'hello'
    }
  end
end