module Fusuma
  module Plugin
    module Executors
      # Exector plugin
      class CommandExecutor < Executor
        def execute(vector)
          command = search_command(vector)
          `#{command}`
        end

        def executable?(vector)
          search_command(vector)
        end

        # @param vector [Vector]
        # @return [String]
        def search_command(vector)
          Config.search(index(vector), String)
        end

        # @example
        #  index
        #  =>[:swipe, :3, left, :command]
        # @param vector [Vector]
        # @return [String]
        def index(vector)
          [*vector.index, 'command']
        end
      end
    end
  end
end