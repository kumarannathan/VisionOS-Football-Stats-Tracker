//
//  XCAFootballStatsApp.swift
//  XCAFootballStats
//
//  Created by Kumaran Nathan on 2/15/24.
//

import SwiftUI
let apiKey = "9bab6dd2c90642faa01dd41893e8d16d"
@main
struct XCAFootballStatsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                StandingsTabItemView()
                    .tabItem { Label("Standings", systemImage: "table.fill") }
                
                TopScorersTabItemView()
                    .tabItem { Label("Top Scorers", systemImage: "soccerball.inverse") }
            }
        }
    }
}
