//
//  ContentView.swift
//  PokedexV3
//
//  Created by Anthony Polka on 11/26/21.
//

import SwiftUI

struct ContentView: View {
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @EnvironmentObject var pokeData: PokeData
    @State private var pokemonData = [APIInfo]()
    @State private var searchText: String = ""
    @State private var filtertypes: String = ""
    @State private var textFieldId: String = UUID().uuidString // To hidekeyboard when tapped outside textFields
    var stuff = ["Normal", "Fire", "Water", "Grass", "Electric", "Ice", "Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug", "Rock", "Ghost", "Dark", "Dragon", "Steel", "Fairy"]
    
    var searchResults: [APIInfo] {
        
        if filtertypes.isEmpty == false && searchText.isEmpty {
            return pokemonData.filter { $0.types[0].type.name.contains(filtertypes.lowercased())}
        } else if searchText.isEmpty == false && filtertypes.isEmpty {
            return pokemonData.filter { $0.name.contains(searchText.lowercased())}
        } else {
            return pokemonData
        }
    }
    var body: some View {
        
        
        ZStack {
            VStack {
                HStack {
                TextField("Search", text: $searchText)
                    .font(.system(size: 25))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                    .background(.white)
                    .cornerRadius(20)
                    .id(textFieldId)
                    .onTapGesture {}
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke()
                    )
                    Menu {
                        ForEach(stuff, id: \.self) { i in
                            Button(i, action: {filtertypes = i})
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture { // whenever tapped within VStack
                                textFieldId = UUID().uuidString
                               //^ this will remake the textfields hence loosing keyboard focus!
                            }
         
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(searchResults, id: \.id) { pokemon in
                    Button(action: {
                        for _ in 0..<pokemonData.count{
                            if pokemon.types[0].type.name == "grass" {
                            }
                        }
                        pokeData.statNames.removeAll()
                        pokeData.baseStat.removeAll()
                        
                        for i in 0...5 {
                            
                            pokeData.statNames.append(pokemon.stats[i].stat.name)
                            pokeData.baseStat.append(pokemon.stats[i].base_stat)
                        }
                        pokeData.isShowing.toggle()
                        pokeData.name = pokemon.name.firstUppercased
                        if pokemon.types.count == 2 {
                            pokeData.type1 = pokemon.types[0].type.name.firstUppercased
                            pokeData.type2 = pokemon.types[1].type.name.firstUppercased
                        } else {
                            pokeData.type1 = pokemon.types[0].type.name.firstUppercased
                        }
                      
                        pokeData.picture = pokemon.sprites.other.art.front_default ?? "photo.fill"
                    }) {
                        PokemonSquare(name: pokemon.name, picture: pokemon.sprites.other.art.front_default ?? "", bgColor: bgColor(type: pokemon.types[0].type.name.firstUppercased))
                        
                    }
                    .padding(.top, 5)
                    .foregroundColor(.black)
                    .searchable(text: $filtertypes)
                    .searchable(text: $searchText)
                    
                }
            }
        }
        }
          
        .sheet(isPresented: $pokeData.isShowing) {
                    PokeInfoDisplay()
                }
        .onAppear() {
            Data().fetchName { (results) in
                for i in results.indices {
                    Data().fetchInfo(link: results[i].url, completion: { names in
                        self.pokemonData.append(names)
                    })
                }
            }
        }
    }
 
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PokeData())
    }
}
extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
