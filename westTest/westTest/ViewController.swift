//
//  ViewController.swift
//  westTest
//
//  Created by Azadeh on 7/31/18.
//  Copyright © 2018 Azadeh. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var infoArr : [InfoObject] = []
    var titleStr : String? = ""

    var refreshControl = UIRefreshControl()
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

       let  data = getJson(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")

       convertToDictionry(strData: data)

        setPullToRefreshControl()

       navigationItem.title = self.titleStr!

        self.tableView.register(UINib(nibName : "InfoTableViewCell" , bundle : nil), forCellReuseIdentifier: "InfoTableViewCellID")

        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.refreshControl.endRefreshing()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//convert json data to data string
    func getJson(urlString : String) -> String{
        var jsonData : Data!
        var dataStr : String! = ""
        let urlstr : URL = URL.init(string: urlString)!
        do
        {
           jsonData = try Data.init(contentsOf: urlstr)

            dataStr = String(data:jsonData ,encoding:.ascii)
            print(dataStr)
        }
        catch let errno{

            print(errno)

        }
        return dataStr
    }

//convert data string to data object and array List
    @objc func convertToDictionry(strData:String) {

        var dataDict : [String : Any] = [String : Any]()
        if let data = strData.data(using: .utf8){

        do{
            dataDict = (try JSONSerialization.jsonObject(with: data , options: []) as? [String:Any])!

            }
        catch let error{
            print(error)
            }

            self.infoArr = self.parseInfo(inputArr: dataDict["rows"] as! [[String : Any]])
            self.titleStr = dataDict["title"] as? String
            self.tableView.reloadData()

            self.refreshControl.endRefreshing()
        }
    }

    func setPullToRefreshControl(){

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(convertToDictionry(strData:)), for: UIControlEvents.touchDown)

        tableView.addSubview(refreshControl)
        refreshControl.tintColor = .gray
        }

    func parseInfo(inputArr : [[String:Any]]) ->[InfoObject]{

        var muArr : [InfoObject] = []
        for dict in inputArr{
            let infoObj = InfoObject()

            infoObj.descriptionStr = dict["description"] as?String
            infoObj.imageHref = dict["imageHref"] as? String
            infoObj.title = dict["title"] as? String

            muArr.append(infoObj)
        }
        return muArr

        }

    //Mark : -tableView

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCellID", for: indexPath) as? InfoTableViewCell

        let infoObj = self.infoArr[indexPath.row]

        cell?.descriptionLabel.text = infoObj.descriptionStr
        cell?.titleLabel.text = infoObj.title

       if(infoObj.imageHref != nil){
            let url = URL(string:infoObj.imageHref!)
            cell?.imageInfo.kf.setImage(with: url)
       }
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


}
