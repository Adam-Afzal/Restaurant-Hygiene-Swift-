//
//  ViewController.swift
//  HygieneApp
//
//  Created by Adam Afzal on 26/03/2018.
//  Copyright © 2018 Adam Afzal. All rights reserved.
//

import UIKit


import MapKit

class ViewController: UIViewController , UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheRest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! RatingTableViewCell
        cell.restnamelabel.text = allTheRest[indexPath.row].BusinessName
        
        print(allTheRest[indexPath.row].RatingValue)
        
        cell.restname?.image = UIImage(named: "\(allTheRest[indexPath.row].RatingValue).jpg")
        return cell
    }
    
    var allTheRest = [Restaurant]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
        let latitude1 = locationManager.location?.coordinate.latitude
        let longitude1 = locationManager.location?.coordinate.longitude
        
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locationManager.location!, completionHandler: {(placemarks,error) in
            
            if error == nil {
                
                let firstlocation = placemarks?[0]
                let locality = firstlocation?.locality
                let country = firstlocation?.country
               
                
                
            } else{
                
                if let error = error{
                    
                    print("error! \(error)")
                }
            }
            
            
        })
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(latitude1)&long=\(longitude1)")// Do any additional setup after loading the view, typically from a nib.
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            guard let data = data else{print("error with data"); return}
            
            do{
                
                self.allTheRest = try JSONDecoder().decode([Restaurant].self, from: data);
                DispatchQueue.main.async {
                    self.myTableView.reloadData();
                }
                print(self.allTheRest.count)
                print(self.allTheRest[0].BusinessName)
            } catch let err{
                
                print("Error: ", err)
            }
            
            
            
            
            }.resume()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let lat = locations[0].coordinate.latitude
        let long = locations[0].coordinate.longitude
        
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locations[0], completionHandler: {(placemarks,error) in
            
            if error == nil{
                
                let firstlocation = placemarks?[0]
                if let locality = firstlocation?.locality{
                    if let country = firstlocation?.country{
                        
                    }
                } else {
                    
                   
                }
                
            } else {
                
                if let error = error{
                    
                    print("geocoding error: \(error)")
                }
            }
            
        })
        
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(lat)&long=\(long)")// Do any additional setup after loading the view, typically from a nib.
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            guard let data = data else{print("error with data"); return}
            
            do{
                
                self.allTheRest = try JSONDecoder().decode([Restaurant].self, from: data);
                DispatchQueue.main.async {
                    self.myTableView.reloadData();
                }
                print(self.allTheRest.count)
                print(self.allTheRest[0].BusinessName)
            } catch let err{
                
                print("Error: ", err)
            }
            
            
            
            
            }.resume()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var myTableView: UITableView!
}

