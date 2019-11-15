//
//  ViewController.swift
//  Engineer.ai_vart
//
//  Created by MAC99 on 11/15/19.
//  Copyright © 2019 MAC99. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var tblView: UITableView!
    
    //MARK: Variables
    var offset : Int = 0
    var limit : Int = 10
    var responseData : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInterface()
        self.callAPI()
    }

    private func setInterface(){
        self.title = "User Image List"
        self.tblView.register(UINib(nibName: "SingleImageTableCell", bundle: nil), forCellReuseIdentifier: "SingleImageTableCell")
        self.tblView.register(UINib(nibName: "DoubleImageTableCell", bundle: nil), forCellReuseIdentifier: "DoubleImageTableCell")
        self.tblView.register(UINib(nibName: "LoadingTableCell", bundle: nil), forCellReuseIdentifier: "LoadingTableCell")
    }
    private func callAPI(){
        if responseData != nil{
//            if responseData?.has_more == false{
//                return
//            }
            if let userCountResponded = responseData?.users?.count{
                offset = userCountResponded
            }
        }
        let sourceURL = "http://sd2-hiring.herokuapp.com/api/users?offset=" + "\(offset)" + "&limit=" + "\(limit)"
        Alamofire.request(sourceURL).responseData { (response) in
            
            if response.result.isSuccess{
                if let data = response.result.value, let resp = try? JSONDecoder().decode(ResponseBase.self, from: data)
                {
                   print(data)
                   print(resp)
                    if self.offset == 0{
                        self.responseData = resp.data
                    }
                    else{
                        if let users = resp.data?.users{
                            for user in users {
                                self.responseData!.users!.append(user)
                            }
                            self.responseData!.has_more = resp.data!.has_more
                        }
                    }
                   self.tblView.reloadData()
                }
                
            }
            else{
                
            }
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if responseData != nil{
            if responseData!.has_more{ // to show load more
                if let count = self.responseData?.users?.count{
                    return count + 1
                }
            }
            else{
                if let count = self.responseData?.users?.count{
                    return count
                }
            }
        }

        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.responseData?.users?.count{
            if section < count {
                if let count = self.responseData?.users?[section].items?.count{
                    let value = count / 2
                    if count % 2 == 0{
                        return value + 1
                    }
                    else{
                        return value + 2
                    }
                }
            }
            else{
                // loading cell
                return 1
            }
        }
       
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var sectionCount = 0
        if let count = self.responseData?.users?.count{
            sectionCount = count
        }
        if indexPath.section < sectionCount{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
                if let user = responseData?.users?[indexPath.section]{
                    cell.lblUserName.text = user.name
                    if let imageURL = user.image
                    {
                        cell.imvUserImage.sd_setImage(with: URL(string: imageURL), completed: nil)
                    }
                }
                return cell
            }
            else{
                var itemsCount = 0
                if let count = self.responseData?.users?[indexPath.section].items?.count{
                    itemsCount = count
                }
                if itemsCount % 2 == 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleImageTableCell", for: indexPath) as! DoubleImageTableCell
                    if let items = responseData?.users?[indexPath.section].items{
                        cell.imvItemImage1?.sd_setImage(with: URL(string: items[ (indexPath.row * 2) - 1] ), completed: nil)
                        cell.imvItemImage2?.sd_setImage(with: URL(string: items[ (indexPath.row * 2) - 2] ), completed: nil)
                    }
                    return cell
                }
                else{
                    if (indexPath.row == 1){
                        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleImageTableCell", for: indexPath) as! SingleImageTableCell
                        
                        if let items = responseData?.users?[indexPath.section].items{
                            cell.imvItemImage?.sd_setImage(with:  URL(string: items[indexPath.row - 1]) , completed: nil)
                        }
                        
                        return cell
                    }
                    else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleImageTableCell", for: indexPath) as! DoubleImageTableCell
                        if let items = responseData?.users?[indexPath.section].items{
                            cell.imvItemImage1?.sd_setImage(with: URL(string:items[(indexPath.row * 2) - 2]), completed: nil)
                            cell.imvItemImage2?.sd_setImage(with: URL(string:items[(indexPath.row * 2) - 3]), completed: nil)
                        }
                        return cell
                    }
                    
                }
            }
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableCell", for: indexPath) as! LoadingTableCell
            self.callAPI()
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let count = self.responseData?.users?.count{
//            if indexPath.section < count {
//                if let count = self.responseData?.users?[indexPath.section].items?.count{
//                    if count % 2 == 0{
//                        if (indexPath.row == 0){
//                            return 70.0
//                        }
//                        return UIScreen.main.bounds.size.width - 30 / 2
//                    }
//                    else{
//                        if (indexPath.row == 0){
//                            return 70.0
//                        }else if (indexPath.row == 1){
//                            return UIScreen.main.bounds.size.width - 20
//                        }
//                        
//                        return UIScreen.main.bounds.size.width - 30 / 2
//                    }
//                }
//            }
//            else{
//                // loading cell
//                return 50.0
//            }
//        }
//        return 0
//    }
}
