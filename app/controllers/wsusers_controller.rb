class WsusersController < ApplicationController

  skip_before_action :authenticate_request
  soap_service namespace: 'urn:WashOutUser', camelize_wsdl: :lower

  soap_action "check",
              :args => {:email => :string},
              :return => :boolean

  def check
    @req_mail = params[:email]
    ex  = false
    if (User.exists?(email: @req_mail))
      ex = true
    end
    render :soap => ex
  end
end
