//
//  MovieCell.swift
//  DN_Homework_3
//
//  Created by Consultant on 17/01/1401 AP.
//

import UIKit

class MovieCell: UITableViewCell {

    static let indentifier = "MovieCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder): not implemented")
    }
    
    
  
    private let movieImage:UIImageView = {
        let movieImage = UIImageView()
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.backgroundColor = .darkGray
        
        return movieImage
    }()
    private let movieTittle: UILabel = {
        let movieTittle = UILabel()
        movieTittle.translatesAutoresizingMaskIntoConstraints = false
        movieTittle.text = "Movie tittle"
        movieTittle.font = UIFont.boldSystemFont(ofSize: 20)
        movieTittle.numberOfLines = 2
        //movieTittle.backgroundColor = .blue
        
        return movieTittle
    }()
    private let movieOverview: UILabel = {
        let movieOverview = UILabel()
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.text = "Movie overview"
        movieOverview.numberOfLines = 5
        
        //movieOverview.backgroundColor = .orange
        
        return movieOverview
    }()
    lazy var showDetailButton: UIButton = {
        let showDetailButton = UIButton()
        showDetailButton.translatesAutoresizingMaskIntoConstraints = false
        showDetailButton.setTitle("Show details", for: .normal)
        showDetailButton.setTitleColor(.white, for: .normal)
        showDetailButton.backgroundColor = .systemBlue
        return showDetailButton
    }()
    private let favouriteLabel: UILabel = {
        let favouriteLabel = UILabel()
        
        return favouriteLabel
        
    }()
    
   
        
    private func setUpUI(){
        
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTittle)
        contentView.addSubview(movieOverview)
        contentView.addSubview(showDetailButton)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        movieImage.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 10).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 100).isActive = true
        
        movieTittle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        movieTittle.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        movieTittle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
        movieTittle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        movieOverview.topAnchor.constraint(equalTo: movieTittle.bottomAnchor).isActive = true
        movieOverview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        movieOverview.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
        movieOverview.trailingAnchor.constraint(equalTo: showDetailButton.leadingAnchor).isActive = true
        
        showDetailButton.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40).isActive = true
        showDetailButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        showDetailButton.leadingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -120).isActive = true
        showDetailButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5).isActive = true
        
        
    }
    func configureMovieCell(title: String?, overview: String?, imageData: Data?){
        
        //print(title)
        movieTittle.text = title
        movieOverview.text = overview
        
        movieImage.image = nil
        if let imageData = imageData {
            movieImage.image = UIImage(data: imageData)
        }
        //contentView.sizeToFit()
    }

}
