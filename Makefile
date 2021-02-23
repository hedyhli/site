.PHONY: gemini
gemini:
	tar cvf gemini.tar.gz public/gemini public/*.gmi

.PHONY: html
html:
	cd public
	ls *.gmi *.tar.gz | xargs tar cvf html.tar.gz . --exclude gemini/ --exclude Makefile --exclude
	cd ..
