class TokenInvalidsController < ApplicationController
  before_action :set_token_invalid, only: [:show, :update, :destroy]

  # GET /token_invalids
  def index
    @token_invalids = TokenInvalid.all

    render json: @token_invalids
  end

  # GET /token_invalids/1
  def show
    render json: @token_invalid
  end

  # POST /token_invalids
  def create
    @token_invalid = TokenInvalid.new(token_invalid_params)

    if @token_invalid.save
      render json: @token_invalid, status: :created, location: @token_invalid
    else
      render json: @token_invalid.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /token_invalids/1
  def update
    if @token_invalid.update(token_invalid_params)
      render json: @token_invalid
    else
      render json: @token_invalid.errors, status: :unprocessable_entity
    end
  end

  # DELETE /token_invalids/1
  def destroy
    @token_invalid.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token_invalid
      @token_invalid = TokenInvalid.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def token_invalid_params
      params.require(:token_invalid).permit(:token)
    end
end
