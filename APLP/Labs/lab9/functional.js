var foldl = function (f, acc, array) {
	if (array.length === 0)
	{
		return acc;
	}
	else
	{
		acc = f (acc , array[0]);
		return (foldl (f , acc , array.slice(1)));
	}
}

console.log(foldl(function(x,y){return x+y}, 0, [1,2,3]));



var foldr = function (f, z, array) {
	if (array.length === 0)
	{
		return z;
	}
	else
	{
		acc = f (array[array.length-1] , z);
		return (foldr (f , acc , array.slice(0,array.length-1)))
	}
}

console.log(foldr(function(x,y){return x/y}, 1, [2,4,8]));

var map = function (f, array) {
	if (array.length === 0)
	{
		return [];
	}
	else
	{	
		var arr = [f (array[0])];
		if (array.length === 1)
		{
			return arr
		}
		else
		{
			return (arr.concat(map (f , array.slice(1))));
		}
		
	}
	
}

console.log(map(function(x){return x+x}, [1,2,3,5,7,9,11,13]));


// // Write a curry function as we discussed in class.

Function.prototype.curry = function() {
  var slice = Array.prototype.slice,
      args = slice.apply(arguments),
      that = this;
  return function () {
    return that.apply(null, args.concat(slice.apply(arguments)));
  };
};

var mult = function (a,b){
	return (a*b);
} 

var double = mult.curry(2);
console.log(double(4))

// // Create a `double` method using the curry function
// // and the following `mult` function.
// function mult(x,y) {
//   return x * y;
// }


function Student (firstName , lastName , studentID)
{
	this.firstName = firstName;
	this.lastName = lastName;
	this.studentID = studentID;
	this.display = function (){
		console.log(this.firstName + " " + this.lastName + " " + this.studentID)
	}
}

var arrayOfStudents = [ new Student('Parth' , 'Jain' , 123) , new Student('Sakshi' , 'Jain' , 456)];
arrayOfStudents[1].graduated = 'yes'

arrayOfStudents[0].display();
arrayOfStudents[1].display();

var s = {firstName: "abc" , lastName: "efg", studentID : 789};

s.__proto__ = arrayOfStudents[0];
s.display();