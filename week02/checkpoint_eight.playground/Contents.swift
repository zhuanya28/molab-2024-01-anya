
protocol Building {
    var numberOfRooms: Int { get set }
    var cost: Int { get set }
    var estateAgent: String { get set }

    func printSalesSummary()
}


struct House: Building {
    var numberOfRooms: Int
    var cost: Int
    var estateAgent: String

    func printSalesSummary() {
        print("House Summary:")
        print("Number of Rooms: \(numberOfRooms)")
        print("Cost: $\(cost)")
        print("Estate Agent: \(estateAgent)")
    }
}


struct Office: Building {
    var numberOfRooms: Int
    var cost: Int
    var estateAgent: String

    func printSalesSummary() {
        print("Office Summary:")
        print("Number of Rooms: \(numberOfRooms)")
        print("Cost: $\(cost)")
        print("Estate Agent: \(estateAgent)")
    }
}


let myHouse = House(numberOfRooms: 4, cost: 500000, estateAgent: "ABC Realty")
myHouse.printSalesSummary()

let myOffice = Office(numberOfRooms: 10, cost: 1000000, estateAgent: "XYZ Properties")
myOffice.printSalesSummary()
