class AuthorizeApiRequest
	prepend SimpleCommand
	def initialize(headers = {})
		@headers = headers
	end
	def call
		user
	end

	private

	attr_reader :headers
	def user
		@user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
		@user || errors.add(:token, 'Invalid token') && nil
	end
	def decoded_auth_token
		@decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
	end
	def http_auth_header
		if headers['Authorization'].present?
			jwt = headers['Authorization'].split(' ').last
      #Si no se encuentra un token (retorna vacio) significa que el token puede ser el ultimo token o puede ser un token que haya cumplido fecha el tiempo
			if InvalidToken.find_token(jwt) != []
				errors.add(:token, 'Invalid token')
			else
        	#Crea el token si todavia no se vence el tiempo 
				InvalidToken.create(token: jwt) if JsonWebToken.decode(jwt) != nil
				return jwt
			end
		else
			errors.add(:token, 'Missing token')
		end
		nil
	   end
	end
