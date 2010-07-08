set terminal latex
set output "plotconstantwcb.tex"

r=0.05 
mu=0.2 
sigma=0.4
# set size ratio 1
unset key
set xlabel "Konstante Strategie"
set ylabel 'Worst-\\Case-\\Schranke'

plot [0:1] r*2 + (x*(mu-r)-0.5*x**2*sigma**2)*2+log(1-x*0.2), r*1 + (x*(mu-r)-0.5*x**2*sigma**2)+log(1-x*0.2) 
