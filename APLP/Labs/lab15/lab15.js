let roHandler = {
deleteProperty: function(t, prop) { console.log("This property is deleted"); return true;},
set: function(t, prop, val, rcvr) { console.log("The property is setted"); return true;},
has: function(t,prop) {console.log("The property is checked"); return true;},
get: function(t,prop,rcvr) {console.log("The property is called"); return t[prop];},
apply: function(t,thisArg,argumentsList) {console.log("Applied used"); return t.apply;},
construct: function(t,argumentsList,newTarget) {console.log("Construct used")},
setPrototypeOf: function(t,p) {console.log("The property is set to protoype"); return true; } };
var constantVals = {
pi: 3.14,
e: 2.718,
goldenRatio: 1.30357 };
var p = new Proxy(constantVals, roHandler);
//console.log(p.pi);
delete p.pi;
//console.log(p.pi);
p.pi = 3;
//console.log(p.pi);
p.pi in p;
//console.log(p.pi)
var x = p.pi;
// console.log(x);
