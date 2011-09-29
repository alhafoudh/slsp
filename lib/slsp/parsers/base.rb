module SLSP

  module Parsers

    class Base
      
      attr_accessor :input

      def initialize(input)
        @input = input
      end

      def parse
        nil
      end

    end

  end

end
