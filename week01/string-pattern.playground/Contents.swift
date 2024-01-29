//: Creating random pattern from string

import Foundation


//let str = "0 | | / / "
let str = "||//\\"

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

func generateLine(_ colums:Int) -> String {
    var nstr = ""
    for _ in 0..<colums {
        let randomInt = Int.random(in: 0..<str.count)
        // print(index, "randomInt", randomInt)
        nstr += charAt(str, randomInt)
    }
    return nstr
}

//  generateLine(10)

func generateBlock(_ rows: Int, _ colums: Int ) -> String {
    var block = ""
    for _ in 0..<rows {
        let line = generateLine(colums)
        block += line + "\n"
    }
    return block
}
let block1 = generateBlock(10, 20)
//let block2 = generateBlock(10)
//let block3 = generateBlock(10)
//let block4 = generateBlock(10)

print(block1)

//print(block2)
//
//print(block3)
//
//print(block4)
