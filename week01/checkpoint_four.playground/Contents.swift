import Cocoa

enum OutOfBounds: Error {
    case smaller, bigger, nonexistent
}

func mySqrt(_ number: Int) throws -> Int {
    if (number < 1) {throw OutOfBounds.smaller}
    if (number > 10000) {throw OutOfBounds.bigger}
    
    for i in 1...number/2 {
        if (i * i == number){
            return i
        }
    }
    
    throw OutOfBounds.nonexistent
}

let number = 16

do {
    let result = try mySqrt(number)
    print("Square root of the number is: \(result)")
}catch OutOfBounds.smaller {
    print("Please provide a number bigger than 1.")
} catch OutOfBounds.bigger {
    print("Please provide a number smaller than 10,000.")
} catch OutOfBounds.nonexistent{
    print("The number has no square root.")
}

