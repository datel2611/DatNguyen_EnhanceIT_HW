//
//  MovieListViewController.swift
//  DN_Homework_3
//
//  Created by Consultant on 16/01/1401 AP.
//

import UIKit
import Combine

class MovieListVC: UIViewController{
    
    private var viewModel : MovieListViewModelProtocol?
    private var subcribers = Set<AnyCancellable>()
    
    var userName: String?
    private var movies = [Movie]()
    
        
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        //nameLabel.backgroundColor = .red
        nameLabel.text = "Hello, \(UserDefaults.standard.string(forKey: "userName") ?? "User name")"
        nameLabel.font = nameLabel.font.withSize(22)
        
        return nameLabel
    } ()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Movies List","Favorites"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.layer.cornerRadius = 9
        segmentControl.layer.masksToBounds = true
        
        segmentControl.addTarget(self, action: #selector(segmentAction), for: .touchUpInside)
        return segmentControl
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 9
        searchBar.layer.masksToBounds = true
        
        return searchBar
    }()

    
    @objc private func segmentAction(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            view.backgroundColor = .red
        case 1:
            view.backgroundColor = .green
        default:
            view.backgroundColor = .white
        }
    }
    
    private lazy var movieListView: UITableView = {
        let movieListView = UITableView()
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.indentifier)
        movieListView.backgroundColor = .lightGray
        movieListView.dataSource = self
        movieListView.delegate = self
        //movieListView.prefetchDataSource = self
        
        return movieListView
    }()
    
    private lazy var logOutButton: UIButton = {
        let logOutButton = UIButton(frame: .zero, primaryAction: logOutAction)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.backgroundColor = .white
        
        
        return logOutButton
    }()
    private lazy var logOutAction:UIAction = UIAction { [weak self] _ in
        self?.logOut()
        self?.goToViewController()
    }
    private func logOut() {
        UserDefaults.standard.removeObject(forKey: "userName")
    }
    private func goToViewController(){
        let destination = ViewController()
        navigationController?.pushViewController(destination, animated: true)
        //present(destination, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        assemblingMVVM()
        setUpUI()
        setUpBinding()
        
        
    }
    
    private func assemblingMVVM(){
        let mainNetworkManager = MainNetworkManager()
        viewModel = MovieListViewModel(networkManager: mainNetworkManager)
    }
    private func setUpBinding() {
        viewModel?
            .publisherMovies
            .sink(receiveValue: { _ in
                DispatchQueue.main.async {
                    self.movieListView.reloadData()
                }
            })
            .store(in: &subcribers)
        
        viewModel?.getMovies()
    }

    private func setUpUI(){
        view.addSubview(nameLabel)
        view.addSubview(segmentControl)
        view.addSubview(searchBar)
        view.addSubview(movieListView)
        view.addSubview(logOutButton)
        
        
        let safeArea = view.safeAreaLayoutGuide
        
        nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        segmentControl.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        searchBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        movieListView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40).isActive = true
        
        logOutButton.topAnchor.constraint(equalTo: movieListView.bottomAnchor).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
    }


}
extension MovieListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("movies count: \(viewModel?.totalRows)")
        return viewModel?.totalRows ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.indentifier, for: indexPath) as! MovieCell
        
        let row = indexPath.row
        
        cell.showDetailButton.tag = indexPath.row
        cell.showDetailButton.addTarget(self, action: #selector(showDetail(sender: )), for: .touchUpInside)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        
        let title = viewModel?.getTitle(by: row)
        let overView = viewModel?.getOverview(by: row)
        
        //print(title)
        
        cell.configureMovieCell( title: title, overview: overView)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @objc private func showDetail(sender: UIButton) {
        let destination = MovieDetailViewController()
        //let selectedRow = IndexPath(row: sender.tag, section: 0)
        
        destination.status = false
        
        navigationController?.pushViewController(destination, animated: true)
    }
}

