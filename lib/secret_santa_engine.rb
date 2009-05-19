class SecretSantaEngine
  
  def initialize
    @santas = []
  end
  
  def shuffle
    if @santas.length > 1 then @santas else [] end
  end
  
  def add(names)
    names.each_with_index do |name, index|
      @santas << {:santa => name, :recipient => names[index-1]}
    end
  end
end