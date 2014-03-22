module Rhb
  class Builder
    VOID_ELEMENTS = %w{area base br col command embed hr img input
                       keygen link meta param source track wbr}.freeze

    undef :p

    def initialize
      @buffer = ''
    end

    def to_s
      @buffer
    end
    alias :to_html :to_s

    def doctype
      @buffer << '<!DOCTYPE html>'
    end

    private

    def element name, *args, void, &block
      attrs = html_attrs extract_options! args
      @buffer << "<#{name}#{' ' unless attrs.empty?}#{attrs}>"
      return if void
      if args.empty? and block_given?
        instance_exec &block
      else
        @buffer << args.first.to_s
      end
      @buffer << "</#{name}>"
    end

    def cache_element name
      self.class.class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name} *args, &block
          element '#{name}', *args, #{void_element? name}, &block
        end
      CODE
    end

    def html_attrs attrs, prefix = ''
      attrs.each_with_object('') do |(name, value), result|
        result << if value.kind_of? Hash
          html_attrs value, "#{prefix}#{name}-"
        else
          %Q{#{prefix}#{name}="#{value}" }
        end
      end.strip
    end

    def extract_options! array
      return [] unless array.last.kind_of? Hash
      array.pop
    end

    def void_element? name
      VOID_ELEMENTS.include? name.to_s
    end

    def method_missing name, *args, &block
      cache_element name
      public_send name, *args, &block
    end
  end
end
