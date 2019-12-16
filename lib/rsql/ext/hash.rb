Hash.class_eval do
  def slice(*keys)
    h = {}
    keys.each { |k| h[k] = self[k] if key?(k) }
    h
  end unless method_defined?(:slice)
end
