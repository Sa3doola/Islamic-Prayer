//
//  HomeVC.swift
//  Islamic-Prayer
//
//  Created by sa3doola on 9/13/20.
//  Copyright © 2020 saad sherif. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var countriesListView: UIView!
    @IBOutlet weak var CountriesTableView: UITableView!
    @IBOutlet weak var SelectButton: UIButton!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var CountryNameLbl: UILabel!
    @IBOutlet weak var CityNameTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.isHidden = true
        countriesListView.isHidden = true
        
        CountriesTableView.delegate = self
        CountriesTableView.dataSource = self
        countriesListView.clipsToBounds = true
        
        SelectButton.layer.cornerRadius = 12
        SearchButton.layer.cornerRadius = 12
    }

    
    //MARK: - Actions
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        
        shadowView.isHidden = false
        countriesListView.isHidden = false
    }
    
    @IBAction func dismissTableViewAction(_ sender: Any) {
        shadowView.isHidden = true
        countriesListView.isHidden = true
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        let vc = DisplayTimeVC()
        vc.title = "Salat Time"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryName = countries[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTVC.id, for: indexPath) as? CountriesTVC else { return UITableViewCell() }
        cell.configure(with: countryName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ChossenCountry = countries[indexPath.row]
        CountryNameLbl.text = ChossenCountry
        shadowView.isHidden = true
        countriesListView.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
