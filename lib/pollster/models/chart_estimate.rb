require 'date'

module Pollster
  # One set of estimates. The first set of estimates on a Chart is the official \"Pollster Estimates\".
  class ChartEstimate
    # Name of the algorithm that produced these estimates. Possible values are: `bayesian-kallman` ([source code](https://github.com/huffpostdata/pollster-models/tree/master/poll-average), [academic explanation](http://eppsac.utdallas.edu/files/jackman/CAJP%2040-4%20Jackman.pdf)); `lowess` (locally weighted scatterplot smoothing).
    attr_accessor :algorithm

    # The time Pollster produced these estimates. Consider `datetime` instead. `datetime` describes what Pollster calculates; `created_at` describes _when_ Pollster made those calculations.
    attr_accessor :created_at

    # The time these `values` apply to. For instance, Pollster may run `lowess` (which is deterministic) years after an election; in that case `created_at` will be the date of the `lowess` calculation, and `datetime` will be the election date.
    attr_accessor :datetime

    # Each key is a response Label. Each value is Pollster's estimate of the polling average for that label. For instance, `{ \"Clinton\": 47.3, \"Trump\": 42.0, \"Other\": 5.2 }`. Values often do not add up to 100%. Some Responses on a Question have no corresponding Values, because Pollster sometimes omits Responses from a Chart. 
    attr_accessor :values

    attr_accessor :lowess_parameters

    # Only present if `algorithm` is `bayesian-kallman`. Each key is a response Label. Each value is the `[ low, high ]` of the algorithm's 95% confidence interval.
    attr_accessor :bayesian_kallman_95_percent_intervals


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'algorithm' => :'algorithm',
        :'created_at' => :'created_at',
        :'datetime' => :'datetime',
        :'values' => :'values',
        :'lowess_parameters' => :'lowess_parameters',
        :'bayesian_kallman_95_percent_intervals' => :'bayesian_kallman_95_percent_intervals'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'algorithm' => :'String',
        :'created_at' => :'String',
        :'datetime' => :'String',
        :'values' => :'Object',
        :'lowess_parameters' => :'ChartEstimateLowessParameters',
        :'bayesian_kallman_95_percent_intervals' => :'Object'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}){|(k,v), h| h[k.to_sym] = v}

      if attributes.has_key?(:'algorithm')
        self.algorithm = attributes[:'algorithm']
      end

      if attributes.has_key?(:'created_at')
        self.created_at = attributes[:'created_at']
      end

      if attributes.has_key?(:'datetime')
        self.datetime = attributes[:'datetime']
      end

      if attributes.has_key?(:'values')
        self.values = attributes[:'values']
      end

      if attributes.has_key?(:'lowess_parameters')
        self.lowess_parameters = attributes[:'lowess_parameters']
      end

      if attributes.has_key?(:'bayesian_kallman_95_percent_intervals')
        self.bayesian_kallman_95_percent_intervals = attributes[:'bayesian_kallman_95_percent_intervals']
      end

    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properies with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      return invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          algorithm == o.algorithm &&
          created_at == o.created_at &&
          datetime == o.datetime &&
          values == o.values &&
          lowess_parameters == o.lowess_parameters &&
          bayesian_kallman_95_percent_intervals == o.bayesian_kallman_95_percent_intervals
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [algorithm, created_at, datetime, values, lowess_parameters, bayesian_kallman_95_percent_intervals].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map{ |v| _deserialize($1, v) } )
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        temp_model = Pollster.const_get(type).new
        temp_model.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        next if value.nil?
        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map{ |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end

end
