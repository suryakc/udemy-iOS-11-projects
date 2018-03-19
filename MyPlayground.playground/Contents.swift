//: Playground - noun: a place where people can play

/*
 Fibonacci numbers
 */

func printFebonacciNumbers(until: Int) {
    print(0)
    print(1)
    var previousNumber = 0
    var currentNumber = 1
    for _ in 0...until {
        let nextNumber = previousNumber + currentNumber
        print(nextNumber)
        previousNumber = currentNumber
        currentNumber = nextNumber
    }
    
}

printFebonacciNumbers(until: 10)
