//
//  ResultsShowController.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 27.06.2021.
//

import Foundation
import UIKit

class ResultsShowController: UIViewController{
    
    var user:User = User()
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    var repos = Array<Repository>()
   
//    var errorLb = UILabel()
    
    @IBOutlet weak var peopleIcon: UIImageView!
    @IBOutlet weak var userbio: UILabel!
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
                            self.FindRepos(name: name)
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
        
    }
    
    public func FindRepos(name: String){
        let url = URL(string: "https://api.github.com/users/\(name)/repos")
        let task = URLSession.shared.dataTask(with: url!){
            (data, responce, error) in
            if error != nil{
                self.usernameLbl.text = error?.localizedDescription
                print(error!)
            }else{
                if let urlContent = data{
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<[String: AnyObject]>
                        print(jsonResult!)
                        
                        for jsonItem in jsonResult!{
                            let repoName = jsonItem["name"] as? String ?? ""
                            let private_repo = jsonItem["private"] as? Bool ?? true
                            let lang = jsonItem["language"] as? String ?? ""
                            let description = jsonItem["description"] as? String ?? ""
                            let forks = jsonItem["forks_count"] as? Int ?? 0
                            var repo = Repository(name: repoName, private_repo: private_repo, description: description, language: lang, forks: forks)
                            self.repos.append(repo)
                        }
                        DispatchQueue.main.async {
                            print(self.repos.count)
                            print(self.repos)
                            self.loadTable()
                            
                        }
                        
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.frame = CGRect(x: 8, y: 300, width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.height - 200)
        self.tableView.register(ReposTableViewCell.self, forCellReuseIdentifier: "ReposTableViewCell")
        self.tableView.backgroundColor = view.backgroundColor
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = 76
        
        self.tableView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(self.repos.count * 76 + 100))
//        self.registerTableViewCells()
        self.tableView.reloadData()
        super.view.addSubview(self.tableView)
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

extension ResultsShowController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ReposTableViewCell()
        cell = self.tableView.dequeueReusableCell(withIdentifier: "ReposTableViewCell", for: indexPath) as! ReposTableViewCell
        print(self.repos[indexPath.row].name, "hvbjn")
        cell.reposDescriptionLbl?.text = self.repos[indexPath.row].description
        cell.reposNamelbl?.text = self.repos[indexPath.row].name
        cell.reposForksLbl?.text = String(self.repos[indexPath.row].forks)
        cell.reposPrivateLbl?.text = String(self.repos[indexPath.row].private_repo)
        cell.reposLangLbl?.text = self.repos[indexPath.row].language
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = self.repos[indexPath.row]
        print(repo.name, indexPath.row)
    }
        
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch tableView {
       case self.tableView:
          return self.repos.count
        default:
          return 0
       }
    }
}
