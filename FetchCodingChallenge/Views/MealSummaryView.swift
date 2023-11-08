//
//  MealSummaryView.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import SwiftUI
import Kingfisher

struct MealSummaryView: View {
    @ObservedObject var viewModel: MealSummaryViewModel
    @State private var selectedMealID: String? = nil
    @State private var showingDetail = false // Controls the presentation of the sheet
    
    var body: some View {
        let selectedMealIDBinding = Binding<String?>(
            get: { self.selectedMealID },
            set: { self.selectedMealID = $0 }
        )
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(viewModel.sortedMealSummaries, id: \.id) { mealSummary in
                            Button(action: {
                                selectedMealIDBinding.wrappedValue = mealSummary.idMeal
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
                    .padding()
                    // This will present the MealDetailView when showingDetail is true
                    .sheet(isPresented: $showingDetail, onDismiss: {
                        // Reset the selectedMealID and showingDetail when the sheet is dismissed
                        self.selectedMealID = nil
                        self.showingDetail = false
                    }) {
                        // Present the MealDetailView only if a mealID is selected
                        if let mealID = selectedMealID {
                            MealDetailView(viewModel: MealDetailViewModel(repository: MealRepository(), mealID: mealID))
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchMealSummaries()
            }
        }
    }
}


//
//struct MealSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealSummaryView(viewModel: MealSummaryViewModel(repository: MockMealRepository()))
//    }
//}
