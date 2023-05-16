//
//  PlanetViewModel.swift
//  Combine-GettingStarted
//
//  Created by Glenn Ludszuweit on 05/05/2023.
//

import Foundation
import Combine

class PlanetViewModel: ObservableObject {
    @Published var filteredPlanets: [PlanetEntity] = []
    @Published var errorMessage: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    private var planetList: [PlanetEntity] = []
    private var planets: [Planet] = []
    var networkManager: NetworkProtocol
    var errorManager: ErrorProtocol
    init(networkManager: NetworkProtocol, errorManager: ErrorProtocol) {
        self.networkManager = networkManager
        self.errorManager = errorManager
    }
    
    func getAllPlanets(apiUrl: String) {
        guard let url = URL(string: apiUrl) else {
            self.errorMessage = errorManager.handleError(APIError.invalidURL)
            return
        }
        
        self.networkManager.getAll(apiUrl: url, type: PlanetData.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.planets.forEach { planet in
                        let newPlanet = PlanetEntity(id: UUID(), name: planet.name, diameter: planet.diameter, climate: planet.climate, gravity: planet.gravity,  population: planet.population)
                        self.planetList.append(newPlanet)
                    }
                    self.filteredPlanets = self.planetList
                case .failure(let error):
                    self.errorMessage = self.errorManager.handleError(error)
                }
            } receiveValue: { data in
                self.planets = data.results
            }
            .store(in: &cancellable)
    }
    
    func searchPlanets(searchText: String) {
        if searchText.isEmpty {
            self.filteredPlanets = self.planetList
        } else {
            self.filteredPlanets =  self.planetList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func cancelFetch() {
        cancellable.first?.cancel()
    }
}
