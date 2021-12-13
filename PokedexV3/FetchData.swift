//
//  FetchData.swift
//  PokedexV3
//
//  Created by Anthony Polka on 11/26/21.
//

import Foundation
import CoreData

struct NameURL: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Abilities: Codable, Identifiable {
    let id = UUID()
    let ability: NameURL
    let is_hidden: Bool
    let slot: Int
    
    private enum CodingKeys: String, CodingKey {
        case ability
        case is_hidden
        case slot
    }
    
}


struct GameIndices: Codable, Identifiable {
    let id = UUID()
    let game_index: Int
    let version: NameURL
    
    private enum CodingKeys: String, CodingKey {
        case game_index
        case version
    }
}

struct VersionDetails: Codable, Identifiable {
    let id = UUID()
    let rarity: Int
    let version: NameURL
    
    private enum CodingKeys: String, CodingKey {
        case rarity
        case version
    }
}
struct HeldItems: Codable, Identifiable {
    let id = UUID()
    let item: NameURL
    let version_details: [VersionDetails]
    
    private enum CodingKeys: String, CodingKey {
        case item
        case version_details
        
    }
}


struct VersonGroupDetails: Codable, Identifiable {
    let id = UUID()
    let level_learned_at: Int
    let move_learn_method: NameURL
    let version_group: NameURL
    
    private enum CodingKeys: String, CodingKey {
        case level_learned_at
        case move_learn_method
        case version_group
    }
}

struct Moves: Codable, Identifiable {
    let id = UUID()
    let move: NameURL
    let version_group_details: [VersonGroupDetails]
    
    private enum CodingKeys: String, CodingKey {
        case move
        case version_group_details
    }
}


struct Types: Codable, Identifiable {
    let id = UUID()
    let slot: Int
    let type: NameURL
    
    private enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
}
struct PastTypes: Codable, Identifiable {
    let id = UUID()
    let generation: NameURL
    let types: [Types]
    
    private enum CodingKeys: String, CodingKey {
        case generation
        case types
    }
}

struct OfficialArtwork: Codable, Identifiable {
    let id = UUID()
    let front_default: String?
    private enum CodingKeys: String, CodingKey {
        case front_default
    }
}
struct Other: Codable, Identifiable {
    let id = UUID()
    let art: OfficialArtwork
    private enum CodingKeys: String, CodingKey {
     
        case art = "official-artwork"
    }
}
struct Sprites: Codable, Identifiable {
    let id = UUID()
    let other: Other
    
    private enum CodingKeys: String, CodingKey {
        case other
    }
    
}

struct Stats: Codable, Identifiable {
    let id = UUID()
    let base_stat: Int
    let effort: Int
    let stat: NameURL
    
    private enum CodingKeys: String, CodingKey {
        case base_stat
        case effort
        case stat
    }
}
struct APIInfo: Codable, Identifiable {
    let id = UUID()
    let abilities: [Abilities]
    let base_experience: Int
    let forms: [NameURL]
    let game_indices: [GameIndices]
    let height: Int
    let held_items: [HeldItems]
    let ident: Int
    let is_default: Bool
    let location_area_encounters: String
    let moves: [Moves]
    let name: String
    let order: Int
    let past_types: [PastTypes]
    let species: NameURL
    let sprites: Sprites
    let stats: [Stats]
    let types: [Types]
    let weight: Int
    
    private enum CodingKeys: String, CodingKey {
        case abilities
        case base_experience
        case forms
        case game_indices
        case height
        case held_items
        case ident = "id"
        case is_default
        case location_area_encounters
        case moves
        case name
        case order
        case past_types
        case species
        case sprites
        case stats
        case types
        case weight
        
    }
    
}

struct Results: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
struct Link: Codable, Identifiable {
    let id = UUID()
    let results: [Results]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
}
class Data: ObservableObject {
        func fetchName(completion: @escaping ([Results]) -> () ){
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1118") else {return}
                
            URLSession.shared.dataTask(with: url) { data, response, error in
                    let jsonResult = try! JSONDecoder().decode(Link.self, from: data!)
                    DispatchQueue.main.async {
                        completion(jsonResult.results)
                    }
                }.resume()
        }
        func fetchInfo(link: String, completion: @escaping (APIInfo) -> () ){
            
            guard let url = URL(string: link) else {
                print("error")
                return
            }
            URLSession.shared.dataTask(with: url) {data, response, error in
                let jsonResult = try! JSONDecoder().decode(APIInfo.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(jsonResult)
                }
            }.resume()
        }
    }
