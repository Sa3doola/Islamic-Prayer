//
//  IslamicModel.swift
//  Islamic-Prayer
//
//  Created by sa3doola on 9/13/20.
//  Copyright © 2020 saad sherif. All rights reserved.
//

import Foundation

struct IslamicModel {
    
    var chossenFajr: String
    var chossenSunrise: String
    var chossenDhuhr: String
    var chossenAsr: String
    var chossenMaghrib: String
    var chossenIsha: String
}

struct IslamicViewModel {
    let name: String
    let time: String
}
