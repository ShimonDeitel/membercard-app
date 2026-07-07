import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 8

    @Published var items: [Membership] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("membercard_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Membership) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Membership) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Membership) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Membership].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [Membership] {
        [
        Membership(date: Date().addingTimeInterval(-86400), membershipName: "Fit24 Gym", fee: "39.99", renewalDate: "5th"),
        Membership(date: Date().addingTimeInterval(-172800), membershipName: "Climbing Club", fee: "65.00", renewalDate: "12th"),
        Membership(date: Date().addingTimeInterval(-259200), membershipName: "Golf Course", fee: "120.00", renewalDate: "1st")
        ]
    }
}
