module GWT
  class Section
    def initialize(args = {}, &block)
      set_default_values!

      args.each_pair do |method, value|
        send(method, value)
      end

      instance_eval &block if block
    end

    def set_default_values!
      @text = ''
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
