class StringCalculatorsController < ApplicationController
	def add
		begin
			if params[:numbers].starts_with?("//")
				parsed_delimiter = parse_custom_delimiter(params[:numbers])
				delimiter = parsed_delimiter[0]
				numbers = parsed_delimiter[1].split(delimiter)
			else
				numbers = params[:numbers].gsub("\n", ",").split(',')
			end	
			numbers = numbers.map(&:to_i)

			negatives = numbers.select { |n| n < 0 }
	    unless negatives.empty? #raising error for negative numbers
	      raise StandardError, "Negative numbers not allowed: #{negatives.join(', ')}"
	    end
      
      #ignore number greater than 1000
	    numbers = numbers.reject{|num| num > 1000}

			sum = numbers.sum
			render plain: sum
		rescue StandardError => e
			render plain: "Error: #{e.message}", status: :bad_request
		end
	end

	private

	def parse_custom_delimiter(input)
		match = input.match(%r{//\[(.*?)\]\n(.*)})
		if match
      delimiter = match[1]
      numbers = match[2]
      [delimiter, numbers]
    end
	end
end
