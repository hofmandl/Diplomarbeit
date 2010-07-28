% globale Marktparameter
global r=0.05 mu=0.2 sigma=0.4 k=0.2;
global T=10;

printf("Erwarteter Nutzen aus reiner Bondtrategie\n");
r*T

function wert=vlog(t,x)
global mu r sigma T;
wert=log(x)+(r+0.5*(mu-r)^2/sigma^2)*(10-t);
endfunction

printf("Erwarteter Nutzen aus optimaler Strategie im crashfreien Scenario\n");
@vlog(0,1)

function p=pstern(t)
global mu r sigma k;
p= (mu-r)/sigma^2;
endfunction

%Löser für die Differentialgleichung
%Bischen rumgetrickse um aus Anfangswertbedingung Endwertbedingung zu machen
function pdot = pd(x, t)
	global mu r sigma k;
    pdot=sigma^2*(1-x*k)*(x-pstern(0))^2/(2*k);
endfunction
function [t,y] = pidach(T1)
t = linspace (-T1, 0, 100);
y = lsode ("pd", 0, t);
t=-fliplr(t);
y=y(end:-1:1);
endfunction

% Lösung der Differentialgleichung
[t,y]=pidach(10);

% In Funktion umgewandelt
pidachf = @(x) interp1 (t,y,x);

% Ausgabe der Lösung der Differentialgleichung
plot(t,y);
print -deps foo.eps

%verschiedene Methoden zum Berechen der Worst-Case-Schranke beim optimalen Portfolio
printf("Berechnen der worst-case-bound bei sofortigem Absturz\n");
vlog(0,1-y(1)*k)

printf("Und berechnen der worst-case-bound ohne Crash\n");

function y=f(p)
global mu r sigma;
y=(mu-r)*p.-0.5*p.^2*sigma^2;
endfunction

integrant= @(x) f(pidachf(x));
quadl(integrant,0,10) + r*10


% Illustration der Funktion worstcase
p0=@(t) 0;
printf("Berechnen der Worstcaseschranke von p0\n");
[a,b,wc]=worstcase(@vlog,p0,[0,2,5,8,10])

printf("Berechnen der Worstcaseschranke von pstern\n");
[a,b,wc]=worstcase(@vlog,@pstern,[0,2,5,8,10])

printf("Berechnen der Worstcaseschranke von pdach\n");
[a,b,wc]=worstcase(@vlog,pidachf,[0,2,5,8,10])


% --------------------------------------------------------------------------------------------------
printf("Berechnen der besten linearen Strategie\n");
s=0.7:0.1:1.3; % alle zu checkenden startwerte
zaehler=1:(length(s));
worst_case_schranken=zeros(1,length(s)); % zum speichern der Worst-Case-Schranken

% für alle möglichen Startwerte
for z=zaehler
	% konstruiere zugehörige Strategie
	funk = @(x) interp1 ([0,10],[s(z),0],x);
	% berechne worst-case-schranke
	[a,b,wc]=worstcase(@vlog,funk,[0,3,5,8,10]);
    % und speichere sie ab
    worst_case_schranken(z)=wc;
end

% optimaler Startpunkt
opts=s(find(worst_case_schranken==max(worst_case_schranken)))
%dazugehörige optimale Strategie
optlinear = @(x) interp1 ([0,10],[opts,0],x);

printf("Startwerte\n");
s
printf("Worst-Case-Schranken\n");
worst_case_schranken

% geplotteter Vergleich zwischen optimaler und optimaler linearer Strategie
t=0:0.1:10;
plot(t,pidachf(t),t,optlinear(t))
print -deps bar.eps




