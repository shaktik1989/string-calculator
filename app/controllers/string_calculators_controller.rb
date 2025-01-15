class StringCalculatorsController < ApplicationController
	def add
		numbers = params[:numbers].split(',')
		sum = numbers.map(&:to_i).sum
		render plain: sum
	end
end
