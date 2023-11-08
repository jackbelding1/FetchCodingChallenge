//
//  FetchCodingChallengeApp.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/3/23.
//

import SwiftUI

@main
struct FetchCodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            MealSummaryView(viewModel: MealSummaryViewModel(repository: MealRepository()))
        }
    }
}
