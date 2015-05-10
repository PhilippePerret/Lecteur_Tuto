=begin

Class TutoText
--------------
Le fichier texte du tutoriel

=end
class TutoText
  
  ##
  ## L'instance {Fenetre} à laquelle est attaché le fichier
  ##
  attr_reader :fenetre
  
  ##
  ## L'indice du paragraphe courant
  ##
  attr_reader :icur_paragraph
  
  ##
  ## Path du fichier (pour le définir de l'extérieur, avec le menu "Ouvrir"
  ## par exemple)
  ##
  attr_writer :path
  
  def initialize fenetre, path = nil
    @fenetre  = fenetre
    @path     = path
  end
  
  ##
  #
  # Ré-initialise le texte. Lorsqu'un nouveau fichier est choisi
  # par exemple
  #
  def reset
    @icur_paragraph   = nil
    @paragraphs       = nil
    fenetre.progressbar['value'] = 0
    @paragraphs_count = nil
    get_paragraphs
    fenetre.main_label['text'] = "=== Presser la barre espace ou la flèche droite pour commencer ==="
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
  
  ##
  #
  # Return le paragraphe courant
  #
  def paragraph
    # puts "Paragraphe d'indice #{@icur_paragraph}"
    fenetre.progressbar['value'] = @icur_paragraph + 1
    paragraphs[ @icur_paragraph ]
  end
  
  ##
  #
  # Retourne la liste des paragraphes (seulement ceux contenant du texte)
  #
  def paragraphs
    get_paragraphs if @paragraphs.nil?
    @paragraphs
  end
  
  def get_paragraphs
    t = File.read(path).force_encoding('utf-8')
    @paragraphs = t.split("\n").reject{ |p| p.strip == "" || p.strip.start_with?('#')}
    fenetre.set_progressbar
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