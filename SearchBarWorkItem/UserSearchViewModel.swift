//
//  UserViewModel.swift
//  SearchBarWorkItem
//
//  Created by Alkit Gupta on 25/07/25.
//

import Foundation

class UserSearchViewModel {
    private var searchWorkItem: DispatchWorkItem?
    var results: [CityModel] = []
    var onResultsUpdated: (() -> Void)?

    func searchUsers(term: String) {
        searchWorkItem?.cancel()

        guard !term.isEmpty else {
            results = []
            onResultsUpdated?()
            return
        }

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            let urlString =  "https://api.openweathermap.org/geo/1.0/direct?q=\(term)&limit=100&appid=f32f36efd5c0cefa353f90cb87fa26d5&countrycode=IN"
            guard let url = URL(string: urlString) else { return }
            print(url)

            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data,
                      let fetchedUsers = try? JSONDecoder().decode([CityModel].self, from: data) else { return }

                DispatchQueue.main.async {
                    self.results = fetchedUsers
                    self.onResultsUpdated?()
                }
            }.resume()
        }

        searchWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: workItem)
    }
}

