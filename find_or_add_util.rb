class FindOrAddUtil
  class << self
    def find_or_add(log_value)
      if object = find(log_value)
        yield(object) if block_given?
      else
        object = self.new(log_value)
        list.push(object)
      end
      object
    end
  end
end
