function fizzBuzz(num) {
    for (var i = 0; i <num+1; i++) {
        if (i % 3 === 0 && i % 5 !== 0) {
            console.log("Fizz")
        } else if (i % 5 === 0 && i % 3 !== 0) {
            console.log("Buzz")
        } else if (i % 3 === 0 && i % 5 === 0) {
            console.log("Fizz Buzz")
        } else {
            console.log(i)
        }
    }
}

fizzBuzz(30)