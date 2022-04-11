//
//  MovieDetailViewController.swift
//  DN_Homework_3
//
//  Created by Consultant on 20/01/1401 AP.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var status = false
    
    private let favouriteLabel: UILabel = {
        let favouriteLabel = UILabel()
        favouriteLabel.translatesAutoresizingMaskIntoConstraints = false
        favouriteLabel.text = "Favourite"
        //favouriteLabel.backgroundColor = .red
        
        return favouriteLabel
    }()
    
    private lazy var favouriteSwitch: UISwitch = {
        let favouriteSwitch = UISwitch(frame: .zero, primaryAction: switchAction)
        favouriteSwitch.translatesAutoresizingMaskIntoConstraints = false
        return favouriteSwitch
        
    }()
    private lazy var switchAction: UIAction = UIAction { [weak self] _ in
        self?.saveToFavourite()
    }
    private func saveToFavourite() {
        status = favouriteSwitch.isOn
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        view.addSubview(favouriteLabel)
        view.addSubview(favouriteSwitch)
        
        let safeArea = view.safeAreaLayoutGuide
        
        favouriteLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        favouriteLabel.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40).isActive = true
        favouriteLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        favouriteLabel.trailingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 100).isActive = true

        favouriteSwitch.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        favouriteSwitch.leadingAnchor.constraint(equalTo: favouriteLabel.trailingAnchor).isActive = true

    }
    

}
