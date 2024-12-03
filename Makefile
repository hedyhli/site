HUGO=hugo
HUGO_CACHEDIR=~/hugo_cache
HUGO_FLAGS=--cleanDestinationDir

PRETTIER=pnpm prettier

RSYNC=rsync
RSYNC_FLAGS=-rav

HUT=hut

GEMINI_DEST=~/public_gemini
GEMINI_DEST_BASE=public_gemini
HTML_DEST=~/public_html

DATA_BAK_DEST=pgs.sh:/site-data

UGLYURL_EXCLUDE=*not-used-anymore*

DEPLOY_HTML=home.hedy.dev
DEPLOY_HTML_REPO=/Users/hedy/projects/site-public
DEPLOY_GEMINI=gmi.hedy.dev
DEPLOY_GEMINI_DIST=gmi.tar.gz

.DEFAULT_GOAL := all

lint-css:
	pnpm exec stylelint --config .config/stylelint.json --rd --rdd assets/main.css

lint-html-validate:
	pnpm exec html-validate --config .config/htmlvalidate.json $(HTML_DEST)

lint-html-proofer:
	htmlproofer $(HTML_DEST) --checks Links,Images,Scripts,Favicon,OpenGraph --no-allow-missing-href --no-ignore-empty-alt

lint: lint-css lint-html-validate lint-html-proofer

deploy-html:
	$(RSYNC) -rv --delete --exclude .git $(HTML_DEST)/ $(DEPLOY_HTML_REPO)
	cd $(DEPLOY_HTML_REPO) && git add -A
	cd $(DEPLOY_HTML_REPO) && git commit -m 'make deploy-html'
	cd $(DEPLOY_HTML_REPO) && git push
	$(RSYNC) -rv assets/data $(DATA_BAK_DEST)

deploy-gemini:
	$(RSYNC) $(RSYNC_FLAGS) ../spsrv/README.gmi $(GEMINI_DEST)/spsrv/index.gmi
	tar -C $(GEMINI_DEST) -cvz . > $(DEPLOY_GEMINI_DIST)
	$(HUT) pages publish --protocol GEMINI -d $(DEPLOY_GEMINI) $(DEPLOY_GEMINI_DIST)
	rm $(DEPLOY_GEMINI_DIST)

deploy: deploy-html deploy-gemini

backup:
	$(RSYNC) $(RSYNC_FLAGS) $(GEMINI_DEST) $(GEMINI_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) $(HTML_DEST) $(HTML_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) assets/data $(HTML_DEST)-back/data

nonsymlink-clean:
	# clean all non-symlink files
	find $(GEMINI_DEST) -not -type l -type f -delete

gen:
	rm -rf $(HUGO_CACHEDIR)/site/filecache/getresource
	bin/getraindrop.sh
	make hugo

hugo:
	$(HUGO) $(HUGO_FLAGS) --cacheDir $(HUGO_CACHEDIR)

gemini:
	$(RSYNC) $(RSYNC_FLAGS) $(GEMINI_DEST) $(GEMINI_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) public/gemini/ $(GEMINI_DEST)/ --exclude _index.gmi
	$(RSYNC) $(RSYNC_FLAGS) public/posts/gemini/* public/posts/*.gmi $(GEMINI_DEST)/posts --exclude _index.gmi

gemini-clean:
	GEMINI_DEST=$(GEMINI_DEST) PUBLIC=public python3 bin/gemini-clean.py -n

html:
	rm -rf public/tags/*/index.xml
	$(RSYNC) --delete $(RSYNC_FLAGS) public/ --exclude '*.gmi' --exclude gemini $(HTML_DEST)
	@# Manually include gemini tag (because it was excluded above)
	$(RSYNC) --delete $(RSYNC_FLAGS) public/tags/gemini $(HTML_DEST)/tags/

html-prettify:
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
