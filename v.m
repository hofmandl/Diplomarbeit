function wert=v(t,x)
r=0.05;
mu=0.2;
sigma=0.4;
M=100000;

n=100; % Anzahl der Schritte
T=10; % Zeithorizont

wert=log(x)+(r+0.5*(mu-r)^2/sigma^2)*(T-t);
endfunction
