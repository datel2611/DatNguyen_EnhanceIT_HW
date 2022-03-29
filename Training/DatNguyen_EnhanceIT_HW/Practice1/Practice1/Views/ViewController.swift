//
//  ViewController.swift
//  Practice1
//
//  Created by Consultant on 09/01/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var action = UIAction { [weak self] _ in
           self?.downloadImage()
    }
    
    private lazy var button: UIButton = {
            let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action)
            button.setTitle("load a new image", for: UIControl.State.normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }()
    
    private func downloadImage(){
        let serialQueue = DispatchQueue(label: "queue-doiwnload image")
                serialQueue.async { [weak self] in
                    let urlS = "https://picsum.photos/400/400"
                    guard let url = URL(string: urlS)
                    else { return }
                    do {
                        let data = try Data(contentsOf: url)
                        
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                        
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                }
    }
    
    private func setUpUI() {
            // add the button on my view
        view.addSubview(button)
        view.addSubview(imageView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50.0).isActive = true
        button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -150.0).isActive = true
        
        
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -100).isActive = true
    }
    private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .lightGray
            return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }


}

