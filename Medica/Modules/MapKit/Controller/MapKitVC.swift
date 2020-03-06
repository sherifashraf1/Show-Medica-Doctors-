//
//  MapKitVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
import MapKit

class MapKitVC: UIViewController {
    
    lazy var hideNavButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(dismissMapView))
    }()
    
    lazy var showDrInListButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Doctors", style: .done, target: self, action: #selector(showDrInListView))
    }()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @objc func dismissMapView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showDrInListView(){
        let vc = DoctorsFactoryView.makeMapWithNavigate()
        present(vc, animated: true, completion: nil)
    }
    
    let doctorsLocations = [
        MyAnnotation(title: "Dr Emad", locationName: "Cairo", discipline: "Psychiatrist and neurologist", coordinate: CLLocationCoordinate2DMake(31.19957787 ,29.908406)),
        MyAnnotation(title: "Dr. Ali", locationName: "Makram Ebied", discipline: "Neurologists", coordinate: CLLocationCoordinate2DMake(31.19857786 ,29.907402)),
        MyAnnotation(title: "Dr. Ahmed", locationName: "Nasr City", discipline: "Plastic surgeon", coordinate: CLLocationCoordinate2DMake(31.19748064 , 29.907410)),
        MyAnnotation(title: "Dr. Hasssan", locationName: "Zamalek", discipline: "dermatologist", coordinate: CLLocationCoordinate2DMake(31.19648064 ,29.907420)),
        MyAnnotation(title: "Dr. Omar", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Hussien", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19948064 ,29.907440)),
        MyAnnotation(title: "Dr. Moahmed", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19658064 ,29.907450)),
        MyAnnotation(title: "Dr. Ahmed", locationName: "New Cairo", discipline: "dermatologist", coordinate: CLLocationCoordinate2DMake(31.19749064 ,29.907460)),
        MyAnnotation(title: "Dr. Ibrahim", locationName: "New Cairo", discipline: "Neurologists", coordinate: CLLocationCoordinate2DMake(31.19158064 ,29.907470)),
        MyAnnotation(title: "Dr. Zeyad", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19248074 ,29.907480)),
        MyAnnotation(title: "Dr. SHerif", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548070 ,29.907490)),
        MyAnnotation(title: "Dr. Mahmoud", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548169 ,29.907500))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map View"
        navigationItem.setLeftBarButton(hideNavButton, animated: true)
        navigationItem.setRightBarButton(showDrInListButton, animated: true)
        self.hideNavButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.showDrInListButton.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        mapView.delegate = self
        showDoctors()
        let initialLocation = CLLocation(latitude: 31.19857787, longitude: 29.907406 )
        centerMapOnLoaction(location: initialLocation)
        
        
    }
    func showDoctors(){
        for doctor in doctorsLocations {
            let annotation = MKPointAnnotation()
            annotation.title = doctor.title
            annotation.subtitle = doctor.discipline
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
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.canShowCallout = true
        pin.image = UIImage(named: "ann-marker")
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotationView = view.annotation
        let vc = DoctorDetailsVC()
        vc.drName = ((annotationView?.title!)!)
        vc.drDecipline = ((annotationView?.subtitle!)!)
        vc.lat = (annotationView?.coordinate.latitude)!
        vc.lon = (annotationView?.coordinate.longitude)!
        present(vc, animated: true, completion: nil)
    }
}
