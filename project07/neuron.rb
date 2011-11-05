class Neuron
	attr_accessor :weights

	def initialize(numWeights)
		@weights = Array.new(numWeights)
		@weights.each_index do |i|
			@weights[i] = rand() * 2 -1
		end
		# used to test the network with easy weights
		#@weights.each_index do |i|
		#	@weights[i] = i + 1
		#end
	end
end