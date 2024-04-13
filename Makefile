HUGO=hugo
HUGO_CACHEDIR=~/hugo_cache
HUGO_FLAGS=--cleanDestinationDir

PRETTIER=prettier

RSYNC=rsync
RSYNC_FLAGS=-a

HUT=hut

GEMINI_DEST=~/public_gemini
GEMINI_DEST_BASE=public_gemini
HTML_DEST=~/public_html

UGLYURL_EXCLUDE=*no-used-anymore*

DEPLOY_DOMAIN=home.hedy.dev
DEPLOY_HTML_DIST=html.tar.gz
DEPLOY_GEMINI_DIST=gemini.tar.gz

.DEFAULT_GOAL := all

lint-css:
	pnpm exec stylelint --config .config/stylelint.json --rd --rdd assets/main.css

lint-html-validate:
	pnpm exec html-validate --config .config/htmlvalidate.json $(HTML_DEST)

lint-html-proofer:
	htmlproofer $(HTML_DEST) --checks Links,Images,Scripts,Favicon,OpenGraph --no-allow-missing-href --no-ignore-empty-alt

lint: lint-css lint-html-validate lint-html-proofer

deploy-html:
	tar -C $(HTML_DEST) -cvz . > $(DEPLOY_HTML_DIST)
	$(HUT) pages publish --protocol HTTPS -d $(DEPLOY_DOMAIN) $(DEPLOY_HTML_DIST)
	rm $(DEPLOY_HTML_DIST)

deploy-gemini:
	tar -C $(GEMINI_DEST) -cvz . > $(DEPLOY_GEMINI_DIST)
	$(HUT) pages publish --protocol GEMINI -d $(DEPLOY_DOMAIN) $(DEPLOY_GEMINI_DIST)
	rm $(DEPLOY_GEMINI_DIST)

deploy: deploy-html deploy-gemini

backup:
	$(RSYNC) $(RSYNC_FLAGS) $(GEMINI_DEST) $(GEMINI_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) $(HTML_DEST) $(HTML_DEST)-back --delete

nonsymlink-clean:
	# clean all non-symlink files
	find $(GEMINI_DEST) -not -type l -type f -delete

gen:
	rm -rf $(HUGO_CACHEDIR)/site/filecache/getresource
	$(HUGO) $(HUGO_FLAGS) --cacheDir $(HUGO_CACHEDIR)

gemini:
	$(RSYNC) $(RSYNC_FLAGS) $(GEMINI_DEST) $(GEMINI_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) public/*.gmi public/posts/*.gmi public/gemini/ $(GEMINI_DEST)/ --exclude _index.gmi
	$(RSYNC) $(RSYNC_FLAGS) public/posts/gemini/index.xml $(GEMINI_DEST)/feed.xml
	$(RSYNC) $(RSYNC_FLAGS) public/posts/gemini/index.gmi $(GEMINI_DEST)/posts/index.gmi

gemini-clean:
	GEMINI_DEST=$(GEMINI_DEST) python3 bin/gemini-clean.py

html:
	$(RSYNC) $(RSYNC_FLAGS) public/ --exclude '*.gmi' --exclude gemini $(HTML_DEST)
	@# Manually include gemini tag (because it was excluded above)
	$(RSYNC) $(RSYNC_FLAGS) public/tags/gemini $(HTML_DEST)/tags/
	$(PRETTIER) --config .config/prettier.toml --write $(HTML_DEST)"/**/*.html"

finish-clean:
	rm -rf $(GEMINI_DEST)-back $(HTML_DEST)-back

gen-gemini: backup gen gemini gemini-clean
gen-html: backup gen html
all: backup gen gemini html gemini-clean
full: nonsymlink-clean backup gen gemini html gemini-clean

# DO NOT USE THIS LOL
danger-all: all finish-clean
danger-full: full finish-clean
