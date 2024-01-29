import Cocoa

for i in 1...100 {
    if (i.isMultiple(of: 3) && !i.isMultiple(of: 5)){
        print("Fizz")
    }
    else if (!i.isMultiple(of: 3) && i.isMultiple(of: 5)){
        print("Buzz")
    }
    else if (i.isMultiple(of: 3) && i.isMultiple(of: 5)){
        print("FizzBuzz")
    }
    else {
        print(i)
    }
}
