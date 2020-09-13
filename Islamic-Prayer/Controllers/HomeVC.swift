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
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.isHidden = true
        countriesListView.isHidden = true
        
        CountriesTableView.delegate = self
        CountriesTableView.dataSource = self
        
        viewModel.delegate = self
        
        countriesListView.clipsToBounds = true
        
        SelectButton.layer.cornerRadius = 12
        SearchButton.layer.cornerRadius = 12
    }
    
    
    //MARK: - Actions
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: sender.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy"
        let STRING_DATE = formatter.string(from: yourDate!)
        
        Date = STRING_DATE
        print(Date!)
        
        let year = NSString(string: STRING_DATE)
        let yearAfterSub = year.substring(from: 6)
        Year = String(yearAfterSub)
        
        let startIndex = STRING_DATE.index(STRING_DATE.startIndex, offsetBy: 3)
        let endIndex = STRING_DATE.index(STRING_DATE.startIndex, offsetBy: 5)
        let month : String = STRING_DATE
        let monthAfterSub = month.substring(with: startIndex..<endIndex)
        Month = monthAfterSub
        
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
        wayToDispaly()
    }
    
    private func wayToDispaly() {
        
        if CityNameTxtField.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Alert",
                                          message: "Fill The City Name!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK",
                                       style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        else if CountryNameLbl.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Alert",
                                          message: "Select your Country!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK",
                                       style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        else {
            guard let city = CityNameTxtField.text else { return }
            guard let country = ChossenCountry else { return }
            guard let month = Month else { return }
            guard let year = Year else { return }
            
            viewModel.fetchPrayerData(city: city, country: country, month: month, year: year )
        }
        
    }
    
}

extension HomeVC: IslamicViewModelDelegate {
    
    func didUpdataTime(_ viewModel: ViewModel, model: IslamicModel) {
        DispatchQueue.main.async {
            
            let vc = DisplayTimeVC(model: model)
            vc.title = "Salat Time"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didFailWithError(error: Error) {
        
        print(error.localizedDescription)
    }
    
    
}

//MARK: - TabelView

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
