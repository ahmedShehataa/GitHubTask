//
//  ViewController.swift
//  GitHubTask
//
//  Created by Shehata on 12/25/19.
//  Copyright © 2019 shehata. All rights reserved.
//

import UIKit
import UserNotifications
import DataCache

class ViewController: UIViewController {
    
    var page: Int! = 1
    var whichList: Int! = 1
    var searchCase: Bool = false
    var cachResposlist = [RespocacheModel]()
    var filterCachResposlist = [RespocacheModel]()
    var resposlist = [ReposElementModel]()
    var filterResposlist = [ReposElementModel]()
    
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var VW_overlay: UIView = UIView()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var filterSearchBar: UISearchBar!
    @IBOutlet weak var resposTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resposTableView.delegate = self
        resposTableView.dataSource = self
        resposTableView.register(UINib.init(nibName: "ResposTableCell", bundle: nil), forCellReuseIdentifier: "ResposTableCell")
        
        filterSearchBar.delegate = self
        
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: " ")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        resposTableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: Any) {
        addIndicator()
        DataCache.instance.clean(byKey: "resposList")
        self.whichList = 1
        getRespos(page: self.page)
    }
    override func viewWillAppear(_ animated: Bool) {
        if (DataCache.instance.readObject(forKey: "resposList") != nil) {
            self.whichList = 2
            self.cachResposlist = DataCache.instance.readObject(forKey: "resposList") as! [RespocacheModel]
            self.filterCachResposlist = self.cachResposlist
        }else{

            getRespos(page: self.page)
        }
        localNotification()
    }
    func getRespos(page: Int)  {
        let urlMain = NSURLComponents(string: Urls.main)!
        urlMain.queryItems = [URLQueryItem(name: "page", value: String(page)), URLQueryItem(name: "per_page", value: "10")]
        
        Network.shared.getData([ReposElementModel].self, url: urlMain.url!, parameters: nil, method: .get) { (error, data) in
            self.refreshControl.endRefreshing()
            self.activityIndicatorView.stopAnimating()
            self.VW_overlay.removeFromSuperview()
            if let error = error {
                print(error)
            }else if let data = data {
                self.resposlist = data
                self.filterResposlist = self.resposlist
                self.resposTableView.reloadData()
            }
        }
    }
    
    func getMoreRespos(page: Int)  {
        let urlMain = NSURLComponents(string: Urls.main)!
        urlMain.queryItems = [URLQueryItem(name: "page", value: String(page)), URLQueryItem(name: "per_page", value: "10")]
        
        Network.shared.getData([ReposElementModel].self, url: urlMain.url!, parameters: nil, method: .get) { (error, data) in
            if let error = error {
                print(error)
            }else if let data = data {
                self.resposlist += data
                self.filterResposlist = self.resposlist
                self.resposTableView.reloadData()
                self.saveToCache()
            }
        }
    }
    func saveToCache() {
        self.cachResposlist = [RespocacheModel]()
        DataCache.instance.clean(byKey: "resposList")
        var item = RespocacheModel()
        print(resposlist.count)
        for (_, element) in self.resposlist.enumerated() {
            item.avater = (element.owner?.avatarURL) ?? ""
            item.userName = (element.owner?.login) ?? ""
            item.ReposName = element.name ?? ""
            item.descrip = element.reposModelDescription ?? ""
            item.ownerURL = (element.owner?.htmlURL) ?? ""
            item.reposURL = element.htmlURL ?? ""
            item.fork = element.fork
            self.cachResposlist.append(item)
            item = RespocacheModel()
        }
        DataCache.instance.write(array: self.cachResposlist, forKey: "resposList")
        
    }

    func addIndicator() {
        VW_overlay = UIView(frame: UIScreen.main.bounds)
        VW_overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: activityIndicatorView.bounds.size.width, height: activityIndicatorView.bounds.size.height)
        
        activityIndicatorView.center = VW_overlay.center
        VW_overlay.addSubview(activityIndicatorView)
        VW_overlay.center = view.center
        view.addSubview(VW_overlay)
        
        activityIndicatorView.startAnimating()
    }
    
    func localNotification()  {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "New Data"
        content.body = "new repostories upload"
        content.sound = .default
        content.userInfo = ["value": "Data with local notification"]
        
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(3600))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.whichList != 1 {
            return self.filterCachResposlist.count
        }else {
            return self.filterResposlist.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResposTableCell", for: indexPath) as! ResposTableCell
        cell.selectionStyle = .none
        var fork: Bool!
        if self.whichList != 1 {
            fork = self.filterCachResposlist[indexPath.row].fork
            cell.cellCacheObject = self.filterCachResposlist[indexPath.row]
        }else {
            if self.filterResposlist.count != 0 {
               
                fork = self.filterResposlist[indexPath.row].fork
                cell.cellObject = self.filterResposlist[indexPath.row]
                if searchCase == false {
                    if indexPath.row == filterResposlist.count - 1 {
                        self.page += 1
                        self.getMoreRespos(page: self.page)
                    }
                }
            }
        }
        
        switch  fork{
        case true:
            cell.cellView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.descriptionTV.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.descriptionTV.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case false:
            cell.cellView.backgroundColor = #colorLiteral(red: 0.3996865149, green: 0.8646980246, blue: 0.3357847699, alpha: 1)
            cell.descriptionTV.backgroundColor = #colorLiteral(red: 0.3996865149, green: 0.8646980246, blue: 0.3357847699, alpha: 1)
        case .none:
            cell.cellView.backgroundColor = #colorLiteral(red: 0.3996865149, green: 0.8646980246, blue: 0.3357847699, alpha: 1)
            cell.descriptionTV.backgroundColor = #colorLiteral(red: 0.3996865149, green: 0.8646980246, blue: 0.3357847699, alpha: 1)
        case .some(_):
            cell.cellView.backgroundColor = #colorLiteral(red: 0.3996865149, green: 0.8646980246, blue: 0.3357847699, alpha: 1)
            cell.descriptionTV.backgroundColor = #colorLiteral(red: 0.3996865149, green: 0.8646980246, blue: 0.3357847699, alpha: 1)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var reposString, OwnerProfileString: String!
        if self.whichList != 1 {
            let item = self.cachResposlist[indexPath.row]
            reposString = item.reposURL
            OwnerProfileString = item.ownerURL
        }else {
            let item = self.resposlist[indexPath.row]
            reposString = item.htmlURL
            OwnerProfileString = item.owner?.htmlURL

        }
        let openAction = UITableViewRowAction(style: .default, title: "browse" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            // 2
            let openMenu = UIAlertController(title: nil, message: "open browser with", preferredStyle: .actionSheet)
            
            let repositoryAction = UIAlertAction(title: "show repository", style: .default, handler: { (action:UIAlertAction!) in
                UIApplication.shared.open(URL(string: reposString!)!, options: [:], completionHandler: nil)
                
            })
            let ownerAction = UIAlertAction(title: "show owner porfile", style: .cancel, handler: { (action:UIAlertAction!) in
                
                UIApplication.shared.open(URL(string: OwnerProfileString!)!, options: [:], completionHandler: nil)
                
            })
            
            openMenu.addAction(repositoryAction)
            openMenu.addAction(ownerAction)
            
            self.present(openMenu, animated: true, completion: nil)
        })
  
        return [openAction]
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.whichList != 1 {
            guard !searchText.isEmpty else {
                filterCachResposlist = cachResposlist
                self.resposTableView.reloadData()
                return
            }
            filterCachResposlist = cachResposlist.filter({ (respocacheModel) -> Bool in
                guard let searchTxt = filterSearchBar.text else {return false}
                return (respocacheModel.ReposName.contains(searchTxt))
            })
            self.resposTableView.reloadData()
        }else {
            guard !searchText.isEmpty else {
                filterResposlist = resposlist
                self.resposTableView.reloadData()
                searchCase = false
                return
            }
            filterResposlist = resposlist.filter { (reposElementModel) -> Bool in
                guard let searchTxt = filterSearchBar.text else {return false}
                return (reposElementModel.name?.contains(searchTxt))!
            }
            searchCase = true
            self.resposTableView.reloadData()
        }
    }
}

