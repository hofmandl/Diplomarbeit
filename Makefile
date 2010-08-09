GPATH=GNUPlotprogramme
OPATH=Octaveprogramme

Diplomarbeit.pdf:	plotflog.tex plotf.tex plotconstantwcb.tex ${OPATH}/bar.eps ${OPATH}/foo.eps
#	pdflatex

# erzeuge Bilder mit Gnuplot
plotflog.tex:	${GPATH}/plotflog.gp
	gnuplot ${GPATH}/plotflog.gp
	
plotf.tex:	${GPATH}/plotf.gp
	gnuplot ${GPATH}/plotf.gp

plotconstantwcb.tex:	${GPATH}/plotconstantwcb.gp
	gnuplot ${GPATH}/plotconstantwcb.gp
	
# erzeuge Bilder mit Matlabcode
${OPATH}/bar.eps:	${OPATH}/diplomarbeit.m
	echo A
	sh -c "cd ${OPATH}; octave diplomarbeit.m; cd .."

${OPATH}/foo.eps:	${OPATH}/diplomarbeit.m
	echo B
	sh -c "cd ${OPATH}; octave diplomarbeit.m; cd .."

# Latex compile

clean:
	rm -f plot*.tex
	rm -f *~ *.backup
