//
//  TopScorersTabItemView.swift
//  XCAFootballStats
//
//  Created by Kumaran Nathan on 2/16/24.
//

import SwiftUI
import XCAFootballDataClient
struct TopScorersTabItemView: View {
    @State var selectedCompetition: Competition?
    var body: some View {
        NavigationSplitView {
            List(Competition.defaultCompetitions, id: \.self, selection: $selectedCompetition) {
                Text($0.name)
            }
            .navigationTitle("XCA Football Top Scorers")
        }detail : {
            if let selectedCompetition {
                TopScorersTableView(competition: selectedCompetition)
                    .id(selectedCompetition)
            }else {
                Text("Select a competition")
            }
        
        }
    }
}

#Preview {
    TopScorersTabItemView()
}
