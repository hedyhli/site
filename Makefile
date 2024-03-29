HUGO=hugo
HUGO_CACHEDIR=~/hugo_cache
HUGO_FLAGS=--cleanDestinationDir

RSYNC=rsync
RSYNC_FLAGS=-av

GEMINI_DEST=~/public_gemini
GEMINI_DEST_BASE=public_gemini
HTML_DEST=~/public_html

UGLYURL_EXCLUDE=*spsrv*

.DEFAULT_GOAL := all

backup:
	$(RSYNC) $(RSYNC_FLAGS) $(GEMINI_DEST) $(GEMINI_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) $(HTML_DEST) $(HTML_DEST)-back --delete

nonsymlink-clean:
	# clean all non-symlink files
	find ~/public_gemini -not -type l -type f -delete

gen:
	$(HUGO) $(HUGO_FLAGS) --cacheDir $(HUGO_CACHEDIR)

gemini:
	$(RSYNC) $(RSYNC_FLAGS) $(GEMINI_DEST) $(GEMINI_DEST)-back --delete
	$(RSYNC) $(RSYNC_FLAGS) public/*.gmi public/posts/*.gmi public/gemini/ $(GEMINI_DEST)/ --exclude _index.gmi
	$(RSYNC) $(RSYNC_FLAGS) public/posts/gemini/index.xml $(GEMINI_DEST)/feed.xml

gemini-clean:
	# This is the target that has caused me the most trouble, literally lost my
	# entire public_gemini from this when I had a bug here.
	# So PLEASE PLEASE PLEASE make sure to run make all (or make backup
	# manually) before using this!
	#
	# Remove copied post files
	find $(GEMINI_DEST) -wholename '*/$(GEMINI_DEST_BASE)/????-??-??-*.gmi' -delete
	# Use ugly urls, find the dirs that only contains a single 'index.gmi',
	# excluding the root index.gmi
	find $(GEMINI_DEST) -wholename '*/index.gmi' -not -wholename '$(UGLYURL_EXCLUDE)' -not -wholename '*/posts/index.gmi' -not -wholename '*/$(GEMINI_DEST_BASE)/index.gmi' -exec echo '{}' \; > out.txt
	# Copy /blah/index.gmi to blah.gmi then rm /blah/
	while read line; do \
		dest=$$( echo $$line | sed 's_/index.gmi$$_.gmi_'); \
		dir=$$( echo $$line | sed 's_/index.gmi$$__'); \
		echo Syncing and removing $$(basename $$dir); \
		rsync $$line $$dest; \
		rm -rf $$dir; \
	done < out.txt; \
	rm out.txt
	echo done

html:
	$(RSYNC) $(RSYNC_FLAGS) public/ --exclude '*.gmi' --exclude gemini $(HTML_DEST)
	# Manually include gemini tag (because it was excluded above)
	$(RSYNC) $(RSYNC_FLAGS) public/tags/gemini $(HTML_DEST)/tags/

finish-clean:
	rm -rf $(GEMINI_DEST)-back $(HTML_DEST)-back

all: backup gen gemini html gemini-clean
full: nonsymlink-clean backup gen gemini html gemini-clean

# DO NOT USE THIS LOL
danger-all: all finish-clean
danger-full: full finish-clean
