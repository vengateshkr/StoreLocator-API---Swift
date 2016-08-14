//
//  ViewController.swift
//  StoreLocator
//
//  Created by ctsuser1 on 6/12/16.
//  Copyright © 2016 ctsuser1. All rights reserved.
//

import Foundation
class ViewController: UIViewController
{
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var tableView: UITableView!
    var isSlide : Bool = true
    var selectedIndexesArr : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "revealicon@2x.png")
        let homeButton : UIBarButtonItem = UIBarButtonItem(image:image,style: UIBarButtonItemStyle.Plain, target: self, action: #selector(slideOut))
        
        self.navigationItem.leftBarButtonItem = homeButton
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        //self.tableView.head
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.title = "Store Locator"
    }
    
    func slideOut(sender: AnyObject) {
        self.view.layoutIfNeeded()
        if (self.isSlide) {
            UIView.animateWithDuration(0.5, animations: {
                self.rightConstraint.constant = 400
                self.isSlide=false
                self.view.layoutIfNeeded()
            })
        }
        else
        {
            UIView.animateWithDuration(0.5, animations: {
                self.rightConstraint.constant = 0
                self.view.layoutIfNeeded()
                self.isSlide = true
            })
        }
    }
    
    @IBAction func findStores(sender: AnyObject) {
        self.performSegueWithIdentifier("toMapVC", sender: sender)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return appDelegate.optDescArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = appDelegate.optDescArr[indexPath.row]
        
        if self.selectedIndexesArr.count > 0 && self.selectedIndexesArr.contains(indexPath.row) {
            cell.accessoryType = .Checkmark
        }
        else{
            cell.accessoryType = .None
        }
        cell.selectionStyle = .None
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
            appDelegate.selectedOptionsArr.removeObject(appDelegate.optArr[indexPath.row])
            self.selectedIndexesArr.removeObject(indexPath.row)
            }
            else
            {
                cell.accessoryType = .Checkmark
            self.selectedIndexesArr.append(indexPath.row)
            appDelegate.selectedOptionsArr.append(appDelegate.optArr[indexPath.row])
            }
        }
    }
    
}


func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
{
    return 40.0
}

// Swift 2 Array Extension
extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}