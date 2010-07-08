
%alle zu checkenden startwerte
s=0.7:0.1:1.1
zaehler=1:(length(s))
worst_case_schranken=zeros(1,length(s))

% für alle möglichen Startwerte
for z=zaehler
	printf("erster schleifendurchlauf");
	funk = @(x) interp1 ([0,10],[s(z),0],x);
	x=1:10;
    plot(x,funk(x))
	[a,b,wc]=worstcase(@vlog,funk);
    w(z)=wc
end
wc
opts=s(find(w==max(w)))

optlinear = @(x) interp1 ([0,10],[opts,0],x);

t=0:0.1:10;
plot(t,pidachf(t),t,optlinear(t))

