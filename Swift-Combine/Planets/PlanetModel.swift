//
//  PlanetModel.swift
//  Combine-GettingStarted
//
//  Created by Glenn Ludszuweit on 05/05/2023.
//

import Foundation

struct PlanetData: Decodable {
    let results: [Planet]
}

struct Planet: Decodable {
    let name, diameter, climate, gravity, population: String
}

struct PlanetEntity: Decodable, Identifiable {
    let id: UUID
    let name, diameter, climate, gravity, population: String
}

