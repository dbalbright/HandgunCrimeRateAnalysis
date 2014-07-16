* Histogram for the handguncrimesrate samples.You have to calculate the SD's from the mean for the labels it seems

histogram handguncrimesrate, freq normal xaxis(1 2) ylabel(0(10)60, grid)  xlabel(1.35609 "mean" .216357 "-1 s.d." 2.49582 "+1 s.d." 3.63556 "+2 s.d." 4.77529 "+3 s.d." 5.91502 "+4 s.d.", axis(2) grid gmax) xtitle("", axis(2)) subtitle("Handgun Crimes by Tennessee Counties 2001-2010") note("Source:  Tennessee Bureau of Investigation")


* The same regression but with labels to help identify those outliers (Memphis, Nashville). Because it seems you can't label a datapoint with multiple variables, we first generate one with the two we want to show: county and year.

gen countyyear = county + "(" + string(year) + ")"

graph twoway (lfitci handguncrimes permits) (scatter handguncrimes permits, mlabel(countyyear) msymbol(+) title("Handgun Crimes Regressed on Handgun Permits") ytitle("Handgun Crimes")) (scatter handguncrimes permits [w=popdns], msymbol(Oh)), legend(off)


* Uses population as a weight which is shown in the size of the data points in the scatterplot

scatter handguncrimesrate permits [w=population],  msymbol(Oh) note("Source: Tennessee Bureau of Investigation, Tennessee Department of Safety") || lfit handguncrimesrate permits

* We couldn't plot a line graph of the entire state from the data except by using the collapse command which changes your data structure. Had I figured it out before class it would have looked like this:

collapse (mean) handguncrimes drugviolations, by(year)
line handguncrimes drugviolations year, c(L)


* Simple bar graph showing the jump in gun permits in 2009-2010 from 2008.

graph bar permits, over(year) nofill


* Matrix graph that you liked so much. Shows the regression of all variables on each other.

graph matrix handguncrimesrate permits popdns unemploymentrate personalincomepercapita dry drugviolationsrate


* To get the "four-up" combined combination graph, create each one and designate a name for each. Then combine them with the last command.

graph twoway (scatter handguncrimesrate permits) (lfitci handguncrimesrate permits), legend(off) name(permits) ytitle("Handgun Crime Rate")
graph twoway (scatter handguncrimesrate popdns) (lfitci handguncrimesrate popdns), legend(off) name(popdns) ytitle("Handgun Crime Rate")
graph twoway (scatter handguncrimesrate drugviolationsrate) (lfitci handguncrimesrate drugviolationsrate), legend(off) ytitle("Handgun Crime Rate") name(drugviolationsrate)
graph twoway (scatter handguncrimesrate personalincomepercapita) (lfitci handguncrimesrate personalincomepercapita), legend(off) ytitle("Handgun Crime Rate") name(personalincomepercapita)
graph combine permits popdns drugviolationsrate personalincomepercapita


* OR ALTERNATELY:

foreach x of varlist permits popdns drugviolationsrate personalincomepercapita {
	graph twoway (scatter handguncrimesrate `x') (lfitci handguncrimesrate `x'), legend(off) name(`x') ytitle("Handgun Crime Rate")
	}
graph combine permits popdns drugviolationsrate personalincomepercapita