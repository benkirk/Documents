all:
	$(MAKE) rbfs.py

%.py : %.ipynb Makefile
	jupyter-3.7 nbconvert --to=notebook --clear-output $< >/dev/null
	jupyter-3.7 nbconvert --to=python $< >/dev/null
	chmod +x $@

profile.out: rbf.py
	python3.7 -O -m cProfile -s cumtime ./rbf.py | tee profile.out

clean:
	rm -f *.out

clobber:
	$(MAKE) clean
	rm -f *.py *~

# python3.7 -O -m cProfile -s cumtime ./rbf.py
