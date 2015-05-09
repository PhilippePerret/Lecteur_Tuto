=begin

Class TutoText
--------------
Le fichier texte du tutoriel

=end
class TutoText
  
  ##
  ## L'indice du paragraphe courant
  ##
  attr_reader :icur_paragraph
  
  def initialize path = nil
    @path = path
  end
  
  def next_paragraph
    @icur_paragraph ||= -1
    return "--- DERNIER PARAGRAPHE ATTEINT ---" if @icur_paragraph == paragraphs_count - 1
    @icur_paragraph += 1
    paragraph
  end
  
  def prev_paragraph
    return "Il faut commencer par la touche Espace ou la flèche droite" if @icur_paragraph.nil?
    @icur_paragraph -= 1 if @icur_paragraph > 0
    paragraph
  end
  
  def paragraph
    paragraphs[@icur_paragraph]
  end
  
  ##
  #
  # Retourne la liste des paragraphes (seulement ceux contenant du texte)
  #
  def paragraphs
    @paragraphs ||= begin
      t = File.read(path).force_encoding('utf-8')
      t.split("\n").reject{ |p| p.strip == "" || p.strip.start_with?('#')}
    end
  end
  
  ##
  #
  # Nombre de paragraphes
  #
  def paragraphs_count
    @paragraphs_count ||= paragraphs.count
  end
  
  ##
  #
  # Path du fichier contenant le texte du tuto
  #
  def path
    @path ||= begin
      p = Dir["./_texte_ici_/*.*"][0]
      p ||= File.join('.', 'asset', 'tuto_sample.txt')
      p
    end
  end
  
end