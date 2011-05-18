data pressure_drop;
input x1 x2 x3 x4 y;
cards;
2.14	10	0.34	1	28.9
4.14	10	0.34	1	31
8.15	10	0.34	1	26.4
2.14	10	0.34	0.246	27.2
4.14	10	0.34	0.379	26.1
8.15	10	0.34	0.474	23.2
2.14	10	0.34	0.141	19.7
4.14	10	0.34	0.234	22.1
8.15	10	0.34	0.311	22.8
2.14	10	0.34	0.076	29.2
4.14	10	0.34	0.132	23.6
8.15	10	0.34	0.184	23.6
2.14	2.63	0.34	0.679	24.2
4.14	2.63	0.34	0.804	22.1
8.15	2.63	0.34	0.89	20.9
2.14	2.63	0.34	0.514	17.6
4.14	2.63	0.34	0.672	15.7
8.15	2.63	0.34	0.801	15.8
2.14	2.63	0.34	0.346	14
4.14	2.63	0.34	0.506	17.1
8.15	2.63	0.34	0.669	18.3
2.14	2.63	0.34	1	33.8
4.14	2.63	0.34	1	31.7
8.15	2.63	0.34	1	28.1
5.6	1.25	0.34	0.848	18.1
5.6	1.25	0.34	0.737	16.5
5.6	1.25	0.34	0.651	15.4
5.6	1.25	0.34	0.554	15
4.3	2.63	0.34	0.748	19.1
4.3	2.63	0.34	0.682	16.2
4.3	2.63	0.34	0.524	16.3
4.3	2.63	0.34	0.472	15.8
4.3	2.63	0.34	0.398	15.4
5.6	10.1	0.25	0.789	19.2
5.6	10.1	0.25	0.677	8.4
5.6	10.1	0.25	0.59	15
5.6	10.1	0.25	0.523	12
5.6	10.1	0.34	0.789	21.9
5.6	10.1	0.34	0.677	21.3
5.6	10.1	0.34	0.59	21.6
5.6	10.1	0.34	0.523	19.8
4.3	10.1	0.34	0.741	21.6
4.3	10.1	0.34	0.617	17.3
4.3	10.1	0.34	0.524	20
4.3	10.1	0.34	0.457	18.6
2.4	10.1	0.34	0.615	22.1
2.4	10.1	0.34	0.473	14.7
2.4	10.1	0.34	0.381	15.8
2.4	10.1	0.34	0.32	13.2
5.6	10.1	0.55	0.789	30.8
5.6	10.1	0.55	0.677	27.5
5.6	10.1	0.55	0.59	25.2
5.6	10.1	0.55	0.523	22.8
2.14	112	0.34	0.68	41.7
4.14	112	0.34	0.803	33.7
8.15	112	0.34	0.889	29.7
2.14	112	0.34	0.514	41.8
4.14	112	0.34	0.672	37.1
8.15	112	0.34	0.801	40.1
2.14	112	0.34	0.306	42.7
4.14	112	0.34	0.506	48.6
8.15	112	0.34	0.668	42.4

proc print data =  pressure_drop;
run; 

proc reg data =  pressure_drop;
model y = x1 x2 x3 x4 / selection = cp best = 10;
run;

proc reg;
model y = x1 x2 x3 x4 / selection = adjrsq best = 10;
run;


proc reg OUTEST=my_res PRESS;
model y = x1 x2 x3 x4 /PRESS;
plot rstudent.*(predicted. x1 x2 x3 x4);
plot npp.*rstudent.;
run;


proc reg OUTEST=my_res data=pressure_drop;
model y = x1 x2 x3 x4 /PRESS vif collin;
run;

proc reg OUTEST=my_res data=pressure_drop;
model y = x2 x3 x4 /PRESS vif collin;
run;

proc reg OUTEST=my_res data=pressure_drop;
model y = x2 x3 /PRESS vif collin;
run;


proc reg OUTEST=my_res PRESS data=	pressure_drop;
model y = x1 x2 x3 x4 /vif;
plot rstudent.*(predicted. x1 x2 x3 x4);
plot npp.*rstudent.;
run;


proc reg OUTEST=my_res2 PRESS data=	pressure_drop;
model y = x2 x3 /PRESS corrb vif collin;
plot rstudent.*(predicted. x2 x3);
plot npp.*rstudent.;
run;

proc print data =  my_res;
run;

proc print data =  my_res2;
run; 
 
