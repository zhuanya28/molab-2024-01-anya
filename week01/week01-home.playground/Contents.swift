//import UIKit
////
//////working on Jan 24
////// start: 12:30pm
////
//var myVariable = 42
//myVariable = 50
//let myConstant = 42
//
//let explicitFloat: Float = 4
//
//let label = "The width is "
//let width = 94
//
////making integer into the width
//var widthLabel = label + String(width)
//
////exercise
//widthLabel = "The width is \(width)."
//print(widthLabel)
//
//
////excercise
//var floatingNumber1: Float = 4
//var floatingNumber2: Float = 16.4
//let greetingExcercise = "Hi! My name is Rahma and I am \(floatingNumber1 + floatingNumber2) years old."
//
//let quotation = """
//        Even though there's whitespace to the left,
//        the actual lines aren't indented.
//            Except for this line.
//        Double quotes (") can appear without being escaped.
//
//        I still have \(floatingNumber1 + floatingNumber2) pieces of fruit.
//        """
//print(quotation);
//
//var fruits = ["strawberries", "limes", "tangerines"]
//fruits[1] = "grapes"
//
//
//var occupations = [
//    "Malcolm": "Captain",
//    "Kaylee": "Mechanic",
// ]
//occupations["Jayne"] = "Public Relations"
//fruits.append("blueberries")
//print(fruits)
//// Prints "["strawberries", "grapes", "tangerines", "blueberries"]"
//fruits = []
//occupations = [:]

//stop: 2:00pm
//note: revise the arrays!

//: Creating random pattern from string


import Foundation

// swift must use index to access parts of string

//  let str = "/\\"
let str = "🟥🟩🟨🌑"
//let str = "▪️▪️🌑"
//  print("str", str)
//  print("str.count", str.count)
//  print("str offset 1", str[str.index(str.startIndex, offsetBy: 1)])

func charAt(_ str:String, _ offset:Int) -> String {
    let index = str.index(str.startIndex, offsetBy: offset)
    let char = str[index]
    return String(char)
}

//  print(charAt(str, 0))

let randomInt = Int.random(in: 0..<str.count)
//  print("randomInt", randomInt)

//  var nstr = ""
//  for _ in 0..<6 {
//    let randomInt = Int.random(in: 0..<str.count)
//    // print(index, "randomInt", randomInt)
//    nstr += charAt(str, randomInt)
//  }
//  print("nstr", nstr)

func generateLine(_ n:Int) {
    var nstr = ""
    for _ in 0..<n {
        let randomInt = Int.random(in: 0..<str.count)
        // print(index, "randomInt", randomInt)
        nstr += charAt(str, randomInt)
    }
    print(nstr)
}

//  generateLine(10)

func generateBlock(_ n: Int) {
    for _ in 0..<n {
        generateLine(n)
    }
}

generateBlock(5)
print("")
generateBlock(5)
print("")
generateBlock(5)
