require 'tk'
require 'tkextlib/tile'

# Initialiser la fenêtre
root = TkRoot.new {title "Feet to Meters"}

## Un "widget" (ou la fenêtre ? frame)
##
## C'est le fait de mettre 'root' en paramètre qui fait que le widget va être
## créé dans `root'
# content = Tk::Tile::Frame.new(root) {padding "3 3 12 12"}.grid(:sticky => 'nsew')

##
## Ces deux lignes permet de "suivre" si la fenêtre est redimensionnée
## à la souris
##
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1


## Un label texte est créé dans la fenêtre
l = Tk::Tile::Label.new(root) do
  text "Starting..."
  padding '10 10'
  width '200'
end.grid

##
## On lui attache des évènements :
##

## Quand la souris entre dans le label
l.bind("Enter") {l['text'] = "Moved mouse inside"}
## Quand la souris sort du label
l.bind("Leave") {l['text'] = "Moved mouse outside"}
## Quand on clique gauche
l.bind("1") {l['text'] = "Clicked left mouse button"}
## Quand on double clique
l.bind("Double-1") {l['text'] = "Double clicked"}
## Quand on clique-droit et déplace la souris
l.bind("B3-Motion", proc{|x,y| l['text'] = "right button drag to #{x} #{y}"}, "%x %y")

##
## Quand la touche retour est cliqué
##
root.bind("Return"){ l['text'] = "Touche retour !" }

##
## Quand la touche espace est appuyée
##
##
## La définition des "keysyms" se trouve sur la page :
## http://www.tcl.tk/man/tcl8.5/TkCmd/keysyms.htm
##
root.bind("Key-space"){ l['text'] = "Touche espace" }
##
## Flèche haut
##
root.bind("Key-Up"){l['text'] = "Touche up !"}

# $feet = TkVariable.new; $meters = TkVariable.new
# f = Tk::Tile::Entry.new(content) do
#   width 7
#   textvariable $feet
# end.grid( :column => 2, :row => 1, :sticky => 'we' )


# TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
# f.focus

Tk.mainloop
