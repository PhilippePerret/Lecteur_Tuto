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
  attr_reader :main_label
  
  def initialize data = nil
    @data = data
    build
  end
  
  ##
  #
  # Construit la fenêtre
  #
  def build
    @root = TkRoot.new
    @root['title']  = data[:titre]
    @root['width']  = data[:width]  || FEN_WIDTH
    @root['height'] = data[:height] || FEN_HEIGHT
    create_label
    bind_fenetre
  end
  
  def bind_fenetre
    root.bind("Key-space"){ main_label['text'] = next_text }
    root.bind("Key-Right"){ main_label['text'] = next_text }
    root.bind("Key-Left"){  main_label['text'] = prev_text }
  end
  
  def next_text
    "Le texte suivant"
  end
  def prev_text
    "Le texte précédent"
  end
  
  ##
  #
  # Ouvre la fenêtre
  def open
    Tk.mainloop
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
  end
  
end