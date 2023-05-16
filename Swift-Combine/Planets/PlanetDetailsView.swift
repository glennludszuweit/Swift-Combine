//
//  PlanetDetailsView.swift
//  Combine-GettingStarted
//
//  Created by Glenn Ludszuweit on 05/05/2023.
//

import SwiftUI

struct PlanetDetailsView: View {
    let planet: PlanetEntity
    var body: some View {
        Text(planet.name)
        Text(planet.climate)
        Text(planet.gravity)
        Text(planet.diameter)
        Text(planet.population)
    }
}

struct PlanetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetailsView(planet: PlanetEntity(id: UUID(), name: "", diameter: "", climate: "", gravity: "", population: ""))
    }
}
