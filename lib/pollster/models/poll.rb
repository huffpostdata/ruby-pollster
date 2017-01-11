require 'date'

module Pollster

  class Poll
    # Unique Poll identifier. For example: `gallup-26892`.
    attr_accessor :slug

    # First date survey house conducted polling.
    attr_accessor :start_date

    # Last date survey house conducted polling.
    attr_accessor :end_date

    # Date Pollster editors first entered this Poll
    attr_accessor :created_at

    # Date Pollster editors last edited this Poll. Edits are usually corrections; they are sometimes additions of new questions that were originally skipped.
    attr_accessor :updated_at

    # Name of survey house. For example: `Gallup`
    attr_accessor :survey_house

    # One of `Automated Phone`, `Internet`, `IVR/Live Phone`, etc.
    attr_accessor :mode

    # Website where the survey house published the poll results.
    attr_accessor :url

    # One of `Nonpartisan`, `Pollster` (the survey house is partisan), `Sponsor` (the survey house is nonpartisan, but the sponsor is partisan)
    attr_accessor :partisanship

    # `None` if `partisanship` is `Nonpartisan`; otherwise one of `Dem`, `Rep` or `Other`
    attr_accessor :partisan_affiliation

    # Questions on the Poll that Pollster editors have entered. Pollster doesn't include every question on the poll: it only includes questions of interest to Pollster editors. Poll questions are ordered in the same order as published by the survey house. 
    attr_accessor :poll_questions


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'slug' => :'slug',
        :'start_date' => :'start_date',
        :'end_date' => :'end_date',
        :'created_at' => :'created_at',
        :'updated_at' => :'updated_at',
        :'survey_house' => :'survey_house',
        :'mode' => :'mode',
        :'url' => :'url',
        :'partisanship' => :'partisanship',
        :'partisan_affiliation' => :'partisan_affiliation',
        :'poll_questions' => :'poll_questions'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'slug' => :'String',
        :'start_date' => :'String',
        :'end_date' => :'String',
        :'created_at' => :'String',
        :'updated_at' => :'String',
        :'survey_house' => :'String',
        :'mode' => :'String',
        :'url' => :'String',
        :'partisanship' => :'String',
        :'partisan_affiliation' => :'String',
        :'poll_questions' => :'Array<PollQuestion>'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}){|(k,v), h| h[k.to_sym] = v}

      if attributes.has_key?(:'slug')
        self.slug = attributes[:'slug']
      end

      if attributes.has_key?(:'start_date')
        self.start_date = attributes[:'start_date']
      end

      if attributes.has_key?(:'end_date')
        self.end_date = attributes[:'end_date']
      end

      if attributes.has_key?(:'created_at')
        self.created_at = attributes[:'created_at']
      end

      if attributes.has_key?(:'updated_at')
        self.updated_at = attributes[:'updated_at']
      end

      if attributes.has_key?(:'survey_house')
        self.survey_house = attributes[:'survey_house']
      end

      if attributes.has_key?(:'mode')
        self.mode = attributes[:'mode']
      end

      if attributes.has_key?(:'url')
        self.url = attributes[:'url']
      end

      if attributes.has_key?(:'partisanship')
        self.partisanship = attributes[:'partisanship']
      end

      if attributes.has_key?(:'partisan_affiliation')
        self.partisan_affiliation = attributes[:'partisan_affiliation']
      end

      if attributes.has_key?(:'poll_questions')
        if (value = attributes[:'poll_questions']).is_a?(Array)
          self.poll_questions = value
        end
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
          slug == o.slug &&
          start_date == o.start_date &&
          end_date == o.end_date &&
          created_at == o.created_at &&
          updated_at == o.updated_at &&
          survey_house == o.survey_house &&
          mode == o.mode &&
          url == o.url &&
          partisanship == o.partisanship &&
          partisan_affiliation == o.partisan_affiliation &&
          poll_questions == o.poll_questions
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [slug, start_date, end_date, created_at, updated_at, survey_house, mode, url, partisanship, partisan_affiliation, poll_questions].hash
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
