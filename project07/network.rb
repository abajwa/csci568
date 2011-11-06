class Network
	attr_accessor :taget_output, :output, :input, :hidden_output, :layers

	def initialize(layerSizes)
		@layers = Array.new
		@input = Array.new
		@output = Array.new
		@hidden_output = Array.new
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

	def result(output)
		if @layers[layers.size - 1].neurons.size() != output.size
			puts "Error: the number of inputs must be equal to the number of neurons in the input layer"
			return -1
		end
		@target_output = output
	end

	# given the inputs this function feeds them through the network producing an output
	def feed_forward
		# if the input has not been specified yet output an error and return -1
		if @input.size == 0
			puts "Error: network input must be specified before feed_forward can be executed"
			return -1
		end

		@hidden_output = Array.new(0)
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

						@hidden_output.push(@results[nindex])

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
		# while the outputs do not match the actual
		results = @input
		while euclideanDistance(results, @target_output) < 0.999
			results = feed_forward
			backpropogate
		end
		results
	end

	def euclideanDistance(obj1, obj2)
		#puts "---obj1----"
		#puts obj1
		#puts "-----------"
		self.to_s
		euc = 0
		for d in 0...obj1.length
			euc += (obj1[d] - obj2[d])**2
		end
		#puts euc
		1.0/(1.0 + Math.sqrt(euc))
	end


	def dtanh(y)
		1.0-(y*y)
	end

	# used by the tain method to backpropagate through the ANN
	def backpropogate
		# calculate the errors for the output
		if @output.size == 0
			puts "Error: network output must be specified before feed_forward can be executed"
			return -1
		end

		# calculate the errors for the output
		# current output is in output
		# target output is in target_output
		output_deltas = Array.new(@output.size, 0.0)

		puts "OUTPUT DELTA CALC ---------------------------"
		# for each current output
		@output.each_index do |i|
			error = @target_output[i] - @output[i]
			puts "\tERROR: " + error.to_s
			puts "\tdtanh: " + dtanh(@output[i]).to_s
			puts @output[i]
			output_deltas[i] = dtanh(@output[i]) * error
			puts "\tRESULT: " + output_deltas[i].to_s
		end

		# calculate the errors for the hidden layer
		hidden_deltas = Array.new(layers[1].neurons.size, 0.0)
		# for each hidden_layer output
		@hidden_output.each_index do |i|
			error = 0.0
			# for each output delta
			output_deltas.each_index do |j|
				error += output_deltas[j] * layers[1].neurons[i].weights[j]
			end
			hidden_deltas[i] = dtanh(@hidden_output[i]) * error
		end
		puts "Hidden output: "
		puts @hidden_output
		# updates the weights going into the output layer
		@hidden_output.each_index do |i|
			@output.each_index do |j|
				puts "\tOutput-deltas: " + output_deltas[j].to_s
				puts "\thidden output: " + @hidden_output[i].to_s
				change = output_deltas[j] * @hidden_output[i]
				puts "\tChange: " + change.to_s
				layers[1].neurons[i].weights[j] += change/2.0
				puts "\t Thing: " + layers[1].neurons[i].weights[j].to_s
			end
		end


		# updates the weights going into the hidden layer
		# for each input
		@input.each_index do |i|
			@hidden_output.each_index do |j|
				change = hidden_deltas[j] * @input[i]
				layers[0].neurons[i].weights[j] += change/2.0
			end
		end
	end

	# prints out the network - which includes:
	# => each layer
	# => each node in each layer
	# => all the weights for each node in each layer
	def to_s
		puts "Layers: " + layers.size.to_s
		layers.each_with_index do |layer, il|
			puts "Layer: " + il.to_s
			layer.neurons.each_with_index do |neu, ni|
				puts "\tNeuron: " + ni.to_s
				neu.weights.each do |w|
					puts "\t\tWeight: " + w.to_s
				end
			end
		end
	end

end