syntax rotate = function (ctx) {
var inCtx = ctx.contextify(ctx.next().value);
var result = #``;
var stx;
var flag = 0;
var prvs;
var tmp;
result = result.concat(#`var tmp;`); 
for (stx of inCtx) {
if (flag == 0){
tmp = stx
prvs = stx
result = result.concat(
#`tmp = ${stx};`);
flag = 1;
}
else{
result = result.concat(
#`${prvs} = ${stx};`);
prvs = stx
}
inCtx.next(); // Eating comma
}
result = result.concat(
#`${prvs} = tmp;`);
return result;
}
var a = 1; var b = 2; var c = 3; var d = 4;
rotate(a, b, c, d);
console.log("a:"+a+" b:"+b+" c:"+c+" d:"+d);