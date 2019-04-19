require_relative '../base.rb'

module Fusuma
  module Plugin
    # executor class
    module Executors
      # Inherite this base
      class Executor < Base
        attr_reader :options

        def initialize(options = {})
          @options = options
        end

        # check executable
        # @param _vector [Vector]
        # @return [TrueClass, FalseClass]
        def executable?(_vector)
          raise NotImplementedError, "override #{self.class.name}##{__method__}"
        end

        # execute somthing
        # @param _vector [Vector]
        # @return [nil]
        def execute(_vector)
          raise NotImplementedError, "override #{self.class.name}##{__method__}"
        end

        # Set source for tag from config.yml.
        # DEFAULT_SOURCE is defined in each Executor plugins.
        def source
          @source ||= options.fetch(:source,
                                    self.class.const_get('DEFAULT_SOURCE'))
        end
      end

      # Generate executor
      class Generator
        # @param options [Hash] like a { executor: { dummy: 'dummy_options'  }  }
        def initialize(options:)
          @options = options.fetch(:executors, {})
        end

        # Generate executor plugins
        # @return [Array]
        def generate
          plugins.map do |klass|
            klass.generate(options: @options)
          end.compact
        end

        # executor plugins
        # @return [Array]
        def plugins
          # TODO: select executors that is on config.yml
          Executor.plugins
        end
      end
    end
  end
end