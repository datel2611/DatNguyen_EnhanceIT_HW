//
//  ViewController.swift
//  week2_HW
//
//  Created by Consultant on 08/01/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkManager.getPost()
    }


}

