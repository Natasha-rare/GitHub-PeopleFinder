//
//  ResultsShowController.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 27.06.2021.
//

import Foundation
import UIKit
import Alamofire

class ResultsShowController: UIViewController, UITableViewDataSource {
    
    var user:User = User()
    let tableView = UITableView()
    var reposCount:Int = 0
    var repos = Array<Repository>()
   
//    var errorLb = UILabel()
    
    @IBOutlet weak var peopleIcon: UIImageView!
    @IBOutlet weak var userbio: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var search: UIButton!
    
    @IBAction func searchClicked(_ sender: Any) {
        let name = self.usernameTF.text!
        if name.count > 0 { self.FindPerson(name: name)}
        else{
            self.usernameLbl.text = "Name can't be empty"
        }
        
    }
    
    public func clearAll(){
        self.usernameLbl.text = ""
        self.userbio.text = ""
        self.avatarImg.image = nil
        self.followingLbl.text = ""
        self.followersLbl.text = ""
        self.peopleIcon.isHidden = true
    }
    
    public func FindPerson(name: String){
//        Alamofire.request("https://api.github.com/users/\(name)").responseJSON {responseJSON in
//            switch responseJSON.result {
//            case .success(let value):
//                print(value)
////                guard let jsonResult = value as? Dictionary<[String: Any]> else { return }
////                guard
////                    let avatar = jsonResult["avatar_url"] as? String,
////                    let followers = jsonResult["followers"] as? Int,
////                    let following = jsonResult["following"] as? Int,
////                    let bio = jsonResult["bio"] as? String
////                else {return}
////                self.user = User(name: name, avatar: avatar, followers:followers, following: following, bio: bio)
////                self.loadContent()
//            case .failure(let error):
//                print(error)
//            }
        
        
        guard let url = URL(string: "https://api.github.com/users/\(name)") else { return }
        let task = URLSession.shared.dataTask(with: url){
            (data, responce, error) in
            if error != nil{
                self.usernameLbl.text = error?.localizedDescription
                print(error!)
            }else{
                if let urlContent = data{
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonResult)
                        if let result = jsonResult["login"]!{
                            print(jsonResult["login"]!!)
                            var avatar = jsonResult["avatar_url"] as? String ?? ""
                            var followers = jsonResult["followers"] as? Int ?? 0
                            var following = jsonResult["following"] as? Int ?? 0
                            var bio = jsonResult["bio"] as? String ?? ""
                            self.user = User(name: name, avatar: avatar, followers:followers, following: following, bio: bio)
                            self.loadContent()
                        }
                        else{
                            print("nothing found")
                            DispatchQueue.main.async {
                                self.clearAll()
                                self.usernameLbl.text = "Nothing found. Please, try other name"
                            }
                        }
                    } catch{
                        print("JSON processing error")
                    }
                }
            }
        }
        task.resume()
//        FindRepos(name: name)
    }
    
    public func FindRepos(name: String){
        let url = URL(string: "https://api.github.com/users/\(name)/repos")
        let task = URLSession.shared.dataTask(with: url!){
            (data, responce, error) in
            if error != nil{
                self.usernameLbl.text = error?.localizedDescription
                print(error!)
            }else{
                print(data ?? "")
                if let urlContent = data{
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonResult)
                        
                    } catch{
                        print("JSON processing error")
                    }
                }
            }
        
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSpinnerView()
    }
    
    func loadContent(){
        guard let imageURL = URL(string: self.user.avatar) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.usernameLbl.text = self.user.name
                self.userbio.text = self.user.bio
                self.avatarImg.image = image
                self.followingLbl.text = "\(self.user.following) following"
                self.followersLbl.text = "\(self.user.followers) followers"
                self.peopleIcon.isHidden = false
            }
        }
    }
    
    func loadTable(){
        tableView.frame = CGRect(x: 8, y: 128, width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.height)
        tableView.register(ReposTableViewCell.self, forCellReuseIdentifier: "ReposTableViewCell")
        tableView.dataSource = self
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 60
        
        tableView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(self.reposCount * 60 + 100))
        super.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            var cell = ReposTableViewCell()
        cell = self.tableView.dequeueReusableCell(withIdentifier: "ReposTableViewCell", for: indexPath) as! ReposTableViewCell
        cell.reposDescriptionLbl.text = self.repos[indexPath.row].description
        cell.reposNameLbl.text = self.repos[indexPath.row].name
        cell.reposSizeLbl.text = String(self.repos[indexPath.row].size)
        cell.reposForksLbl.text = String(self.repos[indexPath.row].private_repo)
        cell.reposLangLbl.text = self.repos[indexPath.row].language
        return cell
    }
        
        
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch tableView {
       case self.tableView:
          return self.reposCount
        default:
          return 0
       }
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           var cell = TableViewCell()
//           cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//           cell.textLabel?.text = groceryIngridients[indexPath.row]
//           cell.btn.setImage(UIImage(named: "check-box.png"), for: .normal)
//           cell.btn.layer.borderColor = UIColor.black.cgColor
//           cell.btn.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: cell.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 25, height: 0, enableInsets: false)
//           cell.textLabel!.anchor(top: cell.topAnchor, left: cell.btn.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: CGFloat(UIScreen.main.bounds.width - 76), height: 0, enableInsets: false)
//   //        cell.textLabel?.frame = CGRect(x: 60, y: 5, width: Int(UIScreen.main.bounds.width - 76), height: 30)
//           cell.btn.addTarget(self, action: #selector(imageTapped(_:)), for: .touchDown)
//           cell.layoutSubviews()
//           return cell
//       }
}

