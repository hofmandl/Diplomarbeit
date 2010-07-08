set terminal latex
set output "plotflog.tex"

set multiplot layout 1,2

r=0.05 
mu=0.2 
sigma=0.4
pstern=(mu-r)/sigma**2
set xrange [-0.25*pstern:2.25*pstern]
unset key
set noxtics
set noytics

set title 'Graph von f'
plot x*(mu-r)-0.5*x**2*sigma**2

set title 'Graph von $\log(1-k\pi)$'
plot [-20:5]log(1-0.2*x)

