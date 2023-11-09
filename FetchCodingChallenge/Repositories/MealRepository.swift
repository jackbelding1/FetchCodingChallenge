//
//  MealRepository.swift
//  FetchCodingChallenge
//
//  Created by Jack Belding on 11/6/23.
//

import Foundation

// MARK: - Network Error

enum NetworkError: Error {
    case badURL, requestFailed, noData, parsingFailed, unknown
}

// MARK: - Meal Repository Protocol

class MealRepository: MealRepositoryProtocol {
    // URLSession object
    private var session: URLSession

    // Initializer
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchMealSummaries(completion: @escaping (Result<[any MealSummaryProtocol], Error>) -> Void) {

        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(MealSummariesResponse.self, from: data)
                // Map the decoded meals to protocol type
                let protocolMeals = response.meals.map { $0 as any MealSummaryProtocol }
                completion(.success(protocolMeals))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    func fetchMealDetail(forId id: String, completion: @escaping (Result<any MealDetailProtocol, Error>) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
                // Assuming the JSON has a "meals" key that contains an array of MealDetail
                // Map the decoded meals to protocol type
                if let mealDetail = response.meals.first as? any MealDetailProtocol {
                    completion(.success(mealDetail))
                } else {
                    completion(.failure(NetworkError.parsingFailed))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

// MARK: - Response Structs

struct MealSummariesResponse: Codable {
    let meals: [MealSummary]
}

struct MealDetailsResponse: Decodable {
    let meals: [MealDetail]
}
