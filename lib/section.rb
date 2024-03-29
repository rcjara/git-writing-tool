module GWT
  class Section
    attr_reader :subsections, :body

    def initialize(args = {}, &block)
      set_default_values!

      @subsections = []

      args.each_pair do |method, value|
        send(method, value)
      end

      instance_eval &block if block
    end

    def section(attr = {}, &block)
      attributes = attr.merge({parent: self})
      subsections << Section.new(attributes, &block)
    end

    def file(filename, &block)
      attributes  = FileReader.read(full_path + filename)
                              .merge({parent: self})
      subsections << Section.new(attributes, &block)
    end

    def text(str = '', &block)
      subsections << Section.new({ body: str, parent: self }, &block)
    end

    def parent(new_parent = nil)
      return @parent if new_parent.nil?
      @parent = new_parent
    end

    def body(str = nil)
      return @body if str.nil?
      @body = str
    end

    def directory(dir = nil)
      return @directory unless dir
      #ensure dirname has a trailing '/'
      dir_name = dir =~ %r{/$} ? dir : dir + '/'
      @directory = dir_name
    end

    def formatted_text
      displayer.formatted_text
    end

    def method_missing(method_name, *args, &block)
      return super if method_name.to_s =~ /\?|\!|\=/

      if args.length == 1
        assign_var(method_name, args[0])
      elsif has_var?(method_name) && args.empty?
        get_var method_name
      else
        super
      end
    end

    private

    def full_path
      (parent ? parent.directory : '') + directory
    end

    def set_default_values!
      @body = ''
      @heading = nil
      @directory = ''
    end

    def displayer
      @displayer ||= SectionDisplayer.new(self)
    end

    def has_var?(var_name)
      instance_variables.include? clean_var_name(var_name)
    end

    def get_var(var_name)
      instance_variable_get clean_var_name(var_name )
    end

    def assign_var(var_name, value)
      instance_variable_set clean_var_name(var_name), value
    end

    def clean_var_name(var_name)
      with_at = if var_name.to_s =~ /^@/
        var_name.to_s
      else
        '@' + var_name.to_s
      end

      with_at.gsub(/\=/, '').to_sym
    end
  end
end
