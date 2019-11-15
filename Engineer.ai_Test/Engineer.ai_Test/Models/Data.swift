
import Foundation
struct Data : Codable {
	var users : [Users]?
	var has_more : Bool = true

	enum CodingKeys: String, CodingKey {

		case users = "users"
		case has_more = "has_more"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		users = try values.decodeIfPresent([Users].self, forKey: .users)
		has_more = try values.decodeIfPresent(Bool.self, forKey: .has_more) ?? true
	}

}
