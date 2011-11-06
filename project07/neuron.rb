class Neuron
	attr_accessor :weights, :output

	def initialize(numWeights)
		@weights = Array.new(numWeights)
		@weights.each_index do |i|
			@weights[i] = -1 + rand(100)/50.0# rand() * 2 - 1
		#end
		# used to test the network with easy weights
		#@weights.each_index do |i|
		#	@weights[i] = 0.5
		end
	end
end