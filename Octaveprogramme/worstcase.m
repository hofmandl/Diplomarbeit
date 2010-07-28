function [w,g,wc]=worstcase(v,p,times)
global mu r sigma k;
% Anzahl der Simulation bei der Monte-Carlo-Simulation
M=10000; 

n=1000; % Anzahl der Schritte
T=10; % Zeithorizont
h=T/n; % Schrittweite

w=zeros(1,length(times));

% f�r alle crashzeiten den erwarteten Nutzen berechen
for a=1:(length(times))
    % simultane Erzeugung der Brownschen Bewegung f�r m Pfade
	dW=sqrt(h)*randn(n,M);
	% simultane Berechnung des Verm�gens
	X=zeros(1+n,M);
	X(1,:)=1;
	for j = 1:n
		X(j+1,:)=X(j,:).*(1+(r+p(step2time(j,T,n))*(mu-r))*h...
		 + p(step2time(j,T,n))*sigma*dW(j,:));
	end
    %Berechnung des Sch�tzers des Endverm�gens
    % bei Crash in times(a)
    w(a)=(sum(v(times(a),X(time2step(times(a),T,n),:)...
    	*(1-p(times(a))*k))))/M;
end

% den erwarteten Nutzen ohne Crash berechnen
dW=sqrt(h)*randn(n,M);
	% simultane Berechnung des Verm�gens
	X=zeros(1+n,M);
	X(1,:)=1;
	for j = 1:n
		X(j+1,:)=X(j,:).*(1+(r+p(step2time(j,T,n))*(mu-r))*h...
		 + p(step2time(j,T,n))*sigma*dW(j,:));
	end
% Berechnung des Sch�tzers
g=(sum(v(T,X(1000,:))))/M;

% das Minimum von allen nehmen
wc=min( [w,g]);
endfunction

function t=step2time(n,T,steps)
t = n*T/steps;
endfunction

function n=time2step(t,T,steps)
n = ceil(t*steps/T)+1;
endfunction
