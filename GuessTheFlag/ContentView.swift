//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Joao Leal on 2/13/24.
//

import SwiftUI


struct ContentView: View {
    
   @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Ukraine", "US", "Spain"].shuffled()
    
    @State private var yourScore = 0
   @State var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var questionsAsked = 0
    @State private var endGame: Bool = false
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
     
                VStack(spacing: 15){
                    VStack{
                        Spacer()
                        Text("Guess the flag of")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(countries[correctAnswer])
                            .font(.title)
                            
                            .fontWeight(.semibold)
                          
                    }
                    
                   
                    
                    .foregroundStyle(.white)
                    
                    ForEach(0..<3) { country in
                        VStack{
                            Button {
                                
                                
                                flagTapped(country)
                            questionsAsked += 1
                                
                                
                            } label: {
                                Image(countries[country])
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                        
                    }
                    .frame(maxWidth: . infinity)
                    .padding(.vertical, 20)
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Score: \(yourScore)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }.alert(scoreTitle, isPresented: $showingScore) {
                    Button("Next", action: askQuestion)
                } message: {
                    Text("Your score is \(yourScore)")
                }
        }.alert("GAME OVER", isPresented: $endGame) {
            Button("Play again", action: restartGame)
        }
        }
    func flagTapped (_ number: Int) {
        
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            yourScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        
        showingScore = true
        
        if questionsAsked == 8 {
            endGame = true
            showingScore = false
        }
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func restartGame() {
        askQuestion()
        questionsAsked = 1
        yourScore = 0
    }
    
}
#Preview {
    ContentView()
}
