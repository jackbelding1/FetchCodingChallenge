//
//  MealDetailView.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/7/23.
//

import SwiftUI
import Kingfisher

import SwiftUI
import Kingfisher

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    if let mealDetail = viewModel.mealDetail {
                        mealDetailView(mealDetail: mealDetail)
                    } else {
                        Text("Meal detail not available.")
                            .padding()
                    }
                }
            }
        }
        .navigationBarTitle(viewModel.mealDetail?.strMeal ?? "Meal Detail", displayMode: .inline)
    }
    
    @ViewBuilder
    private func mealDetailView(mealDetail: any MealDetailProtocol) -> some View {
        Text(mealDetail.strMeal ?? "Unknown Meal")
            .font(.title)
            .padding()
        
        KFImage(URL(string: mealDetail.strMealThumb ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            .clipped()
        
        ForEach(viewModel.mealDetail?.ingredients ?? [], id: \.name) { ingredient in
            HStack {
                Text(ingredient.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(ingredient.measurement)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        
        if let instructions = mealDetail.strInstructions, !instructions.isEmpty {
            Text("Instructions")
                .font(.headline)
                .padding()
            
            Text(instructions)
                .padding([.horizontal, .bottom])
        }
        
        if let tags = mealDetail.strTags, !tags.isEmpty {
            Text("Tags: \(tags)")
                .padding()
        }
        
        if let youtubeURL = mealDetail.strYoutube {
            Link("Watch on YouTube", destination: URL(string: youtubeURL)!)
                .padding()
        }
        
        if let source = mealDetail.strSource {
            Link("Recipe Source", destination: URL(string: source)!)
                .padding()
        }
    }
}



//struct MealDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealDetailView()
//    }
//}
