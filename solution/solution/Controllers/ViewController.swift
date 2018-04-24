//
//  ViewController.swift
//  solution
//
//  Created by Lucas Goes Valle on 21/04/2018.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseDatabase
import Kingfisher
import ChameleonFramework

class ViewController: UIViewController , GMSMapViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet var viewDetailPin: UIView!
    @IBOutlet var viewLineDetailPin: UIView!
    @IBOutlet weak var buttonViewDetailPinConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelParticipants: UILabel!
    @IBOutlet weak var labelDeparture: UILabel!
    @IBOutlet weak var labelArrival: UILabel!
    @IBOutlet weak var labelTimeArrival: UILabel!
    @IBOutlet weak var labelTimeDeparture: UILabel!
    @IBOutlet weak var imageViewMan: UIImageView!
    @IBOutlet weak var viewFilter: UIView!
    
    @IBOutlet weak var imageWalking: UIImageView!
    @IBOutlet weak var labelWalking: UILabel!
    @IBOutlet weak var imageRun: UIImageView!
    @IBOutlet weak var labelRun: UILabel!
    @IBOutlet weak var imageBike: UIImageView!
    @IBOutlet weak var labelBike: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: - Variables
    
    private let locationManager = CLLocationManager()
    private var databaseReference: DatabaseReference!
    var users: [User] = []
    var groups: [Group] = []
    var viewDetailPinOpened : Bool = false
    var selectedGroup : Group!
    var selectedFilterBike : Bool = true
    var selectedFilterRun : Bool = true
    var selectedFilterWalking : Bool = true
    
    // MARK: - Cycle View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initServices()
        self.getGroupsAndUsers()
        self.customizeViewDetailPin()
        self.customizeViewFilter()
    }
    
    // MARK: - Private
    
    func initServices() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.delegate = self
        self.databaseReference = Database.database().reference()
    }
    
    func customizeViewDetailPin() {
        self.viewDetailPin.layer.cornerRadius = 8
        self.viewDetailPin.layer.masksToBounds = true
        self.buttonViewDetailPinConstraint.constant = 187
        
        self.view.layoutIfNeeded()
    }
    
    func customizeViewFilter() {
        self.viewFilter.layer.cornerRadius = 8
        self.viewFilter.layer.masksToBounds = true
    }
    
    func getGroupsAndUsers() {
    self.databaseReference.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            
            guard let responseUsers = snapshot.childSnapshot(forPath: "users").value as? JSONArray else { return }
            for dict in responseUsers {
                let user = User(dictionary: dict)
                self.users.append(user)
            }
            
            guard let responseGroups = snapshot.childSnapshot(forPath: "groups").value as? JSONArray else { return }
            for dict in responseGroups {
                let group = Group(dictionary: dict)
                self.groups.append(group)
            }
            
            self.plotPins()
        })
    }
    
    func plotPins() {
        self.mapView.clear()
        for group in self.groups {
            let position = CLLocationCoordinate2D(latitude: group.arrivalLatitude, longitude: group.arrivalLongitude)
            let marker = GMSMarker(position: position)
            marker.isTappable = true
            let iconView : UIView
            if group.today && labelTitle.text == "ACONTECENDO HOJE" {
                iconView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 65))
            } else {
                iconView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
            }
            
            iconView.backgroundColor=UIColor.clear
            
            var imageViewForPinMarker : UIImageView
            if group.today && labelTitle.text == "ACONTECENDO HOJE" {
                imageViewForPinMarker  = UIImageView(frame:CGRect(x: 0, y: 0, width: 55, height: 65))
            } else {
                imageViewForPinMarker  = UIImageView(frame:CGRect(x: 0, y: 0, width: 35, height: 45))
            }
            imageViewForPinMarker.image = group.imageIcon
            
            var imageViewForUserProfile : UIImageView
            if group.today && labelTitle.text == "ACONTECENDO HOJE" {
                imageViewForUserProfile = UIImageView(frame:CGRect(x: 12, y: 10, width: 32, height: 32))
            } else {
                imageViewForUserProfile = UIImageView(frame:CGRect(x: 6, y: 6, width: 24, height: 24))
            }
            let url = URL(string: group.imageFolder)
            imageViewForUserProfile.kf.setImage(with: url)
            imageViewForUserProfile.layer.masksToBounds = true
            if group.today && labelTitle.text == "ACONTECENDO HOJE" {
                imageViewForUserProfile.layer.cornerRadius = 12
            } else {
                imageViewForUserProfile.layer.cornerRadius = 16
            }
            
            iconView.addSubview(imageViewForUserProfile)
            iconView.addSubview(imageViewForPinMarker)
            
            var iCanAdd : Bool = false
            if group.category == "ciclismo" && self.selectedFilterBike {
                iCanAdd = true
            } else if group.category == "corrida" && self.selectedFilterRun {
                iCanAdd = true
            } else if group.category == "caminhada" && self.selectedFilterWalking {
                iCanAdd = true
            }
            
            if iCanAdd {
                marker.iconView = iconView
                marker.map = self.mapView
                marker.userData = group
            }
        }
    }
    
    func setGroupInfo() {
        self.labelName.text = self.selectedGroup.name
        self.labelParticipants.text = String(format: "%i participantes",(self.selectedGroup.participants?.count)!)
        self.labelDeparture.text = self.selectedGroup.departureName
        self.labelArrival.text = self.selectedGroup.arrivalName
        self.viewLineDetailPin.backgroundColor = self.selectedGroup.degradeColor
        self.imageViewMan.image = self.selectedGroup.categoryImage
    }
    
    // MARK: - GMSMapView delegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let group = marker.userData as! Group
        if !self.viewDetailPinOpened || (self.selectedGroup != nil && self.selectedGroup.id != group.id) {
            self.selectedGroup = group
            self.showViewDetailPin()
            self.setGroupInfo()
        } else {
            self.hideViewDetailPin()
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    // MARK: - DetailPin Functions
    
    func hideViewDetailPin () {
        self.viewDetailPinOpened = false
        self.selectedGroup = nil
        self.buttonViewDetailPinConstraint.constant = 187
    }
    
    func showViewDetailPin () {
        self.viewDetailPinOpened = true
        self.buttonViewDetailPinConstraint.constant = 0
    }
    
    // MARK: - Segue delegates
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDetails" {
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.selectedGroup = self.selectedGroup
            self.hideViewDetailPin()
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBAction func pressSwipe(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueDetails", sender: self)
    }
    
    @IBAction func pressFilterWalking(_ sender: Any) {
        if self.selectedFilterWalking {
            self.imageWalking.image = #imageLiteral(resourceName: "caminhada-1")
            self.selectedFilterWalking = false
            self.labelWalking.textColor = UIColor.lightGray
        } else {
            self.imageWalking.image = #imageLiteral(resourceName: "caminhada")
            self.selectedFilterWalking = true
            self.labelWalking.textColor = UIColor.black
        }
        self.plotPins()
    }
    
    @IBAction func pressFilterRun(_ sender: Any) {
        if self.selectedFilterRun {
            self.imageRun.image = #imageLiteral(resourceName: "corrida")
            self.selectedFilterRun = false
            self.labelRun.textColor = UIColor.lightGray
        } else {
            self.imageRun.image = #imageLiteral(resourceName: "correr")
            self.selectedFilterRun = true
            self.labelRun.textColor = UIColor.black
        }
        self.plotPins()
    }
    
    @IBAction func pressFilterBike(_ sender: Any) {
        if self.selectedFilterBike {
            self.imageBike.image = #imageLiteral(resourceName: "bicicletaCopy2")
            self.selectedFilterBike = false
            self.labelBike.textColor = UIColor.lightGray
        } else {
            self.imageBike.image = #imageLiteral(resourceName: "bike")
            self.selectedFilterBike = true
            self.labelBike.textColor = UIColor.black
        }
        self.plotPins()
    }
    
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}
