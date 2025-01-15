class StringCalculatorsController < ApplicationController
	def add
		if params[:numbers].starts_with?("//")
			parsed_delimiter = parse_custom_delimiter(params[:numbers])
			delimiter = parsed_delimiter[0]
			numbers = parsed_delimiter[1].split(delimiter)
		else
			numbers = params[:numbers].gsub("\n", ",").split(',')
		end	
		sum = numbers.map(&:to_i).sum
		render plain: sum
	end

	private

	def parse_custom_delimiter(input)
		match = input.match(%r{//(.+?)\n(.*)})
		if match
      delimiter = match[1]
      numbers = match[2]
      [delimiter, numbers]
    end
	end
end
