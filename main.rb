#!/usr/bin/env ruby
=begin

Script principal à lancer

Permet la lecture ligne à ligne d'un texte pour enregistrement du texte d'un
tutoriel.

Le fichier contenant le texte doit être défini :

  * Soit par path dans l'attribut `path' ci-dessous
  * Soit en mettant le fichier dans le dossier `_texte_ici_'

=end

require './ruby/required'

##
## Initialise les menus
##
Menubar::init

##
## Crée la fenêtre où va apparaitre le texte
##
fen = Fenetre::new( 
  titre:  "Lecture du tutoriel",
  file:   nil # le fichier contenant le texte
  )


##
## Ouvre la fenêtre
##  
fen.open

