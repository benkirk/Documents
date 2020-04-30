
%.py : %.ipynb
	jupyter-3.7 nbconvert --to=python --execute $< >/dev/null
	chmod +x $@

clean:
	rm -f *.pdf

clobber:
	$(MAKE) clean
	rm -f *.py *~
