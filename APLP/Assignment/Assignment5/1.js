/*
  Provide a function repeat that repeats a given function
  at least once until a given condition is true. 
*/
function repeatUntil(f, cond) {
   f();
    // do
    // {
    //  f(); 
    // }
    // while(cond===true);
}


var r = repeatUntil(function(x) { return x + x }, function(x) { return x >= 20 })
console.log(r(2))