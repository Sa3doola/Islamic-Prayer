//
//  CountriesTVC.swift
//  Islamic-Prayer
//
//  Created by sa3doola on 9/13/20.
//  Copyright © 2020 saad sherif. All rights reserved.
//

import UIKit

class CountriesTVC: UITableViewCell {
    
    static let id = "CountriesTVC"

    @IBOutlet weak var CountryNameLbl: UILabel!
    
    public func configure(with name: String) {
        CountryNameLbl.text = name
    }
}
