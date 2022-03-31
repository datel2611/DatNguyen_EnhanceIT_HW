//
//  DetailViewController.swift
//  week2_HW
//
//  Created by Consultant on 10/01/1401 AP.
//

import UIKit
protocol DetailViewControllerDelegate: AnyObject{
    func setStatus(_ status:Bool)
}
class DetailViewController: UIViewController {
    
    internal var imageUrl: String?
    var status = false
    var id: Int?

    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
        
    private func loadImage(){
        //print("In LoadImage Method")
        
        let serialQueue = DispatchQueue(label: "down load image queue")
        serialQueue.async { [weak self] in
        
            var photoString = self!.imageUrl
            let myIndex = photoString?.index(photoString!.startIndex, offsetBy: 4)
            photoString?.insert("s", at: myIndex!)
            
            let urlS = photoString
            //print("image URL: \(urlS)")
            guard let url = URL(string: urlS!)
            else{
                print("Not good URL string")
                return}
            do{
                let data = try Data(contentsOf: url)
                
                //print("url: \(url)")
                //print("data: \(data)")
                
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                    self?.imageView.contentMode = .scaleAspectFill
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        switchControl.isOn = status

    
    }
    private func setUpUI(){
        view.addSubview(imageView)
        view.addSubview(switchControl)
        view.addSubview(favouriteLable)
        
        let safeArea = view.safeAreaLayoutGuide
        
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -100.0).isActive = true
        
        
        favouriteLable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        favouriteLable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20.0).isActive = true
        favouriteLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        switchControl.leadingAnchor.constraint(equalTo: favouriteLable.trailingAnchor).isActive = true
        switchControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        
        loadImage()
        //switchControl.isOn =  status
        //print("Status: \(status)")
    }
    
    private lazy var switchAction: UIAction = UIAction { [weak self] _ in
        self?.returnMasterViewController()
    }
    private lazy var switchControl: UISwitch = {
        let control = UISwitch(frame: .zero, primaryAction: switchAction)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    
    }()
    private let favouriteLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Favourite"
        return label
    }()
    
    private func returnMasterViewController(){
        status = switchControl.isOn
        //print("switch status: \(status)")
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){ [weak self] _ in
            self?.performSegue(withIdentifier: "returnMasterViewController", sender: nil)
        }

    }

}
