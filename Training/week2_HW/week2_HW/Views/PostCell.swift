//
//  PostCell.swift
//  week2_HW
//
//  Created by Consultant on 09/01/1401 AP.
//

import UIKit

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.numberOfLines = 0
        label.text = "false"
        return label
    }()
    
     private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.init(style: .subtitle, reuseIdentifier: "cell")
       
        
        
        setupUI()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder): not implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(idLabel)
        contentView.addSubview(statusLabel)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        idLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true

        
        statusLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
        

    }
    func configureCell(id: Int, status: Bool){
        idLabel.text = "ID: \(id)"
        statusLabel.text = status ? "true" : "false"
        statusLabel.textColor = status ? .green : .red
    }
    
    
}
