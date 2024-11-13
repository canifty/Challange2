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
    let family:String
    let whereToFindIt: String
    let funFact: String
}

let FlowerData: [String: FlowerInfo] = [
    "Daisy": FlowerInfo(
            title: "Daisy",
            imageName: "Daisy",
            family: "Family: Asteraceae",
            whereToFindIt: "Found in: gardens and grasslands",
            funFact: "Fun fact: It represents youth and childhood"
            ),
    "Cactus": FlowerInfo(
            title: "Cactus",
            imageName: "Cactus",
            family: "Family: Cactaceae",
            whereToFindIt: "Found it: desert areas",
            funFact: "Found fact: it can live up to 150 years"
            ),
    "Rosemary": FlowerInfo(
            title: "Rosemary",
            imageName: "Rosemary",
            family: "Family: Lamiaceae",
            whereToFindIt: "Found in: warm and temperate areas",
            funFact: "Fun fact: it is also called as “herb of remembrance”"
            ),
    "Cyclamen": FlowerInfo(
            title: "Cyclamen",
            imageName: "Cyclamen",
            family: "Family: Primulaceae",
            whereToFindIt: "Found in: woodlands and rocky habitats",
            funFact: "Fun Fact: It looks like a butterfly"
            ),
]

