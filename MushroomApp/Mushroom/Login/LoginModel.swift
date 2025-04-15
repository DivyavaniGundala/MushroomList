import SwiftUI

struct LoginModel: Codable {
    let authToken: String
    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
    }
}

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name
        case email
    }
}
