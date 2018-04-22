//
//  DetailsViewController.swift
//  solution
//
//  Created by Lucas Goes Valle on 22/04/2018.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import UIKit
import ChameleonFramework

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - IBOutlets

    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelParticipants: UILabel!
    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDeparture: UILabel!
    @IBOutlet weak var labelArrival: UILabel!
    @IBOutlet weak var labelDepartureTime: UILabel!
    @IBOutlet weak var labelArrivalTime: UILabel!
    @IBOutlet weak var labelCountPeople: UILabel!
    @IBOutlet weak var labelHour: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var buttonEnter: UIButton!
    @IBOutlet weak var buttonMoreInfo: UIButton!
    @IBOutlet weak var labelGroupDetails: UILabel!
    @IBOutlet weak var labelGroupName: UILabel!
    @IBOutlet weak var buttonCustomization: UIButton!
    
    // MARK: - Variables
    
    var selectedGroup : Group!
    
    // MARK: - Lyfe Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGroupInfo()
        self.customizeViewDetailPin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBOutlets
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressConfirm(_ sender: Any) {
        self.buttonEnter.setTitle("PARTICIPANDO!", for: .normal)
    }
    
    // MARK: - Private
    
    func setGroupInfo() {
        self.labelName.text = self.selectedGroup.name
        self.labelParticipants.text = String(format: "%i participantes",(self.selectedGroup.participants?.count)!)
        self.labelDeparture.text = self.selectedGroup.departureName
        self.labelArrival.text = self.selectedGroup.arrivalName
        let url = URL(string: self.selectedGroup.imageFolder)
        
        self.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
        self.labelDescription.text = self.selectedGroup.description
        self.labelCountPeople.text = String(format: "%i",(self.selectedGroup.participants?.count)!)
        self.labelLevel.text = self.selectedGroup.level
        self.labelHour.text = self.selectedGroup.estimatedTime
        self.labelArrivalTime.text = self.selectedGroup.endTime
        self.labelArrivalTime.text = self.selectedGroup.startTime
        self.imageViewCategory.image = self.selectedGroup.categoryImage
    }
    
    func customizeViewDetailPin() {
        self.viewDetails.layer.cornerRadius = 8
        self.viewDetails.layer.masksToBounds = true
        self.buttonEnter.layer.cornerRadius = 8
        self.buttonEnter.layer.masksToBounds = true
        self.buttonMoreInfo.layer.cornerRadius = 8
        self.buttonMoreInfo.layer.masksToBounds = true
        self.viewLine.backgroundColor = self.selectedGroup.degradeColor
        self.buttonEnter.backgroundColor = self.selectedGroup.degradeColor
        self.buttonMoreInfo.backgroundColor = UIColor.white
        self.buttonMoreInfo.setTitleColor(self.selectedGroup.degradeColor, for: .normal)
        self.buttonMoreInfo.layer.borderColor = self.selectedGroup.degradeColor.cgColor
        self.buttonMoreInfo.layer.borderWidth = 2.0
        
        self.view.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
        if translation.y > 200 {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
