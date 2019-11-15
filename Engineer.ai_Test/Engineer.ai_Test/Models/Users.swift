
import Foundation
struct Users : Codable {
	let name : String?
	let image : String?
	let items : [String]?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case image = "image"
		case items = "items"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		items = try values.decodeIfPresent([String].self, forKey: .items)
	}

}
