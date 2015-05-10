=begin

Class Fenetre
-------------
Gestion de la fenêtre

=end
class Fenetre
  
  FEN_WIDTH   = 1200
  FEN_HEIGHT  = 200
  FEN_TOP     = 400
  FEN_LEFT    = 100
  
  attr_reader :data
  attr_reader :root
  
  ##
  ## Contenu de la fenêtre (frame)
  ##
  attr_reader :content
  
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
    data[:top]    ||= FEN_TOP
    data[:left]   ||= FEN_LEFT
    # @root['geometry'] = '300x200-5+40'
    @root['geometry'] = "#{data[:width]}x#{data[:height]}-#{data[:left]}+#{data[:top]}"
    
    @content = Tk::Tile::Frame::new( @root )
    
    create_label
    create_progressbar
    bind_fenetre

    content.grid :column => 0, :row => 0 

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
    @main_label = Tk::Tile::Label.new(content) do
    # @main_label = Tk::Tile::Label.new(root) do
      text      "Clique la touche espace ou -> pour commencer."
      padding   '10 10'
    end.grid(column: 0, row: 0)
    
    ##
    ## Définir la font du texte
    ##
    appHighlightFont = TkFont.new :family => 'Helvetica', :size => 32, :weight => 'normal'
    @main_label['font'] = appHighlightFont
    
    @main_label['width']      = data[:width]
    ##
    ## Pour "enrouler" un texte trop grand
    ##
    @main_label['wraplength'] = data[:width]
    
    ##
    ## Bordure
    ##
    @main_label['borderwidth'] = 2
    @main_label['relief'] = 'sunken'
  end
  
  ##
  #
  # La barre de progression indiquant quelle quantité de texte a
  # déjà été lue et quelle quantité reste à lire
  #
  def create_progressbar
    @progressbar = Tk::Tile::Progressbar.new(content) do
    # @progressbar = Tk::Tile::Progressbar.new(root) do
      orient 'horizontal'
      # length FEN_WIDTH
      mode 'determinate'
    end.grid(column: 0, row: 2 )
    @progressbar['length'] = FEN_WIDTH
  end
  
  ##
  #
  # Construction des menus
  #
  def build_menus
    @menubar = Menubar::new self
  end
  
end