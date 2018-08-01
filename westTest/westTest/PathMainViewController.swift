//
//  PathMainViewController.swift
//  westTest
//
//  Created by Azadeh on 7/31/18.
//  Copyright © 2018 Azadeh. All rights reserved.
//

import UIKit

class PathMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dict = getjsonConvertToDictionry()
        print(dict ?? "test Data")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getjsonConvertToDictionry()-> [String:Any]?{

        var  path : String = ""

        path = Bundle.main.path(forResource: "facts" ,ofType: "json")!

        do{
            let data =  try Data.init(contentsOf: URL(fileURLWithPath: path))
            print(data)
           return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        }
        catch let error{

            print(error)

            }

        return nil

    }

}
