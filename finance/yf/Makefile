all:
	$(MAKE) etfs.py plots.py data.py

tsp_shareprices.xlsx: data.ipynb
	rm -f data.py
	$(MAKE) data.py
	[ -f tsp_shareprices.xlsx ] && cp tsp_shareprices.xlsx ~/Downloads/

%.py : %.ipynb Makefile
	jupyter nbconvert --to=notebook --clear-output $< >/dev/null
	jupyter nbconvert --to=python $< >/dev/null
	chmod +x $@

clean:
	rm -f *.pdf *.out tsp_shareprices.xlsx

clobber:
	$(MAKE) clean
	rm -f *.py *~
