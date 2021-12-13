//
//  PokemonSquare.swift
//  PokedexV3
//
//  Created by Anthony Polka on 11/26/21.
//

import SwiftUI

struct PokemonSquare: View {
    @EnvironmentObject var pokeData: PokeData
    var name: String
    var picture: String
    var bgColor: Color
    init(name: String = "Name", picture: String = "Picture", bgColor: Color = .white) {
        self.name = name
        self.picture = picture
        self.bgColor = bgColor
    }
  
    var body: some View {
        
        Rectangle()
            .frame(width: 200 - 5, height: 200 - 5)
            .cornerRadius(20)
            .shadow(radius: 10)
            .foregroundColor(bgColor)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
                    .overlay(
                        VStack {
                            AsyncImage(url: URL(string: picture)) { image in
                                image.resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(name)
            
            })
        )
    }
}

struct PokemonSquare_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSquare().environmentObject(PokeData())
    }
}
