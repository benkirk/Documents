all:
	$(MAKE) etfs.py plots.py

tsp_shareprices.xls: plots.ipynb
	rm -f plots.py
	$(MAKE) plots.py

%.py : %.ipynb Makefile
	jupyter-3.7 nbconvert --to=notebook --clear-output $< >/dev/null
	jupyter-3.7 nbconvert --to=python --execute $< >/dev/null
	chmod +x $@
	[ -f tsp_shareprices.xls ] && cp tsp_shareprices.xls ~/Downloads/

clean:
	rm -f *.pdf

clobber:
	$(MAKE) clean
	rm -f *.py *~
