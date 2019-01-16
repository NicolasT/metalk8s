all: deployment.png

%.png: %.uml
	cat $< | plantuml -p -tpng > $@

%.svg: %.uml
	cat $< | plantuml -p -tsvg > $@