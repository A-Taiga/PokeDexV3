//
//  PokeData.swift
//  PokedexV3
//
//  Created by Anthony Polka on 11/27/21.
//

import Foundation
import SwiftUI

class PokeData: ObservableObject {
    @Published var isShowing = false
    @Published var name: String = "Name"
    @Published var picture: String = "photo.fill"
    @Published var type1: String = "Type 1"
    @Published var type2: String = "Type 2"
    @Published var statNames = ["stat1","stat2","stat3","stat4","stat5","stat6"]
    @Published var baseStat = [1,2,3,4,5,6]
    @Published var GrassHpAverage = 0
}




func bgColor(type: String) -> Color {
        
        switch type {
        case "Fire":        return .orange
        case "Water":       return .blue
        case "Grass":       return .green
        case "Electric":    return .yellow
        case "Ice":         return .white
        case "Fighting":    return .red
        case "Poison":      return .purple
        case "Ground":      return Color(#colorLiteral(red: 0.879588604, green: 0.7522209883, blue: 0.4093023837, alpha: 1))
        case "Flying":      return Color(#colorLiteral(red: 0.6583806276, green: 0.5652744174, blue: 0.9423617721, alpha: 1))
        case "Psychic":     return Color(#colorLiteral(red: 0.9693282247, green: 0.3442759514, blue: 0.5365843773, alpha: 1))
        case "Bug":         return Color(#colorLiteral(red: 0.6583272815, green: 0.7236508727, blue: 0.1330786049, alpha: 1))
        case "Rock":        return Color(#colorLiteral(red: 0.7212278247, green: 0.6280249953, blue: 0.2156865001, alpha: 1))
        case "Ghost":       return Color(#colorLiteral(red: 0.4427575171, green: 0.3452770412, blue: 0.5963467956, alpha: 1))
        case "Dark":        return Color(#colorLiteral(red: 0.438151896, green: 0.3454767466, blue: 0.2814534009, alpha: 1))
        case "Dragon":      return Color(#colorLiteral(red: 0.4362769723, green: 0.2203088105, blue: 0.9697752595, alpha: 1))
        case "Steel":       return Color(#colorLiteral(red: 0.7214977145, green: 0.7216224074, blue: 0.8155884147, alpha: 1))
        case "Fairy":       return Color(#colorLiteral(red: 0.9409546256, green: 0.7124720216, blue: 0.7388827205, alpha: 1))
        case "Normal":      return Color(#colorLiteral(red: 0.6587551236, green: 0.6588653326, blue: 0.4738197923, alpha: 1))
        default:            return .white
          
        }
    }
