//
//  PokedexV3App.swift
//  PokedexV3
//
//  Created by Anthony Polka on 11/26/21.
//

import SwiftUI

@main
struct PokedexV3App: App {
    @StateObject var pokeData = PokeData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(pokeData)
        }
    }
}
