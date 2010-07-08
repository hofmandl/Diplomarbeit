set terminal latex
set output "plotf.tex"

set format xy "$%g$"
unset key
r=0.05 
mu=0.2 
sigma=0.4
pstern=(mu-r)/sigma**2
ymax=0.5*((mu-r)/sigma)**2
set xrange [-0.25*pstern:2.25*pstern]
set xtics ("0" 0, '$\pistar$' pstern, '2$\pistar$' 2*pstern)
set ytics ("0" 0, '$f(\pistar)$' ymax)
set grid

plot x*(mu-r)-0.5*x**2*sigma**2


