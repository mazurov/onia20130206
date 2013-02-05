# you can find rst2beamer.py here:
# http://codespeak.net/svn/user/antocuni/bin/rst2beamer.py

# WARNING: to work, it needs this patch for docutils
# https://sourceforge.net/tracker/?func=detail&atid=422032&aid=1459707&group_id=38414

build/talk.pdf: talk.rst author.tex stylesheet.tex figs/*.png
	test -d build || mkdir build
	rst2beamer.py --stylesheet=stylesheet.tex  --documentoptions=14pt talk.rst talk.tex || exit
	sed 's/\\date{}/\\input{author.tex}/' -i talk.tex || exit
	latexmk -pv -jobname=build/talk -pdf talk || exit

view: build/talk.pdf
	evince build/talk.pdf &
