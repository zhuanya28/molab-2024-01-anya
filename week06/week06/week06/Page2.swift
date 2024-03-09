import SwiftUI

struct Quote: Codable {
    let study: [String]
    let life: [String]
    let work: [String]
    let inspiration: [String]
}

class QuoteViewModel: ObservableObject {
    @Published var quotes: Quote?

    init() {
        loadQuotes()
    }

    func loadQuotes() {
        if let path = Bundle.main.path(forResource: "quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                quotes = try decoder.decode(Quote.self, from: data)
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
}

struct Page2: View {
    @StateObject private var quoteViewModel = QuoteViewModel()
    @State private var selectedCategory: String = "study"
    @State private var currentQuote: String = ""

    var body: some View {
        VStack {
            Picker("Select Category", selection: $selectedCategory) {
                Text("Study").tag("study")
                Text("Life").tag("life")
                Text("Work").tag("work")
                Text("Inspiration").tag("inspiration")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Generate Quote") {
                if let categoryQuotes = getCategoryQuotes() {
                    currentQuote = categoryQuotes.randomElement() ?? ""
                }
            }
            .padding()

            Text(currentQuote)
                .font(.headline)
                .padding()
        }
        .onAppear {
            quoteViewModel.loadQuotes()
            currentQuote = getCategoryQuotes()?.first ?? ""
        }
        .navigationTitle("Page 2")
    }

    func getCategoryQuotes() -> [String]? {
        switch selectedCategory {
        case "study":
            return quoteViewModel.quotes?.study
        case "life":
            return quoteViewModel.quotes?.life
        case "work":
            return quoteViewModel.quotes?.work
        case "inspiration":
            return quoteViewModel.quotes?.inspiration
        default:
            return nil
        }
    }
}
