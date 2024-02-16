//
//  TopScorersView.swift
//  XCAFootballStats
//
//  Created by Kumaran Nathan on 2/16/24.
//

import SwiftUI
import XCAFootballDataClient

struct TopScorersTableView: View {
    @Bindable var vm = TopScorersTableObservable()
    let competition: Competition
    var body: some View {
        Table(of: Scorer.self ) {
            TableColumn("Pos") { scorer in
                HStack {
                    Text(scorer.posText).fontWeight(.bold).frame(minWidth: 20)
                                   
                                   if let crest = scorer.team.crest, crest.hasSuffix("svg") {
//                                       SVGImage(url: URL(string: crest)!, size: .init(width: 40, height: 40))
//                                           .frame(width: 40, height: 40)
//                                           .cornerRadius(20)
                                   } else {
                                       AsyncImage(url: URL(string: scorer.team.crest ?? "")) { phase in
                                           switch phase {
                                           case .success(let image): image.resizable()
                                           default: Circle().foregroundStyle(Color.gray.opacity(0.5))
                                           }
                                       }.frame(width: 40, height: 40)
                                   }
                                
                                   Text(scorer.player.name)
                }
            }.width(min: 264)
            
            TableColumn("Matches") { Text($0.playedMatchesText).frame(minWidth: 64) }
                          .width(64)
                      
                      TableColumn("Goals") { Text($0.goalsText).frame(minWidth: 64) }
                          .width(64)
                      
                      TableColumn("⌀ Goals") { Text($0.goalsPerMatchRatioText).frame(minWidth: 64) }
                          .width(64)
                      
                      TableColumn("Assists") { Text($0.assistsText).frame(minWidth: 64) }
                          .width(64)
                      
                      TableColumn("Pen.") { Text($0.penaltiesText).frame(minWidth: 64) }
                          .width(64)
            
        }rows: {
            //scorers?
            ForEach(vm.scorers ?? []) {
                TableRow($0)
            }
        }
        .foregroundStyle(.primary)
        .overlay {
                   switch vm.fetchPhase {
                   case .fetching: ProgressView()
                   case .success(let scorers) where scorers.isEmpty:
                       Text("Scorers not available").font(.headline)
                   case .failure(let error):
                       Text(error.localizedDescription).font(.headline)
                   default: EmptyView()
                   }
               }
            .navigationTitle(competition.name + " Top Scorers")
            .task(id: vm.selectedFilter.id) {
                await vm.fetchTopScorers(competition: competition)
            }
    }
}

#Preview {
    NavigationStack {
        
        
        TopScorersTableView(competition: .defaultCompetitions[1])
    }
}
