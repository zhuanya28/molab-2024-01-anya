import Cocoa

func getRandomNumber(from numbers: [Int]?) -> Int {
    return (numbers ?? []).isEmpty ? Int.random(in: 1...100) : numbers!.randomElement()!
}
