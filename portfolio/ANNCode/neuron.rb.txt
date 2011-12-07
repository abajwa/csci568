class Neuron
	attr_accessor :weights

	def initialize(numWeights)
		@weights = Array.new(numWeights)
		# assigns a random weight to each of the weights going out of the neuron
		@weights.each_index do |i|
			@weights[i] = -1 + rand(100)/50.0
		end
	end
end