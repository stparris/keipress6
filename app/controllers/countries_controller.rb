class CountriesController < ProductionController
	before_action :set_country, only: [:show]

	def show
		return_doc = {}
		return_doc['success'] = true
		return_doc['phone_code'] = @country.phone_code
		return_doc['states'] = []
		respond_to do |format|
			format.json do
				begin
					if @country.states.any?
						@country.states.each do |state|
							next unless state.name
							return_doc['states'] << { id: state.id, name: state.name }
						end
					end
					render json: return_doc.to_json
				rescue Exception => e
					return_doc['success'] = false
					return_doc['message'] = "Error: #{e.message}"
					render json: return_doc.to_json
				end
			end
		end
	end

	private
		def set_country
			@country = Country.find(params[:id])
		end

end
