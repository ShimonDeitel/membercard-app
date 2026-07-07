import Foundation

struct Membership: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var membershipName: String
    var fee: String
    var renewalDate: String
}
