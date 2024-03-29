module PsuedoInheritance
  module ClassMethods
    def inherits_from(inheriter, args={})
      belongs_to inheriter, args
      inherited_methods(inheriter)
      inherited_save(inheriter)
      inherited_respond_to(inheriter)
    end

  private
    def inherited_methods(inheriter)
      define_method("method_missing") do |method, *args, &block|
        @memoized_references ||= {}  
        @memoized_references[inheriter.to_sym] ||= self.send inheriter
        model = @memoized_references[inheriter.to_sym]
  
        if model.send :respond_to?, method
          if method.to_s[/=$/]
            model.send :taint
            model.send method, *args
          else  
            model.send method
          end  
        else
          super(method, *args, &block)
        end
      end  
    end
  
    def inherited_save(inheriter)
      save_methods = %w(save save!)
      save_methods.each do |method|
        define_method(method) do
          # only momoized models need to be checked
          if @memoized_references  
            @memoized_references.each_pair do |key, model|
              model.send method if model.send :tainted?
            end
          end
          super()  
        end
      end  
    end
  
    def inherited_respond_to(inheriter)
      define_method("respond_to?") do |method|
        return true if super(method)
        model = self.send inheriter
        model.send(:respond_to?, method) 
      end
    end
  end
end

