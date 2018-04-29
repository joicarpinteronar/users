class AuthenticationController < ApplicationController
skip_before_action :authenticate_request
	def connect
		ldap = Net::LDAP.new(
			host:'openldap',
			port: 389,
			auth: {
				method: :simple,
				dn: "cn=admin, dc=pcun,dc=com",
				password: "admin"
			}
		)
		puts "lo que retorna ldap.bind"
		puts ldap.bind
		return ldap.bind
	end

	def authenticate
		email = params[:email].to_s
    password = params[:password].to_s
		if connect()
      puts "me conecte"
      ldap = Net::LDAP.new(

        host: 'openldap.users-ms',
        port: 389,
        auth: {
          method: :simple,
          dn: 'cn=' + email +',ou=App,dc=pcun,dc=com',
          password: password
        }
      )
      if ldap.bind
				command = AuthenticateUser.call(params[:email], params[:password])
				if command.success?
					#pasar el token por header en inicio de sesion
					#response envio al cliente
					response.headers["jwt"] = command.result

					#render json: { message: ["Login successful"] }, status: :ok
					render json: { token: command.result }, status: :ok
				else
				render json: { error: command.errors }, status: :unauthorized
				end
      else
        render  status: :unauthorized
      end
		end
  end
end
