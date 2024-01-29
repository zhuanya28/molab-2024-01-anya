import Cocoa
//
//let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
//
//let evenOnly = luckyNumbers.filter{!$0.isMultiple(of: 2)}
////or i could use $0 % 2 == 1
//
//let ascendingOrder = evenOnly.sorted()
//
//let mapped = ascendingOrder.map { "\($0) is a lucky number" }
//print(mapped)

//chatGPT's answer

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let result = luckyNumbers
    .filter { $0 % 2 != 0 } // Filter out even numbers
    .sorted()               // Sort in ascending order
    .map { "\($0) is a lucky number" } // Map to the desired format

// Print the resulting array, one item per line
result.forEach { print($0) }
