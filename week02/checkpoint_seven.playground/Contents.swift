class Animal {
    var legs: Int

    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Usual dog barking")
    }
}

class Cat: Animal {
    var isTame: Bool

    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }

    func speak() {
        print("Usual cat meowing")
    }
}

class Wolf: Dog {
    override func speak() {
        print("Wolf barking: Woof! Woof!")
    }
}

class Doberman: Dog {
    override func speak() {
        print("Doberman barking: Woof! Woof!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Persian cat meowing: Meow! Meow!")
    }
}

class Tiger: Cat {
    override func speak() {
        print("Tiger roaring: Roar! Roar!")
    }
}


let myTiger = Tiger(legs: 4, isTame: false)
myTiger.speak()
print("Number of legs: \(myTiger.legs)")

let myPersian = Persian(legs: 4, isTame: true)
myPersian.speak()
print("Number of legs: \(myPersian.legs), Is Tame: \(myPersian.isTame)")

