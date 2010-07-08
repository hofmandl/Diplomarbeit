% hier sollen einige Aspekte meiner Diplomarbeit nochmal numerschisch verdeutlicht werden

% zunächst definieren wir die globalen Marktparameter
global r=0.05 mu=0.2 sigma=0.4 k=0.2;

T=10;
printf("Wieviel verdient man mit der reinen Bondstartegie?\n");
r*T

function wert=vlog(t,x)
global mu r sigma T;
wert=log(x)+ (r+0.5*(mu-r)^2/sigma^2)*(T-t);
endfunction

printf("Wieviel verdient man mit der optimalen Strategie im crashfreien Scenario?\n");
vlog(0,1)


function y=f(p)
global mu r sigma;
y=(mu-r)*p.-0.5*p.^2*sigma^2;
endfunction




function p=pstern(t)
global mu r sigma k;
p= (mu-r)/sigma^2;
endfunction

function p=p0(t)
p= 2;
endfunction


worstcase(@vlog,@pstern);

T=10
%Löser für die Differentialgleichung
%Bischen rumgetrickse um aus anfangswertbedingung endwertbedingung zu machen
function pdot = pd(x, t)
	global mu r sigma k;
    pdot=sigma^2*(1-x*k)*(x-pstern(0))^2/(2*k);
endfunction
function [t,y] = pidach(T)
t = linspace (-T, 0, 100);
y = lsode ("pd", 0, t);
t=-fliplr(t);
y=y(end:-1:1);
endfunction

% Lösung der Differentialgleichung
[t,y]=pidach(10);

% In Funktion umgewandelt
pidachf = @(x) interp1 (t,y,x);

% plot(t,y);



%verschiedene Methoden zum Berechen der Worstcasebound beim optimalen Portfolio
printf("Berechnen der worst-case-bound bei sofortigem Absturz\n");
vlog(0,1-y(1)*k);

printf("Und berechnen der worst-case-bound ohne Crash\n");
integrant= @(x) f(pidachf(x));
quadl(integrant,0,10) + r*10;

printf("Als nächstes Berechnen wir in mit unser Worst-case-Bound-funktion\n");
% [a,b,wc]=worstcase(@vlog,pidachf);

% betrachten verschiedener worst-case-schranken
p0=@(t) 0;
printf("Berechnen der Worstcaseschranke von p0\n");
% [a,b,wc]=worstcase(@vlog,p0)
printf("Berechnen der Worstcaseschranke von pstern\n");
 [a,b,wc]=worstcase(@vlog,@pstern)

p2=@(t) 2;
printf("Berechnen der Worstcaseschranke von p2\n");
[a,b,wc]=worstcase(@vlog,p2)
