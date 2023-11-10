//
//  MealSummaryView.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import SwiftUI
import Kingfisher

// MARK: - Meal Summary View

struct MealSummaryView: View {
    @ObservedObject var viewModel: MealSummaryViewModel
    @State private var selectedMealID: String? = nil
    @State private var showingDetail = false

    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                loadingOrErrorView
                if let _ = viewModel.errorMessage {
                    // Handled by loadingOrErrorView
                } else {
                    mealSummaryGridView
                }
            }
            .navigationTitle("Desserts")
        }
        .onAppear(perform: viewModel.fetchMealSummaries)
    }

    // MARK: - Loading or Error View
    @ViewBuilder
    private var loadingOrErrorView: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
        }
    }

    // MARK: - Meal Summary Grid View
    private var mealSummaryGridView: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(viewModel.sortedMealSummaries, id: \.id) { mealSummary in
                Button(action: {
                    self.selectedMealID = mealSummary.idMeal
                    self.showingDetail = true
                }) {
                    VStack {
                        KFImage(URL(string: mealSummary.strMealThumb ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(8)
                        Text(mealSummary.strMeal ?? "")
                            .multilineTextAlignment(.center)
                            .frame(width: 100)
                    }
                }
            }
        }
        .accessibility(identifier: "mealSummaryGrid")
        .padding()
        .sheet(isPresented: $showingDetail, onDismiss: resetSheetState) {
            MealDetailSheetView(selectedMealID: $selectedMealID)
        }
    }

    // MARK: - Reset Sheet State
    private func resetSheetState() {
        self.selectedMealID = nil
        self.showingDetail = false
    }
}

// MARK: - Meal Summary Grid Item
struct MealSummaryGridItem: View {
    let mealSummary: MealSummary

    var body: some View {
        VStack {
            KFImage(URL(string: mealSummary.strMealThumb ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(8)
            Text(mealSummary.strMeal ?? "")
                .multilineTextAlignment(.center)
                .frame(width: 100)
        }
    }
}

// MARK: - Meal Detail Sheet View
struct MealDetailSheetView: View {
    @Binding var selectedMealID: String?

    var body: some View {
        if let mealID = selectedMealID {
            MealDetailView(viewModel: MealDetailViewModel(repository: MealRepository(), mealID: mealID))
        }
    }
}
