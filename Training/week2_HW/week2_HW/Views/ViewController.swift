//
//  ViewController.swift
//  week2_HW
//
//  Created by Consultant on 08/01/1401 AP.
//

import UIKit

    private let networkManager = NetworkManager()
    private var posts = [PostItem]()
    private var rowSelected = 0
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
        networkManager.getPost() { [weak self] result in
            switch result {
            case .success(let posts):
                //self?.posts = posts
                //print("Posts: \(posts)")

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }

            case .failure(let error):
                let error = error
                print(error.localizedDescription)
            
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            let post = networkManager.postItems[rowSelected]
            //print("row selected: \(rowSelected)")
            destination.imageUrl = post.img_src
            destination.status = post.status
            destination.id = post.id
        }
    }
    
    @IBAction func returnViewController(_ segue: UIStoryboardSegue){
        if let source = segue.source as? DetailViewController{
            let status = source.status
            let id = source.id
            print("Status: ____ \(status    )")

            
            if let index = networkManager.postItems.firstIndex(where: { $0.id == id}) {
                networkManager.postItems[index].status = status
                tableView.reloadData()
            }
        }
    }
    
    private func setUpUI(){
        view.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkManager.postItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
            
        cell.configureCell(id: networkManager.postItems[row].id, status: networkManager.postItems[row].status)


        return cell
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        rowSelected = indexPath.row
        //print("Index path: \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    
}

