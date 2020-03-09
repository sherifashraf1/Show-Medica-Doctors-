//
//  DoctorsListTableVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
import CoreLocation
class DoctorsListTableVC: UITableViewController {
    var doctorsData : Doctors?
    
    lazy var hideNavButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(dismissDoctorListView))
    }()
    
    @objc func dismissDoctorListView(){
        dismiss(animated: true, completion: nil)
    }
    
    let doctorsLocations = [
        MyAnnotation(title: "Dr Emad", locationName: "Cairo", discipline: "Psychiatrist and neurologist", coordinate: CLLocationCoordinate2DMake(31.19957787 ,29.908406)),
        MyAnnotation(title: "Dr. Ali", locationName: "Makram Ebied", discipline: "Neurologists", coordinate: CLLocationCoordinate2DMake(31.19857786 ,29.907402)),
        MyAnnotation(title: "Dr. Ahmed", locationName: "Nasr City", discipline: "Plastic surgeon", coordinate: CLLocationCoordinate2DMake(31.19748064 , 29.907410)),
        MyAnnotation(title: "Dr. Hasssan", locationName: "Zamalek", discipline: "dermatologist", coordinate: CLLocationCoordinate2DMake(31.19648064 ,29.907420)),
        MyAnnotation(title: "Dr. Omar", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Hussien", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Moahmed", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Ahmed", locationName: "New Cairo", discipline: "dermatologist", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Ibrahim", locationName: "New Cairo", discipline: "Neurologists", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Zeyad", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. SHerif", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430)),
        MyAnnotation(title: "Dr. Mahmoud", locationName: "New Cairo", discipline: "Medica Healthy Provider", coordinate: CLLocationCoordinate2DMake(31.19548064 ,29.907430))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Doctors List"
        navigationItem.setLeftBarButton(hideNavButton, animated: true)
        let cell = UINib(nibName: "DoctorsTableViewCell", bundle: nil)
        tableView.register(cell.self, forCellReuseIdentifier: "UITabelViewCell")
        loadData()
    }
    
    
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "doctors.listt", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL.init(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                doctorsData = try decoder.decode(Doctors.self, from: data)
                tableView.reloadData()
            }
            catch {
                print(error)
            }
        }
    }

    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return doctorsData?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myDoctorsData = doctorsData?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITabelViewCell", for: indexPath) as! DoctorsTableViewCell
        
        cell.drName.text = myDoctorsData?.message
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedDoctor = doctorsData[indexPath.row]
//        let vc = DoctorDetailsVC()
//        vc.drName = selectedDoctor.title
//        vc.drDecipline = selectedDoctor.address
//        vc.lat = selectedDoctor.lat
//        vc.lon = selectedDoctor.lng
//        present(vc, animated: true, completion: nil)
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
