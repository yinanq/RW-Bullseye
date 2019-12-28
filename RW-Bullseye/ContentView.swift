//
//  ContentView.swift
//  RW-Bullseye
//
//  Created by Yinan Qiu on 10/26/19.
//  Copyright © 2019 Yinan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    struct ModColorMain: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
        }
    }
    
    struct ModFontMain: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("AvenirNext-Regular", size: 18))
        }
    }
    
    struct MainTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(ModFontMain())
                .modifier(ModColorMain())
        }
    }
    
    struct NumTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("AvenirNext-DemiBold", size: 36))
                .modifier(ModColorMain())
        }
    }
    
    struct SliderTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("AvenirNext-DemiBold", size: 18))
                .modifier(ModColorMain())
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(MainTextStyle())
                Text("\(target)").modifier(NumTextStyle())
            }
            .frame(width: 480, height: 40, alignment: .center)
            Spacer()
            HStack {
                Text("1")
                    .modifier(SliderTextStyle())
                    .frame(width: 50, height: 30, alignment: .trailing)
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
                    .modifier(SliderTextStyle())
                    .frame(width: 50, height: 30, alignment: .leading)
                
            }
            
            Button(action: {
                print("button hit")
                self.alertIsVisible = true
            }) {
                Text("Boom!").modifier(SliderTextStyle())
            }
            .frame(width: 150, height: 50, alignment: .center)
            .background(Color.accentColor)
            .cornerRadius(50)
            .padding(.top)
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertTitle()), message: Text(
                    "The slider's value is \(sliderValueRoundedInt()).\n" +
                    "You scored \(pointsForCurrentRound()) points this round."), dismissButton: .default(Text("Yay")) {
                        self.score += self.pointsForCurrentRound()
                        self.round += 1
                        self.target = self.randomTarget()
                    })
            }
            
            Spacer()
            HStack {
                NavigationLink(destination: AboutView()) {
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    HStack {
                        Image("InfoIcon")
                        Text("About").modifier(MainTextStyle())
                    }
                }
                Spacer()
                Text("Score:").modifier(MainTextStyle())
                Text("\(score)").modifier(NumTextStyle())
                Spacer()
                Text("Round:").modifier(MainTextStyle())
                Text("\(round)").modifier(NumTextStyle())
                Spacer()
                Button(action: { self.startOver() }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(MainTextStyle())
                    }
                }
            }
            .padding(.bottom)
        }
        .background(Image("Background"))
//        .accentColor(accentColor)
        .navigationBarTitle("Bull's Eye")
    }
    
    func alertTitle() -> String {
        let title: String
        if difference() == 0 {
            title = "Perfect!"
        } else if difference() < 5 {
            title = "You almost had it"
        } else if difference() < 10 {
            title = "Not bad"
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func difference() -> Int {
        return abs(target - sliderValueRoundedInt())
    }
    
    func pointsForCurrentRound() -> Int {
        let regularPoints = 100 - difference()
        if difference() == 0 {
            return regularPoints + 100
        } else if difference() == 1 {
            return regularPoints + 50
        } else {
            return regularPoints
        }
    }
    
    func randomTarget() -> Int {
        return Int.random(in: 1...100)
    }
    
    func sliderValueRoundedInt() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func startOver() {
        score = 0
        round = 1
        target = randomTarget()
        sliderValue = 50
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 812, height: 375))
    }
}
