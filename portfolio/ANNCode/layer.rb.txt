class Layer
	attr_accessor :neurons

	def initialize
		@neurons = Array.new
	end

	# adds a neuron to the layer
	def add_neuron(neuron)
		@neurons.push(neuron)
	end

	# to string method that prints out the information for a layer
	def to_s
		neurons.each_index do |i|
			puts "Neuron " + i.to_s + ": " + neurons[i].weights.to_s + "\n"
		end
	end

end