//
//  ViewController.swift
//  DN_Homework_3
//
//  Created by Consultant on 16/01/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var inputTextView: UITextField = {
        let inputTextView = UITextField()
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.text = UserDefaults.standard.string(forKey: "userName")
        inputTextView.backgroundColor = UIColor.lightGray
        inputTextView.layer.cornerRadius = 9
        inputTextView.layer.masksToBounds = true
        return inputTextView
    }()
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton(frame: .zero, primaryAction: saveAction)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        //saveButton.setTitleShadowColor(.gray, for: .selected)
        return saveButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setUpUI()
        print("UI set up")
    }
    private func setUpUI() {
        view.addSubview(inputTextView)
        view.addSubview(saveButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        inputTextView.topAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -20).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: 20).isActive = true
        inputTextView.leadingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -150).isActive = true
        inputTextView.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 150).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 10).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 30).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: inputTextView.trailingAnchor).isActive = true
    }
   
    
    
    private lazy var saveAction: UIAction = UIAction { [weak self] _ in
        self?.saveName()
        if((self?.inputTextView.text!.count)! > 3){
            self?.goToMovieListViewController()
        }
    }

    private func saveName(){
        if(inputTextView.text!.count > 3 ){
            UserDefaults.standard.set(inputTextView.text, forKey: "userName")
        } 
    }
        
    
    private func goToMovieListViewController(){
        let destination = MovieListVC()
        navigationController?.pushViewController(destination, animated: true)
        //present(destination, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MovieListVC()
        destination.userName = UserDefaults.standard.string(forKey: "userName")
        
    }
}
