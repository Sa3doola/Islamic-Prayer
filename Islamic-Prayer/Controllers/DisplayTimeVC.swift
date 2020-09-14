//
//  DisplayTimeVC.swift
//  Islamic-Prayer
//
//  Created by sa3doola on 9/13/20.
//  Copyright © 2020 saad sherif. All rights reserved.
//

import UIKit

class DisplayTimeVC: UIViewController {
    
    private let model: IslamicModel
    private var models = [IslamicViewModel]()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PrayerTime")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.clipsToBounds = true
        tableView.register(SalatTVC.self, forCellReuseIdentifier: SalatTVC.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureModels()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(cityNameLabel)
        scrollView.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.width,
                                 height: 300)
        dateLabel.frame = CGRect(x: view.width/3+20,
                                 y: 80,
                                 width: 150,
                                 height: 40)
        cityNameLabel.frame = CGRect(x: view.width/3+20,
                                     y: dateLabel.bottom + 5,
                                     width: 150,
                                     height: 40)
        tableView.frame = CGRect(x: 0,
                                 y: imageView.bottom,
                                 width: view.width,
                                 height: view.height/2)
    }
    
    init(model: IslamicModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureModels() {
        
        dateLabel.text = Date
        cityNameLabel.text = ChossenCity
        models.append(IslamicViewModel.init(name: salat[0], time: model.chossenFajr))
        models.append(IslamicViewModel.init(name: salat[1], time: model.chossenSunrise))
        models.append(IslamicViewModel.init(name: salat[2], time: model.chossenDhuhr))
        models.append(IslamicViewModel.init(name: salat[3], time: model.chossenAsr))
        models.append(IslamicViewModel.init(name: salat[4], time: model.chossenMaghrib))
        models.append(IslamicViewModel.init(name: salat[5], time: model.chossenIsha))
        
    }
    
}

extension DisplayTimeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SalatTVC.id, for: indexPath) as? SalatTVC else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
