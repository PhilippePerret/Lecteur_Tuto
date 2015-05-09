=begin

Class TutoText
--------------
Le fichier texte du tutoriel

=end
class TutoText
  
  def initialize path = nil
    @path = path
  end
  
  ##
  #
  # Path du fichier contenant le texte du tuto
  #
  def path
    @path ||= File.join('.', 'asset', 'tuto_sample.txt')
  end
  
end