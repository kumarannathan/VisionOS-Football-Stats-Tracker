//
//  StandingsTabItemView.swift
//  XCAFootballStats
//
//  Created by Kumaran Nathan on 2/16/24.
//

import SwiftUI
import XCAFootballDataClient

struct StandingsTabItemView: View {
    @State var selectedCompetition: Competition?
    var body: some View {
        NavigationSplitView {
            List(Competition.defaultCompetitions, id: \.self, selection: $selectedCompetition) {
                Text($0.name)
            }
            .navigationTitle("XCA Football Standings")
        }detail : {
            if let selectedCompetition {
                StandingsTableView(competition: selectedCompetition)
                    .id(selectedCompetition)
            }else {
                Text("Select a competition")
            }
        
        }
    }
}

#Preview {
    StandingsTabItemView()
}
