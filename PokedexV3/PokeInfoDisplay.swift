//
//  PokeInfoDisplay.swift
//  PokedexV3
//
//  Created by Anthony Polka on 11/27/21.
//

import SwiftUI



struct PokeInfoDisplay: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var pokeData: PokeData
    @State private var selectedView = 0
    var body: some View {
        ZStack{
            Rectangle()
                 .clipShape(CustomShape())
                 .foregroundColor(.white)
                 .shadow(radius: 10)
                 .ignoresSafeArea()
            GeometryReader { geo in
                VStack{
                    HStack {
                    
                VStack(alignment:.leading){
                    Text(pokeData.name)
                        .font(.system(size: 50))
                    Text(pokeData.type1 + " / " + pokeData.type2)
                        .font(.system(size: 30))
                    }
                        Spacer()
                }
                    HStack {
                        Spacer()
                    AsyncImage(url: URL(string: pokeData.picture)) { image in
                        image.resizable()
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)
                   
                            } placeholder: {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .shadow(radius: 10)
                                   
                            }
                        
                        Spacer()
                    }
                    //MARK: View Picker
                               Picker("Favorite Color", selection: $selectedView, content: {
                                   Text("Stats").tag(0)
                                   Text("Moves").tag(1)
                               })
                               .pickerStyle(SegmentedPickerStyle())
                               .padding()
                    HStack {
                        VStack(alignment: .leading) {
                            ForEach(0..<5, id: \.self) { i in
                                Text(pokeData.statNames[i])
                                    .padding(0.5)
                            }
                        }
                        VStack(alignment: .leading) {
                            ForEach(0..<5, id: \.self) { i in
                                Text("\(pokeData.baseStat[i])")
                                    .padding(0.5)
                            }
                        }
                        VStack(alignment: .leading) {
                            ForEach(0..<5, id: \.self) { i in
                                Rectangle()
                                    .frame(width: 200, height: 15)
                                    .cornerRadius(10)
                                    .foregroundColor(.clear)
                                    .overlay(
                                        ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black)
                                            HStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                    .fill(bgColor(type: pokeData.type1))
                                               
                                                .frame(width: CGFloat(pokeData.baseStat[i]))
                                                Spacer()
                                            }
                                        }
                                    )
                                    .padding(3)
                            }
                        }
                    }
                }
            }
        }
        .background(bgColor(type: pokeData.type1))
        
    }
}

struct BottomView<Content:View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
    }
}


struct PokeInfoDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PokeInfoDisplay().environmentObject(PokeData())
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: 30))
        path.addArc(center: CGPoint(x: 30 ,y: 250),
                    radius: 30,
                    startAngle: Angle(degrees: -180),
                    endAngle: Angle(degrees: -90),
                    clockwise: false)
        path.addArc(center: CGPoint(x: rect.maxX - 30 ,y: 250),
                    radius: 30,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: -0),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path
    }
}
