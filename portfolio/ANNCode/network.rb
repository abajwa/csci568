class Network
  attr_reader :output, :target_output, :hidden_output, :layers, :input

  def initialize(layerSizes)
    # if there are no incoming layer sizes
    if layerSizes.size == 0 and !layerSize.include?(0)
      puts "Error: the number of neurons (> 0) in each layer must be specified."
      return -1
    end

    # the learning rate
    @N = 0.1

    @layers = Array.new
    # arrays that hold the input and the outputs of the layers
    @input = Array.new
    @output = Array.new
    @hidden_output = Array.new

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

	def target_output(output)
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

		# creates an array to hold the hidden output and feeds the inputs of the neural network
    # takes the output of the input layer (the inputs) and multiplies them by their respective
    # weights then adds them together and inputs them into next layer
		@hidden_output = Array.new(layers[1].neurons.size(), 0.0)
		@hidden_output.each_index do |h|
			@results = Array.new(layers[1].neurons.size, 0.0)
				total = 0.0
				@input.each_index do |i|
					total += @input[i] * layers[0].neurons[i].weights[h]
				end
				@hidden_output[h] = total
		  end

      # creates the array to hold the overall output of the current feed_forward
      # same idea as the previous comments
			@output = Array.new(@target_output.size, 0.0)
			@output.each_index do |o|
				total = 0.0
				@hidden_output.each_index do |h|
					total += @hidden_output[h] * layers[1].neurons[h].weights[o]
				end
				@output[o] = total
			end
		@output
	end

	# trains the network with backpropagation
	# assumes the first layer in layers is the input layer
	# assumes 1 through size-1 are hidden layers
	# assumes layers[size-1] is the output layer
	def train
		results = @input
		error0 = 1
		error1 = 1
		error2 = 1
    it = 0

    # while the error of each output is greater than 0.000001
		while error0 > 0.000001 and error1 > 0.000001 and error2 > 0.000001
      results = feed_forward
			backpropogate

			error0 = (@target_output[0] - @output[0]).abs
			error1 = (@target_output[1] - @output[1]).abs
			error2 = (@target_output[2] - @output[2]).abs

      # rounds output to the nearest 100th
      #@output.each_index do |o|
      #  @output[o] = (@output[o]*100).ceil/100.0
      #end

      puts "Results of Iteration: " + it.to_s
      puts results
      puts "--------------------"
      it += 1
		end

    puts "\n\nOutput after training:"
		puts results
	end


  # dtanh was used in CI but since my implementation is linear the derivative would
  # just be 1
	def dtanh(y)
		1.0#-(y*y)
	end

	# used by the tain method to backpropagate through the ANN
	def backpropogate
		# if there is no output generated yet, feed_forward must be called first
		if @output.size == 0
			puts "Error: network output must be specified before feed_forward can be executed"
			return -1
		end

		# holds the errors for the overall network output
		output_deltas = Array.new(@output.size, 0.0)
		# for each current output calculate the error of the current output
    # in comparisson to the target output. 
		@output.each_index do |i|
			error = @target_output[i] - @output[i]
			output_deltas[i] = dtanh(@output[i]) * error
		end

		# holds the errors for the hidden layer
		hidden_deltas = Array.new(@hidden_output.size, 0.0)
		# for each hidden_layer output calculate the error
		hidden_deltas.each_index do |h|
			error = 0.0
			# for each output delta
			output_deltas.each_index do |o|
				error += output_deltas[o] * layers[1].neurons[h].weights[o]
			end
			hidden_deltas[h] = dtanh(@hidden_output[h]) * error
		end

		# updates the weights going from the hidden layer to the output layer
    # by calculating a change using the error from the output and hidden layer
    # then adding that change * the learning rate to the current weight
		# for each input
		@hidden_output.each_index do |h|
			@output.each_index do |o|
				change = output_deltas[o] * @hidden_output[h]
				layers[1].neurons[h].weights[o] += change * @N
			end
		end

    # updates the weights going from the input layer to the hidden layer in the same
    # way as the other weights were updated
		@input.each_index do |i|
			@hidden_output.each_index do |j|
				change = hidden_deltas[j] * @input[i]
				layers[0].neurons[i].weights[j] += change * @N
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

  private
  # adds a layer to the layers for the network
  def add_layer(layer)
    @layers.push(layer)
  end

end