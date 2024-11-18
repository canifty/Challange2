//
//  FlowerDicrionary.swift
//  Challange2
//
//  Created by Francesco Romeo on 13/11/24.
//

import Foundation
struct FlowerInfo {
    let title: String
    let imageName: String
    let family:[String]
    let whereToFindIt: String
    let funFact: String
}

let FlowerData: [String: FlowerInfo] = [
    "Daisy": FlowerInfo(
            title: "Daisy",
            imageName: "Daisy",
            family: ["Asteraceae"],
            whereToFindIt: "Gardens and grasslands",
            funFact: "It represents youth and childhood"
            ),
    "Cactus": FlowerInfo(
            title: "Cactus",
            imageName: "Cactus",
            family: ["Cactaceae", "Carnegiea", "Kroenleinia grusonii"],
            whereToFindIt: "Desert areas",
            funFact: "It can live up to 150 years"
            ),
    "Rosemary": FlowerInfo(
            title: "Rosemary",
            imageName: "Rosemary",
            family: ["Lamiaceae", "Salvia rosmarinus"],
            whereToFindIt: "Warm and temperate areas",
            funFact: "It is also called as “herb of remembrance“"
            ),
    "Cyclamen": FlowerInfo(
            title: "Cyclamen",
            imageName: "Cyclamen",
            family: ["Primulaceae", "Cyclamen persicum"],
            whereToFindIt: "Woodlands and rocky habitats",
            funFact: "It looks like a butterfly"
            ),
]

