class ReadonlyHash < Hash  
  class << self
    def [](*args)
      new(super(*args))
    end
  end
  
  def initialize(hash)
    update hash
    freeze
  end
end
