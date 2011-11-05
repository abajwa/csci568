class Network
	attr_accessor :output, :input, :layers

	def initialize(layerSizes)
		@layers = Array.new
		@input = Array.new
		@output = Array.new
		if layerSizes.size == 0
			puts "Error: the number of neurons in each layer must be specified."
			return -1
		end

		# creates a layer for each of the sizes provided in layerSizes
		layerSizes.each_index do |i|
			layer = Layer.new
			(0...layerSizes[i]).each do |n|
				# if the current layer is not the output layer
				# create neurons with a weight to each neuron in
				# the following layer
				if i != layerSizes.size() - 1
					layer.add_neuron(Neuron.new(layerSizes[i+1]))
				else
					layer.add_neuron(Neuron.new(0))
				end
			end
			add_layer(layer)
		end
	end

	# adds a layer to the layers for the network
	def add_layer(layer)
		@layers.push(layer)
	end

	# accepts an array with the input values for the network
	# the number of input values must match the number of neurons
	# in the first layer of the network
	def input(input)
		if @layers[0].neurons.size() != input.size
			puts "Error: the number of inputs must be equal to the number of neurons in the input layer"
			return -1
		end
		@input = input
	end

	# given the inputs this function feeds them through the network producing an output
	def feed_forward
		# if the input has not been specified yet output an error and return -1
		if @input.size == 0
			puts "Error: network input must be specified before feed_forward can be executed"
			return -1
		end
		# for each layer feed the inputs forward
		@layers.each_index do |i|

			# if the current layer is the input layer
			if i == 0
				# array that holds the output of the current layer
				@results = Array.new(layers[1].neurons.size, 0.0)

				# gets all the neurons for the current layer
				neurons = layers[i].neurons()

				# for each neuron on the input layer
				neurons.each_index do |nindex|
					# input at 0 corresponds with neuron 0
					weights = neurons[nindex].weights

					# for each weight on the current neuron multiply it by the
					# input and add it to the total for that neuron
					weights.each_index do |windex|
						@results[windex] += @input[nindex] * weights[windex]
					end
				end
			# for every other layer
			else
				# if there is another layer after the current
				# i.e. if it is not the output layer
				if i <= (layers.size - 2)
					# treat results array as if it is now the input
					@hResults = Array.new(layers[i+1].neurons.size, 0.0)
					neurons = layers[i].neurons()

					# for each neuron on the current layer
					neurons.each_index do |nindex|
						# results at 0 corresponds with neuron 0
						weights = neurons[nindex].weights
					# for each weight on the current neuron multiply it by the
					# result from the previous layer and add it to the total for
					# that neuron
						weights.each_index do |windex|
							@hResults[windex] += @results[nindex] * weights[windex]
						end
					end
				end
			end
		end
		@output = @hResults
	end

	# trains the network with backpropagation
	# assumes the first layer in layers is the input layer
	# assumes 1 through size-1 are hidden layers
	# assumes layers[size-1] is the output layer
	def train

	end
end