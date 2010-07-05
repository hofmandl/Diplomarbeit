function wc=worstcase()

r=0.05;
mu=0.2;
sigma=0.4;
M=5000;

n=1000; % Anzahl der Schritte
T=10; % Zeithorizont
h=T/n; % Schrittweite

p=2; (mu-r)/sigma^2;
crashtimes=[1,2,3]
% das zu den Crashzeiten gehörige Endvermögen
ErwartetesEndvermoegen=zeros(1,length(crashtimes))
t = [10,20,30,40,50,60,70,80,90]
w=zeros(1,length(t));


% für alle crashzeiten
for k=1:(length(t))
	% Berechne mit einer Montecarlosimulation das erwartete Endvemögen bei crash in t
    % simultane Erzeugung der Brownschen Bewegung für m Pfade
	dW=sqrt(h)*randn(n,M);
	% simultane Berechnung des Vermögens
	X=zeros(1+n,M);
	X(1,:)=1;
	for j = 1:n
		X(j+1,:)=X(j,:).*(1+(r+p*(mu-r))*h + p*sigma*dW(j,:));
	end
    X;
    %Berechnung des Schätzers
    w(k)=(sum(v(h*t(k),X(t(k),:))))/M;
end
w
endfunction

