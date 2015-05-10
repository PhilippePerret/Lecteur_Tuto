=begin

Class Menu
----------
Gestion des menus de l'application de lecture

=end
class Menubar
  class << self
    
    def init
      TkOption.add '*tearOff', 0
    end
  end
  
  # ---------------------------------------------------------------------
  # Instance
  # ---------------------------------------------------------------------
  
  ##
  ## La fenêtre propriétaire du menu
  ##
  attr_reader :fenetre
  
  attr_reader :menubar
  
  def initialize fenetre
    @fenetre = fenetre
  end
  
  
  ##
  ## Construction de son menu
  ##
  def build
    # win         = TkToplevel.new fenetre.root
    @menubar    = TkMenu.new(fenetre.root)
    fenetre.root['menu'] = @menubar
    
    mfile = TkMenu.new(@menubar)
    medit = TkMenu.new(@menubar)
    @menubar.add :cascade, :menu => mfile, :label => 'Fichier'
    @menubar.add :cascade, :menu => medit, :label => 'Éditer'
    
    mfile.add :command, :label => 'Nouveau', :command => proc{newFile}
    mfile.add :separator
    mfile.add :command, :label => 'Ouvrir…', :command => proc{openFile}, :accelerator => "Command-O"
    mfile.add :separator
    mfile.add :command, :label => 'Fermer', :command => proc{closeFile}
  end
  
  def newFile
    puts "Nouveau fichier demandé"
  end
  def openFile
    file_path = Tk::getOpenFile # path string
    fenetre.set_file file_path
  end
  def closeFile
    puts "Fermeture de fichier demandée"
  end
end