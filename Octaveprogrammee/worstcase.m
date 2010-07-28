function [w,g,wc]=worstcase(v,p,times)
global mu r sigma k;
M=10000; % Anzahl der Simulation bei der Monte-Carlo-Simulation

n=1000; % Anzahl der Schritte
T=10; % Zeithorizont
h=T/n; % Schrittweite

w=zeros(1,length(times));

% für alle crashzeiten den erwarteten Nutzen berechen
for a=1:(length(times))
	% Berechne mit einer Montecarlosimulation das erwartete Endvemögen bei crash in t
    % simultane Erzeugung der Brownschen Bewegung für m Pfade
	dW=sqrt(h)*randn(n,M);
	% simultane Berechnung des Vermögens
	X=zeros(1+n,M);
	X(1,:)=1;
	for j = 1:n
		X(j+1,:)=X(j,:).*(1+(r+p(step2time(j,T,n))*(mu-r))*h + p(step2time(j,T,n))*sigma*dW(j,:));
	end
    %Berechnung des Schätzers
    w(a)=(sum(v(times(a),X(time2step(times(a),T,n),:)*(1-p(times(a))*k))))/M;
end

% den erwarteten Nutzen ohne Crash berechnen
dW=sqrt(h)*randn(n,M);
	% simultane Berechnung des Vermögens
	X=zeros(1+n,M);
	X(1,:)=1;
	for j = 1:n
		X(j+1,:)=X(j,:).*(1+(r+p(step2time(j,T,n))*(mu-r))*h + p(step2time(j,T,n))*sigma*dW(j,:));
	end
% Berechnung des Schätzers
g=(sum(v(T,X(1000,:))))/M;chnun

% das Minimum von allen nehmen
wc=min( [w,g]);
endfunction

function t=step2time(n,T,steps)
t = n*T/steps;
endfunction

function n=time2step(t,T,steps)
n = ceil(t*steps/T)+1;
endfunction
