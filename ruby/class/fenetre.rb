=begin

Class Fenetre
-------------
Gestion de la fenêtre

=end
class Fenetre
  
  FEN_WIDTH   = 840
  FEN_HEIGHT  = 200
  
  attr_reader :data
  attr_reader :root
  
  ##
  ## Label Tk contenant le texte
  ##
  attr_reader :main_label
  
  ##
  ## Barre Tk de progression
  ##
  attr_reader :progressbar
  
  ##
  ## Menus Tk
  ##
  attr_reader :menubar
  
  def initialize data = nil
    @data = data
    build
    build_menus
  end
  
  
  def next_text
    file.next_paragraph
  end
  def prev_text
    file.prev_paragraph
  end
  
  ##
  #
  # L'instance TutoText du fichier contenant le texte
  #
  def file
    @file ||= TutoText::new( self, data[:file] )
  end
  
  ##
  #
  # Définit le fichier à utiliser
  #
  # +filepath+ {String} Path du nouveau fichier
  #
  def set_file filepath
    file.path = filepath
    file.reset
  end
  
  ##
  #
  # Ouvre la fenêtre
  def open
    menubar.build
    Tk.mainloop
  end
  
  # ---------------------------------------------------------------------
  #   Réglages
  # ---------------------------------------------------------------------
  
  ##
  #
  # Réglage de la barre de progression.
  #
  # La méthode est appelée par TutoText (fichier associé à la fenêtre)
  # lorsque les paragraphes sont chargés
  #
  def set_progressbar
    # puts "Valeur max. barre de progression : #{file.paragraphs_count}"
    progressbar['maximum'] = file.paragraphs_count
  end
  
  
  #---------------------------------------------------------------------
  #   Construction de la fenêtre
  # ---------------------------------------------------------------------
  
  ##
  #
  # Construit la fenêtre
  #
  def build
    @root = TkRoot.new
    @root['title']  = data[:titre]
    @root['width']  = data[:width]  || FEN_WIDTH
    @root['height'] = data[:height] || FEN_HEIGHT
    
    data[:width]  ||= FEN_WIDTH
    data[:height] ||= FEN_HEIGHT
    data[:top]    ||= 100
    data[:left]   ||= 0
    # @root['geometry'] = '300x200-5+40'
    @root['geometry'] = "#{data[:width]}x#{data[:height]}-#{data[:left]}+#{data[:top]}"
    
    create_label
    create_progressbar
    bind_fenetre

  end
  
  def bind_fenetre
    root.bind("Key-space"){ main_label['text'] = next_text }
    root.bind("Key-Right"){ main_label['text'] = next_text }
    root.bind("Key-Left"){  main_label['text'] = prev_text }
  end
  
  ##
  #
  # On crée le label
  #
  def create_label
    @main_label = Tk::Tile::Label.new(root) do
      text      "Clique la touche espace ou -> pour commencer."
      padding   '10 10'
      width     '200'
    end.grid
    
    @main_label['borderwidth'] = 2
    @main_label['relief'] = 'sunken'
  end
  
  ##
  #
  # La barre de progression indiquant quelle quantité de texte a
  # déjà été lue et quelle quantité reste à lire
  #
  def create_progressbar
    @progressbar = Tk::Tile::Progressbar.new(root) do
      orient 'horizontal'
      length FEN_WIDTH
      mode 'determinate'
    end.grid
  end
  
  ##
  #
  # Construction des menus
  #
  def build_menus
    @menubar = Menubar::new self
  end
  
end