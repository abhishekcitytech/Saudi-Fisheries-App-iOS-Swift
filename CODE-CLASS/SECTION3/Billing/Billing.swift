//
//  Billing.swift
//  Saudi Fisheries
//
//  Created by Sandipan on 01/05/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class Billing: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var loadingCircle = UIView()
    var circle = UIView()
    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tableLine: UITableView!
    
    var arrMAddress = NSMutableArray()
    
    var strAddressId = String()
    var selectedRows:[IndexPath] = []
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.getBillingAddressList()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        //let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.tableLine.backgroundView=nil
        self.tableLine.backgroundColor=UIColor.clear
        self.tableLine.separatorColor=UIColor.clear
        self.tableLine.register(UINib(nibName: "BTCell", bundle: nil), forCellReuseIdentifier: "BTCell")
    }
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - pressContinue method
    @IBAction func pressContinue(_ sender: Any)
    {
        self.setBillingAddress(strAddressId: strAddressId)
    }
    
    
    // MARK: - tableView delegate and datasoruce Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMAddress.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BTCell", for: indexPath) as! BTCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        
        let dictemp: NSDictionary = arrMAddress[indexPath.row] as! NSDictionary
        let  strId = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        let  strFirstName = String(format: "%@", dictemp.value(forKey: "FirstName") as! CVarArg)
        let  strLastName = String(format: "%@", dictemp.value(forKey: "LastName") as! CVarArg)
        let  strAddress1 = String(format: "%@", dictemp.value(forKey: "Address1") as! CVarArg)
        let  strAddress2 = String(format: "%@", dictemp.value(forKey: "Address2") as! CVarArg)
        let  strCity = String(format: "%@", dictemp.value(forKey: "City") as! CVarArg)
        let  strZipPostalCode = String(format: "%@", dictemp.value(forKey: "ZipPostalCode") as! CVarArg)
        let  strPhoneNumber = String(format: "%@", dictemp.value(forKey: "PhoneNumber") as! CVarArg)
        
        cell.lbl1.text = String(format: "%@ %@", strFirstName,strLastName)
        cell.lbl2.text = String(format: "%@,%@,%@,%@", strAddress1,strAddress2,strCity,strZipPostalCode)
        cell.lbl3.text = String(format: "%@", strPhoneNumber)
        
        if selectedRows.contains(indexPath){
            cell.btnCheckUnCheck.setBackgroundImage(UIImage(named:"radiocheck"), for: .normal)
        }else{
            cell.btnCheckUnCheck.setBackgroundImage(UIImage(named:"radiouncheck"), for: .normal)
        }
        cell.btnCheckUnCheck.tag = indexPath.row
        cell.btnCheckUnCheck.addTarget(self, action: #selector(checkBoxSelection(_:)), for: .touchUpInside)
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 119.5, width: tableView.frame.size.width, height: 0.5))
        labelSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(labelSeparator)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
    }
    @objc func checkBoxSelection(_ sender:UIButton)
    {
        let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
        if self.selectedRows.contains(selectedIndexPath){
            self.selectedRows.remove(at: self.selectedRows.index(of: selectedIndexPath)!)
        }else{
            self.selectedRows.removeAll()
            self.selectedRows.append(selectedIndexPath)
            
            let dictemp: NSDictionary = arrMAddress[selectedIndexPath.row] as! NSDictionary
            strAddressId = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
            print(dictemp)
            print(strAddressId)
        }
        self.tableLine.reloadData()
    }
    func getAllIndexPaths() -> [IndexPath]
    {
        var indexPaths: [IndexPath] = []
        for j in 0..<tableLine.numberOfRows(inSection: 0) {
            indexPaths.append(IndexPath(row: j, section: 0))
        }
        return indexPaths
    }
    
    
    // MARK: - showLoadingMode Method
    func showLoadingMode()
    {
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
        }
        
        loadingCircle = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        loadingCircle.backgroundColor = UIColor.black
        loadingCircle.alpha = 0.6
        
        circle = UIView ()
        circle.backgroundColor = UIColor.white
        circle.alpha = 1.0
        let size = 60
        let size1 = 60
        var frame = circle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
        circle.frame = frame
        circle.center = self.view.center
        circle.layer.cornerRadius = 30.0
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor=UIColor.white.cgColor
        circle.layer.masksToBounds = true
        
        /*let imgvLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
         imgvLogo.backgroundColor = UIColor.clear
         imgvLogo.image = UIImage(named:"productlogo")
         circle.addSubview(imgvLogo)*/
        
        let  animatedImageView =  UIImageView(frame: circle.bounds)
        animatedImageView.animationImages = NSArray(objects:UIImage(named: "frame-0.png")!,
                                                    UIImage(named: "frame-1.png")!,
                                                    UIImage(named: "frame-2.png")!,
                                                    UIImage(named: "frame-3.png")!,
                                                    UIImage(named: "frame-4.png")!,
                                                    UIImage(named: "frame-5.png")!,
                                                    UIImage(named: "frame-6.png")!,
                                                    UIImage(named: "frame-7.png")!,
                                                    UIImage(named: "frame-8.png")!,
                                                    UIImage(named: "frame-9.png")!,
                                                    UIImage(named: "frame-10.png")!,
                                                    UIImage(named: "frame-11.png")!,
                                                    UIImage(named: "frame-12.png")!,
                                                    UIImage(named: "frame-13.png")!,
                                                    UIImage(named: "frame-14.png")!,
                                                    UIImage(named: "frame-15.png")!,
                                                    UIImage(named: "frame-16.png")!,
                                                    UIImage(named: "frame-17.png")!,
                                                    UIImage(named: "frame-18.png")!,
                                                    UIImage(named: "frame-19.png")!,
                                                    UIImage(named: "frame-20.png")!,
                                                    UIImage(named: "frame-21.png")!,
                                                    UIImage(named: "frame-22.png")!,
                                                    UIImage(named: "frame-23.png")!,
                                                    UIImage(named: "frame-24.png")!,
                                                    UIImage(named: "frame-25.png")!,
                                                    UIImage(named: "frame-26.png")!,
                                                    UIImage(named: "frame-27.png")!,
                                                    UIImage(named: "frame-28.png")!,
                                                    UIImage(named: "frame-29.png")!) as? [UIImage]
        
        animatedImageView.animationDuration = 9
        animatedImageView.animationRepeatCount = 0
        animatedImageView.startAnimating()
        circle.addSubview(animatedImageView)
        circle.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        
        self.view.addSubview(circle)
        self.view.addSubview(loadingCircle)
        self.view.bringSubviewToFront(circle)
        
        
    }
    func hideLoadingMode()
    {
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
            self.circle.removeFromSuperview()
        }
    }
    
    
    //MARK: - get Billing Address List method
    func getBillingAddressList()
    {
        self.showLoadingMode()
        
        let dicUser = UserDefaults.standard.value(forKey: "RegisteredUserDetails") as! NSMutableDictionary
        //print(dicUser)
        let  strCustomerid = String(format: "%@", dicUser.value(forKey: "id") as! CVarArg)
        let strSlectedStoreID = String(format: "%@", UserDefaults.standard.string(forKey: "SelectedStoreID")!)
        
        let strapikey = String(format: "%@ %@", UserDefaults.standard.string(forKey: "token_type")!, UserDefaults.standard.string(forKey: "access_token")!)
        let strconnurl = String(format: "%@%@%@", Constants.conn.ConnUrl, "/api/getbillingaddress/",strCustomerid)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue(strapikey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                self.hideLoadingMode()
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    print("json --->",json)
                    
                    let dictemp = NSMutableDictionary(dictionary: json)
                    
                    let Status = String(format: "%@", dictemp.value(forKey: "Status") as! CVarArg)
                    let ResponseMessage = String(format: "%@", dictemp.value(forKey: "ResponseMessage") as! CVarArg)
                    
                    let Data = dictemp.value(forKey: "Data") as! NSDictionary
                    let arrMaddr = Data.value(forKey: "ExistingAddresses") as! NSArray
                    self.arrMAddress = NSMutableArray(array: arrMaddr)
                    print("arrMAddress --->",self.arrMAddress)
                    
                    OperationQueue.main.addOperation {
                        self.tableLine.reloadData()
                    }
                }
            }
            catch {
                //check for internal server data error
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - set BillingAddress method
    func setBillingAddress(strAddressId:String)
    {
        self.showLoadingMode()
      
        let dicUser = UserDefaults.standard.value(forKey: "RegisteredUserDetails") as! NSMutableDictionary
        let  strCustomerid = String(format: "%@", dicUser.value(forKey: "id") as! CVarArg)
        let strSlectedStoreID = String(format: "%@", UserDefaults.standard.string(forKey: "SelectedStoreID")!)
        
        let strapikey = String(format: "%@ %@", UserDefaults.standard.string(forKey: "token_type")!, UserDefaults.standard.string(forKey: "access_token")!)
        let strconnurl = String(format: "%@%@customerId=%@&storeId=%@&addressId=%@&shipToSameAddress=%@", Constants.conn.ConnUrl, "/api/savebillingaddress?",strCustomerid,strSlectedStoreID,strAddressId,"true")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue(strapikey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                self.hideLoadingMode()
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    print("json --->",json)
                    
                    let dictemp = NSMutableDictionary(dictionary: json)
                    let Status = String(format: "%@", dictemp.value(forKey: "Status") as! CVarArg)
                    let ResponseMessage = String(format: "%@", dictemp.value(forKey: "ResponseMessage") as! CVarArg)
                    
                    OperationQueue.main.addOperation {
                        if Status == "1"
                        {
                            let screenSize = UIScreen.main.bounds
                            if (screenSize.height == 568.0){
                            }
                            else if (screenSize.height == 480.0){
                            }
                            else if(screenSize.height == 667.0){
                                let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                                let PickupShipping = storyBoard.instantiateViewController(withIdentifier: "PickupShipping") as! PickupShipping
                                PickupShipping.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(PickupShipping, animated: true)
                            }
                            else if(screenSize.height == 736.0){
                                let storyBoard = UIStoryboard(name: "SectionThree6SPlus", bundle: nil)
                                let PickupShipping = storyBoard.instantiateViewController(withIdentifier: "PickupShipping") as! PickupShipping
                                PickupShipping.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(PickupShipping, animated: true)
                            }
                            else if(screenSize.height == 812.0){
                                let storyBoard = UIStoryboard(name: "SectionThreeXS", bundle: nil)
                                let PickupShipping = storyBoard.instantiateViewController(withIdentifier: "PickupShipping") as! PickupShipping
                                PickupShipping.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(PickupShipping, animated: true)
                            }
                            else{
                                let storyBoard = UIStoryboard(name: "SectionThreeXSMAX", bundle: nil)
                                let PickupShipping = storyBoard.instantiateViewController(withIdentifier: "PickupShipping") as! PickupShipping
                                PickupShipping.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(PickupShipping, animated: true)
                            }
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}