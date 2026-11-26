// ** PLEASE ONLY CHANGE THIS FILE WHERE INDICATED **
// In particular, do not change the names of the OPL variables.

int N = ...;
int L = ...;
int U = ...;
int T = ...;

int P[1..N] = ...;
int E[1..N] = ...;

range Nperiods = 1..N;
range Uperiods = 1..U+1;
range Lperiods = 1..L+1;

// Define here your decision variables and
// any other auxiliary OPL variables you need.
// You can run an execute block if needed.

//>>>>>>>>>>>>>>>>

dvar boolean s[Nperiods]; //ON = 1 and OFF = 0
dvar boolean y[Nperiods]; //At which period the machine starts running?
dvar float+ z;
//<<<<<<<<<<<<<<<<

// You can run an execute block if needed.

execute {

//>>>>>>>>>>>>>>>>

writeln("Number of periods: ",N);
writeln("Minimum profit required: ",T);
writeln("Minimum number of ON'S: ", L);
writeln("Maximum number of ON'S: ", U);

var total_energy = "[";
var total_profit = "[";

for(var e = 1; e <= N; e+=1){
  total_energy += E[e]+" ";
}

total_energy = total_energy.substring(0, total_energy.length - 1);
total_energy += "]";


for(var e = 1; e <= N; e+=1){
  total_profit += P[e]+" ";
}

total_profit = total_profit.substring(0, total_profit.length - 1);
total_profit += "]";


      
writeln("Energy of each period: ",total_energy);
writeln("Profit of each period: ",total_profit);
//<<<<<<<<<<<<<<<<

}

minimize  z;// Write here the objective function.

//>>>>>>>>>>>>>>>>
// ...
//<<<<<<<<<<<<<<<<

subject to {

    // Write here the constraints.
    //>>>>>>>>>>>>>>>>
    
    
    //STARTS OF A TASK
    
    y[1] >= s[1] - 0;
    
    // IF s[n-1] = 0 and s[n] = 1 then y[n] = 1
    forall(n in Nperiods : n>1)
      y[n] >= s[n] - s[n-1];
	
	//MINIMUM PROFIT THRESHOLD
    sum(n in Nperiods)
      P[n] * s[n] >= T;
    
    //MAXIMUM NUMBER OF ON'S
    forall(n in Nperiods)
      sum(m in Uperiods: m>=n) //m starts at n
        s[n] <= U;
	
	//MINIMUM NUMBER OF ON'S
	forall(n in Nperiods)
	  sum(m in Lperiods: m>= n)
	    s[m] >= L * y[n]; // the sum of m only matters if we are at the start of a running
	    
	
	//MINIMIXE THE SUM OF ENERGY COST
	
	z >= sum(n in Nperiods) 
		E[n] * s[n];
	
	
    //<<<<<<<<<<<<<<<<
}

// You can run an execute block if needed.

execute {

//>>>>>>>>>>>>>>>>

var total_profit = 0;
var total_energy= 0;

var selected_periods = "[";

for(var p = 1; p <= N; p++){
  selected_periods += s[p]+" ";
}

selected_periods = selected_periods.substring(0, selected_periods.length - 1);
selected_periods += "]";


for(var t = 1; t <= N; t++){
  total_profit += s[t] * P[t];
}

for(var e = 1; e<= N; e++){
  total_energy += s[e] * E[e];
}

writeln("Selected periods: ",selected_periods);
writeln("Total profit: ",total_profit);
writeln("Total energy: ",total_energy);


//<<<<<<<<<<<<<<<<
}
