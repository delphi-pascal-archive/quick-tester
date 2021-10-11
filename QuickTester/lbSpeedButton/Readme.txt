############################################################
#                                                          #
# LbButtons Suite - Two new buttons for Delphi!            #
# Copyright (C) 2000-2002  Leif Bruder                     #
#                                                          #
# This file is part of LbButtons Suite.                    #
#                                                          #
# LbButtons Suite is free software; you can redistribute   #
# it and/or modify it under the terms of the GNU Lesser    #
# General Public License as published by the Free Software #
# Foundation; either version 2.1 of the License, or (at    #
# your option) any later version.                          #
#                                                          #
# LbButtons Suite is distributed in the hope that it will  #
# be useful, but WITHOUT ANY WARRANTY; without even the    #
# implied warranty of MERCHANTABILITY or FITNESS FOR A     #
# PARTICULAR PURPOSE.  See the GNU Lesser General Public   #
# License for more details.                                #
#                                                          #
# You should have received a copy of the GNU Lesser        #
# General Public License along with LbButtons Suite; if    #
# not, write to the Free Software Foundation, Inc., 59     #
# Temple Place, Suite 330, Boston, MA  02111-1307  USA     #
#                                                          #
############################################################
#                                                          #
# LbButtons Suite 2.4.1                                    #
#                                                          #
#                                                          #
# TLbSpeedButton, TLbButton, TLbStaticText                 #
#                                                          #
# Use these components at will, but at your own risk!      #
# Feel free to contact me via www.leif-bruder.de!          #
#                                                          #
# New versions of these components will be placed on       #
# www.leif-bruder.de/e_download.htm first, then, if all    #
# works, on www.torry.net                                  #
# Other Delphi sites may not provide the newest versions!  #
#                                                          #
# Any suggestions, error reports etc. highly appreciated!  #
#                                                          #
#                                                          #
# NOTE: The LGPL (see copying.txt) applies to releases 2.0 #
#       and later only; releases 1.0 to 1.9.1 may be used  #
#       as if you'd been the one who wrote them (well, if  #
#       you do so, I'd appreciate you to put a notice into #
#       your program about who made the buttons, but I do  #
#       not REQUIRE you to do so!)                         #
#                                                          #
############################################################


TLbSpeedButton is similar to TSpeedButton, but was
completely rewritten from scratch. It behaves like the
original SpeedButton, but has some new properties I thought
to be useful:

- ColorStyle    - pre-defined color styles (try ultra flat!)
- ColorWhenDown - need to explain?
- HotTrackColor - mouse over button: change color...
- HotTrackFont  - ...and font
- LightColor    - the bright part of the button edge when
                  3d, or the brighter part of the button in
                  modern style
- ShadowColor   - the darker part of the button edge when
                  3d, or the border color in modern style
- SlowDecease   - set a HotTrackColor and try...
- Style         - Normal, Encarta, Old, Modern, Quicken
                  (difficult to describe, just have a look!)
                  bsShape: Glyph is centered in the
                  background; Caption always centered.
                  The button's shape is controlled by the
                  glyph... just give it a try...
- WordWrap      - need to explain?


New events:

- OnMouseEnter - the mouse cursor is now over the button
- OnMouseExit  - do I really need to describe this one NOW?


Why I made it? Try creating a MS Access 2000-like user
interface with the standard TSpeedButton or see the
sample EXE!

Warning: Some color games should be used only when using
at least 64k color mode! True color highly recommended!



TLbButton is a similar component, but it can be focused.
Replaces TButton & TBitBtn.

TLbStaticText is a TLabel replacement; some features,
like AutoSize, are still missing... working on that...



NOTE: If you think you've found a bug or have made some
      changes to the source, please check if there's a
      newer version out before reporting bugs I've
      already removed... I'm getting buried in mails
      telling me the buttons don't have an anchors
      property...



Files
=====

LbButton.pas        LbButton source
LbButtons.pas       common functions used by all components
LbButtons.res       icons & bitmaps
LbSpeedButton.pas   LbSpeedButton source
LbStaticText.pas    LbStaticText source
Readme.txt          this file
Sample\*            a simple demo app with source



Installation
============

Copy all the files to a directory of your choice, then start
Delphi and add "LbButton.pas", "LbSpeedButton.pas" and
"LbStaticText.pas" to your components list, that's it!



Known Bugs
==========

- if a TLbButton is placed directly on a form and the style
  set to bsModern, bsShape or bsQuicken, the edges won't be
  rounded / the button will always be a rectangle.
  WORKAROUND: Place something "under" the button. No matter
  whether it's a TShape in the background or the button is
  placed on a panel... as soon as something is between the
  form itself and the button, it will display correctly...
  Anybody know why? Help!!!



History
=======

- Release 2.4.1
  - Thread creation only if SlowDecease := true

- Release 2.4
  - new property added: Action
  - new property value added: Style, bsQuicken
  - new property value added: ColorStyle, csQuicken

- Release 2.3
  - bugfix: Click procedure working again
  - New component added - TLbStaticText

- Release 2.2.1
  - bugfix: freeing the thread crashed on some systems

- Release 2.2 - Major update!
  - new property added: SlowDecease
  - new property value added: Style, bsOld
  - new property value added: Style, bsShape
  - new property value added: ColorStyle, lcsUltraFlatXP
  - buttons shape correctly now
  - close to no more flickering at all
  - standard captions finally working
  - bugfix: enabled := false now behaves correctly

- Release 2.1
  - paint method partly re-written
  - new property added: HotTrackFont
  - new property added: Anchors

- Release 2.0.1
  - bugfix: accelerators working again

- Release 2.0
  - placed under the Lesser GPL: see file "copying.txt"
  - LbButton now uses regions to appear smoothly rounded


--- license switch to LGPL ---


- Release 1.9.1
  - minor update: LbButton doesn't flicker in "Modern" style

- Release 1.9
  - bugfix: Default property behaving strangely
  - bugfix: Deadlock in Delphi 5 (and others?) when buttons
    became too small to display a caption

- Release 1.8
  - paint method partly re-written
  - both buttons now support multi-line captions

- Release 1.7
  - Glyph property can hold a 3rd & 4th bitmap for "down"
    and "hottrack" (cursor is over button) state now
  - bugfix: LbButton changed Caption to its name if Caption
    was empty

- Release 1.6
  - whoops... fixed an awful bug in LbButton (OnClick event
    was fired twice?!?)
  - LbButton now has a default & cancel property. Both can
    be selected at once, so the button can react BOTH on
    ENTER and ESC.

- Release 1.5
  - accelerators finally working
  - new pre-defined colorstyles added
  - new function added: Click (missed it, huh?)
  - new component added: TLbButton - just try!

- Release 1.4
  - new property added: ColorWhenDown
  - new property added: ColorStyle

- Release 1.3
  - new Style: Modern (looks a bit like Mac OS)
  - paint method partly re-written
  - added GlyphTop & GlyphBottom

- Release 1.2
  - new property added: Style
  - icon added

- Release 1.1
  - bugfix: general protection fault when deleting glyph

- Initial release 1.0



Thanks
======

John Bitros        - bug reports
Barry Dirks        - bug reports
Steven Eckwielen   - StaticText idea, threading help
Giovanni Ferrari   - bug reports
Diego J. Muñoz     - accelerators help
Steve Octaviano    - word-wrapping idea
Raymond J. Schappe - various bug reports
John Stevenson     - bug reports
Bogdan Vuk         - "down" glyph idea
