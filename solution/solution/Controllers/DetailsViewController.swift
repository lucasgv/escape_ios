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
    @IBOutlet weak var labelGroupDetails: UILabel!
    @IBOutlet weak var labelGroupName: UILabel!
    @IBOutlet weak var labelEvent1: UILabel!
    @IBOutlet weak var labelDescription1: UILabel!
    @IBOutlet weak var labelDate1: UILabel!
    @IBOutlet weak var labelEvent2: UILabel!
    @IBOutlet weak var labelDescription2: UILabel!
    @IBOutlet weak var labelDate2: UILabel!
    @IBOutlet weak var buttonEvent1: UIButton!
    @IBOutlet weak var buttonEvent2: UIButton!
    @IBOutlet weak var buttonParticipant: UIButton!
    
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
    
    @IBAction func pressEvent1(_ sender: UIButton) {
        self.setSelectedButton(button: sender)
    }
    
    @IBAction func pressEvent2(_ sender: UIButton) {
        self.setSelectedButton(button: sender)
    }
    
    @IBAction func pressParticipant(_ sender: UIButton) {
        if buttonEnter.currentTitle == "VOU PARTICIPAR!" {
            self.buttonEnter.setTitle("PARTICIPANDO!", for: .normal)
        } else {
            self.buttonEnter.setTitle("VOU PARTICIPAR!", for: .normal)
        }
        self.setSelectedButtonOrHide(button: buttonParticipant)
    }
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressConfirm(_ sender: UIButton) {
        if buttonEnter.currentTitle == "VOU PARTICIPAR!" {
            self.buttonEnter.setTitle("PARTICIPANDO!", for: .normal)
        } else {
            self.buttonEnter.setTitle("VOU PARTICIPAR!", for: .normal)
        }
        self.setSelectedButtonOrHide(button: buttonParticipant)
    }
    
    // MARK: - Private
    
    func setSelectedButton(button : UIButton) {
        if button.currentImage == #imageLiteral(resourceName: "group") {
            if self.selectedGroup.category == "ciclismo" {
                button.setImage(#imageLiteral(resourceName: "participarGreen"), for: .normal)
            } else if self.selectedGroup.category == "corrida" {
                button.setImage(#imageLiteral(resourceName: "participarOrange"), for: .normal)
            } else if self.selectedGroup.category == "caminhada" {
                button.setImage(#imageLiteral(resourceName: "participarBlue"), for: .normal)
            }
        } else {
            button.setImage(#imageLiteral(resourceName: "group"), for: .normal)
        }
    }
    
    func setSelectedButtonOrHide(button : UIButton) {
        if button.isHidden {
            if self.selectedGroup.category == "ciclismo" {
                button.setImage(#imageLiteral(resourceName: "participarGreen"), for: .normal)
                button.isHidden = false
            } else if self.selectedGroup.category == "corrida" {
                button.setImage(#imageLiteral(resourceName: "participarOrange"), for: .normal)
                button.isHidden = false
            } else if self.selectedGroup.category == "caminhada" {
                button.setImage(#imageLiteral(resourceName: "participarBlue"), for: .normal)
                button.isHidden = false
            }
        } else {
            button.isHidden = true
        }
    }
    
    func setGroupInfo() {
        self.labelName.text = self.selectedGroup.name
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
        
        if (self.selectedGroup.events?.count)! >= 2 {
            self.labelEvent1.text = self.selectedGroup.events![0].name
            self.labelDescription1.text = self.selectedGroup.events![0].description
            self.labelDate1.text = self.selectedGroup.events![0].date
            self.labelEvent2.text = self.selectedGroup.events![1].name
            self.labelDescription2.text = self.selectedGroup.events![1].description
            self.labelDate2.text = self.selectedGroup.events![1].date
        }
    }
    
    func customizeViewDetailPin() {
        self.viewDetails.layer.cornerRadius = 8
        self.viewDetails.layer.masksToBounds = true
        self.buttonEnter.layer.cornerRadius = 8
        self.buttonEnter.layer.masksToBounds = true
        self.viewLine.backgroundColor = self.selectedGroup.degradeColor
        self.buttonEnter.backgroundColor = self.selectedGroup.degradeColor
        
        self.view.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
        if translation.y > 100 {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
