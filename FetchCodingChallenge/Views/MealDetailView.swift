//
//  MealDetailView.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/7/23.
//

import SwiftUI
import Kingfisher

// MARK: - Meal Detail View

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                loadingOrErrorView
                if let mealDetail = viewModel.mealDetail {
                    mealDetailView(mealDetail: mealDetail)
                } else {
                    Text("Meal detail not available.")
                        .padding()
                }
            }
        }
    }
    
    // MARK: - Loading or Error View
    @ViewBuilder
    private var loadingOrErrorView: some View {
        if viewModel.isLoading {
            ProgressView()
                .accessibilityIdentifier("mealDetailLoadingView")
                .scaleEffect(1.5)
                .padding()
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)")
                .foregroundColor(.red)
                .padding()
        }
    }
    
    // MARK: - Meal Detail View
    @ViewBuilder
    private func mealDetailView(mealDetail: any MealDetailProtocol) -> some View {
        mealTitleView(mealDetail)
        mealImageView(mealDetail)
        ingredientsView
        instructionsView(mealDetail)
        additionalInfoView(mealDetail)
    }
    
    // MARK: - Subviews
    private func mealTitleView(_ mealDetail: any MealDetailProtocol) -> some View {
        HStack {
            // Dismiss Button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left") // Use an appropriate icon for back
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
            .padding(8)
            
            // Title
            Text(mealDetail.strMeal ?? "Unknown Meal")
                .font(.title)
                .padding()
                .accessibilityIdentifier("mealDetailTitle")
        }
    }
    
    private func mealImageView(_ mealDetail: any MealDetailProtocol) -> some View {
        KFImage(URL(string: mealDetail.strMealThumb ?? ""))
            .resizable()
            .accessibilityIdentifier("mealDetailImageView")
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            .clipped()
    }
    
    @ViewBuilder
    private var ingredientsView: some View {
        Group {
            Text("Ingredients:")
                .font(.headline)
                .padding()
            
            ForEach(viewModel.mealDetail?.ingredients ?? [], id: \.name) { ingredient in
                HStack {
                    Text(ingredient.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(ingredient.measurement)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            }
        }
        .accessibilityIdentifier("mealDetailIngredientsView")
    }
    
    private func instructionsView(_ mealDetail: any MealDetailProtocol) -> some View {
        VStack {
            if let instructions = mealDetail.strInstructions, !instructions.isEmpty {
                Text("Instructions")
                    .font(.headline)
                    .padding()
                
                Text(instructions)
                    .padding([.horizontal, .bottom])
            } else {
                EmptyView()
            }
        }
        .accessibilityIdentifier("mealDetailInstructionsView")
    }
    
    
    private func additionalInfoView(_ mealDetail: any MealDetailProtocol) -> some View {
        VStack(alignment: .leading) {
            if let tags = mealDetail.strTags, !tags.isEmpty {
                Text("Tags: \(tags)")
                    .padding()
            }
            
            if let youtubeURLString = mealDetail.strYoutube, let youtubeURL = URL(string: youtubeURLString) {
                Link("Watch on YouTube", destination: youtubeURL)
                    .padding()
            }
            
            if let sourceString = mealDetail.strSource, let sourceURL = URL(string: sourceString) {
                Link("Recipe Source", destination: sourceURL)
                    .padding()
            }
        }
        .padding(.top)
        .accessibilityIdentifier("mealDetailAdditionalInfoView")
    }
}
