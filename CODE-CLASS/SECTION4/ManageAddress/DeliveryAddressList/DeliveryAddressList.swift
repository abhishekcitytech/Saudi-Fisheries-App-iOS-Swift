//
//  DeliveryAddressList.swift
//  Saudi Fisheries
//
//  Created by Sandipan on 29/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class DeliveryAddressList: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {

    var loadingCircle = UIView()
    var circle = UIView()
    
    @IBOutlet var btnAddNewAddress: UIButton!
    
    @IBOutlet var tabvAddress: UITableView!
    let cellReuseIdentifier = "cell"
    var stridentifer = NSString()
    
    var arrMAddressList = NSMutableArray()
    
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        self.getShippingAddressList()
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        //let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.tabvAddress.backgroundView=nil
        self.tabvAddress.backgroundColor=UIColor.clear
        self.tabvAddress.separatorColor=UIColor.clear
        self.tabvAddress.register(UINib(nibName: "DACell", bundle: nil), forCellReuseIdentifier: "DACell")
    }

    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate and datasoruce Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMAddressList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DACell", for: indexPath) as! DACell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dictemp: NSDictionary = self.arrMAddressList[indexPath.item] as! NSDictionary
        
        let  Id = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        let  FirstName = String(format: "%@", dictemp.value(forKey: "FirstName") as! CVarArg)
        let  LastName = String(format: "%@", dictemp.value(forKey: "LastName") as! CVarArg)
        let  Email = String(format: "%@", dictemp.value(forKey: "Email") as! CVarArg)
        let  PhoneNumber = String(format: "%@", dictemp.value(forKey: "PhoneNumber") as! CVarArg)
        
        let  Address1 = String(format: "%@", dictemp.value(forKey: "Address1") as! CVarArg)
        let  Address2 = String(format: "%@", dictemp.value(forKey: "Address2") as! CVarArg)
        let  City = String(format: "%@", dictemp.value(forKey: "City") as! CVarArg)
        let  CountryName = String(format: "%@", dictemp.value(forKey: "CountryName") as! CVarArg)
        let  ZipPostalCode = String(format: "%@", dictemp.value(forKey: "ZipPostalCode") as! CVarArg)
        
        cell.lblName.text = String(format: "%@ %@", FirstName,LastName)
        cell.lblAddress.text = String(format: "%@,%@,%@,%@,%@", Address1,Address2,City,ZipPostalCode,CountryName)
        cell.lblMobileno.text = PhoneNumber
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 129.5, width: tableView.frame.size.width, height: 0.5))
        labelSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(labelSeparator)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    // MARK: - press AddNewAddress method
    @IBAction func pressAddNewAddress(_ sender: Any)
    {
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
            let AddDeliveryAddress = storyBoard.instantiateViewController(withIdentifier: "AddDeliveryAddress") as! AddDeliveryAddress
            AddDeliveryAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(AddDeliveryAddress, animated: true)
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionFour6SPlus", bundle: nil)
            let AddDeliveryAddress = storyBoard.instantiateViewController(withIdentifier: "AddDeliveryAddress") as! AddDeliveryAddress
            AddDeliveryAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(AddDeliveryAddress, animated: true)
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionFourXS", bundle: nil)
            let AddDeliveryAddress = storyBoard.instantiateViewController(withIdentifier: "AddDeliveryAddress") as! AddDeliveryAddress
            AddDeliveryAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(AddDeliveryAddress, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionFourXSMAX", bundle: nil)
            let AddDeliveryAddress = storyBoard.instantiateViewController(withIdentifier: "AddDeliveryAddress") as! AddDeliveryAddress
            AddDeliveryAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(AddDeliveryAddress, animated: true)
        }
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
    
    //MARK: - get Shipping Address List method
    func getShippingAddressList()
    {
        self.showLoadingMode()
        
        var  strCustomerid = String()
        if UserDefaults.standard.value(forKey: "RegisteredUserDetails") == nil{
            print("emplty")
            strCustomerid = String(format: "%@", "")
        }
        else{
            let dicUser = UserDefaults.standard.value(forKey: "RegisteredUserDetails") as! NSMutableDictionary
            //print(dicUser)
            strCustomerid = String(format: "%@", dicUser.value(forKey: "id") as! CVarArg)
        }
        
        let strSlectedStoreID = String(format: "%@", UserDefaults.standard.string(forKey: "SelectedStoreID")!)
        
        let strapikey = String(format: "%@ %@", UserDefaults.standard.string(forKey: "token_type")!, UserDefaults.standard.string(forKey: "access_token")!)
        let strconnurl = String(format: "%@%@%@?storeid=%@", Constants.conn.ConnUrl, "/api/getshippingaddress/",strCustomerid,strSlectedStoreID)
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
                    self.arrMAddressList = NSMutableArray(array: arrMaddr)
                    print("arrMAddressList --->",self.arrMAddressList)
                    
                    OperationQueue.main.addOperation {
                        self.tabvAddress.reloadData()
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
