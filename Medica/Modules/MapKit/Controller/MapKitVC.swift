//
//  MapKitVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
import MapKit

class MapKitVC: UIViewController  {
    var arrDoctorsData : [ItemDatumList] = []
    var myAnnot = [MyAnnotation]()
    var initialLat:Double = 0.0
    var initialLng:Double = 0.0
 
    lazy var hideNavButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(dismissMapView))
    }()
    
    lazy var showDrInListButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Doctors", style: .done, target: self, action: #selector(showDrInListView))
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    var spinner: UIActivityIndicatorView?
    func showActivityIndicator() {
        spinner = UIActivityIndicatorView(style: .gray)
        spinner?.color = .black
        spinner?.center = self.view.center
        spinner?.hidesWhenStopped = true
        spinner?.scaleIndicator(factor: 2)
        self.view.addSubview(spinner!)
        spinner?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (spinner != nil){
            spinner?.stopAnimating()
            
        }
    }
    
    @objc func dismissMapView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showDrInListView(){
        let vc = DoctorsFactoryView.makeMapWithNavigate()
        present(vc, animated: true, completion: nil)

    }
    
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideActivityIndicator()
    }
    
    var doc:[MyAnnotation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map View"
        showActivityIndicator()
        navigationItem.setLeftBarButton(hideNavButton, animated: true)
        navigationItem.setRightBarButton(showDrInListButton, animated: true)
        self.hideNavButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.showDrInListButton.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .lightGray
        mapView.delegate = self
        doctorsDataGet(){}
    }
    
    func doctorsDataGet(completed:()->())  {
        guard let  url = URL(string: "http://medicahealthy.net/api/institutions?lat=31.222229&lng=29.949358") else { return  }
        var request = URLRequest(url: url)
        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("c213348c8e34e7dd", forHTTPHeaderField: "From")
        request.addValue("android", forHTTPHeaderField: "User-Agent")
        request.addValue("en", forHTTPHeaderField: "Accept-Language")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    do{
                        let doctorDetail = try JSONDecoder().decode(DoctorsModel.self, from: data!)
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                            for doctor in doctorDetail.item.data{
                                self.arrDoctorsData.append(doctor)
                            }
                            for i in self.arrDoctorsData{
                                self.initialLat = Double(i.lat)!
                                self.initialLng = Double(i.lng)!
                                let docAnnotationData = MyAnnotation(title: i.title, institution_title: i.institution_title, annotDescription: i.description, specialty: i.specialty, price: i.price, address: i.address, image: i.image, coordinate: CLLocationCoordinate2DMake(CLLocationDegrees(i.lat)! ,CLLocationDegrees(i.lng)!))
                                self.doc.append(docAnnotationData)
                            }
                            self.showDoctors()
                            let initialLocation = CLLocation(latitude: self.initialLat, longitude: self.initialLng )
                            self.centerMapOnLoaction(location: initialLocation)
                        }
                        
                        }catch {
                        print("error",error)
                    }
                }
            }.resume()
        
    }
    func showDoctors(){
        for doctor in doc {
            let annotation = MKPointAnnotation()
            annotation.title = doctor.title
            annotation.subtitle = doctor.address
            annotation.coordinate = doctor.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLoaction(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }    
}

extension MapKitVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let AnnotaionIdentifier = "AnnotationIdentifier"
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotaionIdentifier)
        if pin == nil {
            pin = AnnotationView(annotation: annotation, reuseIdentifier: AnnotaionIdentifier)
            pin?.canShowCallout = false
        } else {
            pin?.annotation = annotation
        }
        
        pin?.canShowCallout = true
        pin?.image = UIImage(named: "ann-marker")
        pin?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
   
   
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annotationView = view.annotation
        let vc = AnnotDetails()
        vc.drName = ((annotationView?.title!)!)
        vc.drAddres = ((annotationView?.subtitle!)!)
        vc.lat = (annotationView?.coordinate.latitude)!
        vc.lon = (annotationView?.coordinate.longitude)!
        present(vc, animated: true, completion: nil)
    }
    
}
    

