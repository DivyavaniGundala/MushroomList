struct MushroomModel: Codable {
    let mushrooms: [Mushroom]
}

// MARK: - Mushroom
struct Mushroom: Identifiable, Codable {
    let id, name, latinName, profilePicture: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case latinName = "latin_name"
        case profilePicture = "profile_picture"
    }
}
