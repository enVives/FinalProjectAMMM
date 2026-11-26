/*********************************************
 * OPL 22.2.0.0 Model
 * Author: perej
 * Creation Date: 9 oct 2026 at 22:14:32
 *********************************************/
 
main {
var src = new IloOplModelSource("project.template.mod");
var def = new IloOplModelDefinition(src);
var cplex = new IloCplex();
var model = new IloOplModel(def,cplex);
var data = new IloOplDataSource("project.1.dat");

model.addDataSource(data);
model.generate();

cplex.epgap=0.01;

if (cplex.solve()) {
  
  	model.postProcess();

} else {

    writeln("No solution found");

}


model.end();
data.end();
def.end();
cplex.end();
src.end();
};