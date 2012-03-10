## Use `#include ".Xdefaults.ex"` and customize whatever.

URxvt*scrollBar:false
URxvt*scrollBar_right:true
URxvt*scrollTtyOutput:false
URxvt*scrollTtyKeypress:true
URxvt*transparent:true
# URxvt*shading: 28

## tint with any color; i.e., blue, red, tomato4, olivedrab2, etc.
##   some nice listings are at:
##     http://www.nisrv.com/modules.php?name=Hex_Colors
##     http://www.htmlgoodies.com/tutorials/colors/article.php/3478921
##URxvt*tintColor:blue

## shading - 0 to 99 darkens, 101 to 200 lightens.
##   Don't use with tintColor; use a darker or lighter color instead.
URxvt*shading:40

## scrollback buffer lines - 65535 is max (64 is default)
##URxvt*saveLines:12000

## font color (default is black)
URxvt*foreground:White

## background color (prior to tinting) (default is white)
URxvt*background:Black

## xft fonts - anti-aliased xft font setup is nice, but can be choppy
##URxvt*font: xft:Bitstream Vera Sans Mono:pixelsize=13
URxvt*font: xft:Monospace-12
## NOTE: or '...-8'.

## traditional fonts - a more traditional font setup in lieu of xft
##URxvt*font:-*-courier-medium-r-normal-*-*-140-*-*-*-*-iso8859-1
##URxvt*boldFont:-*-courier-bold-r-normal-*-*-140-*-*-*-*-iso8859-1

## Replace blue folder colors with a lighter shade for clarity. To
## set colored folders and files within urxvt, xterm, and aterm, add
## the following line to your ~/.bashrc ($HOME/.bashrc) file under
## the heading "# User specific aliases and functions":
##   alias ls="ls -h --color=auto"
URxvt*color4:RoyalBlue
URxvt*color12:RoyalBlue


xterm*eightBitInput: false
xterm*background: black
xterm*foreground: white
