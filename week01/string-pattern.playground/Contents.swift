//: Creating random pattern from string

import Foundation

// swift must use index to access parts of string

//  let str = "/\\"
let str = "||//abcdefghigklmnopqrstuvwxyz"
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

func generateLine(_ n:Int) -> String {
    var nstr = ""
    for _ in 0..<n {
        let randomInt = Int.random(in: 0..<str.count)
        // print(index, "randomInt", randomInt)
        nstr += charAt(str, randomInt)
    }
    return nstr
}

//  generateLine(10)

func generateBlock(_ n: Int) -> String {
    var block = ""
    for _ in 0..<n {
        let line = generateLine(n)
        block += line + "\n"
    }
    return block
}
let block1 = generateBlock(5)
let block2 = generateBlock(5)
let block3 = generateBlock(5)
let block4 = generateBlock(5)

print(block1)

print(block2)

print(block3)

print(block4)