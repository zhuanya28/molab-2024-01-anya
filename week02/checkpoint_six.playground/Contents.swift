import Cocoa

struct Car {
    var model: String
    var numberOfSeats: Int
    private(set) var currentGear: Int
    init(model: String, numberOfSeats: Int, currentGear: Int = 0) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.currentGear = currentGear
    }


    mutating func changeGear(to newGear: Int) {
        if newGear >= -1 && newGear <= 6 {
            currentGear = newGear
            print("Changed gear to \(currentGear)")
        } else {
            print("Invalid gear")
        }
    }
}

var myCar = Car(model: "Sedan", numberOfSeats: 5)
print(myCar)  // Output: Car(model: "Sedan", numberOfSeats: 5, currentGear: 0)

myCar.changeGear(to: 1)  // Output: Changed gear to 1
print(myCar)  // Output: Car(model: "Sedan", numberOfSeats: 5, currentGear: 1)

myCar.changeGear(to: 7)  // Output: Invalid gear
