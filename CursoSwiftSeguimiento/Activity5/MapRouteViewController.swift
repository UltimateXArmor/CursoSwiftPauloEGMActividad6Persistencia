//
//  MapRouteViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import MapKit

class MapRouteViewController: UIViewController {

    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblClient: UILabel!
    @IBOutlet weak var map: MKMapView!
    var employee : Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.initMap()
    }
    
    func initMap(){
        
        guard let emp = self.employee else {return}
        let latitude: CLLocationDegrees = 19.4336523
        let longitude:CLLocationDegrees = -99.1454316
        let latDelta: CLLocationDegrees = 0.4
        let lonDelta: CLLocationDegrees = 0.4
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.delegate = self
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Ciudad de México"
        annotation.subtitle = "Me encuentro aquí"
        annotation.coordinate = coordinates
        map.addAnnotation(annotation)
        map.selectAnnotation(annotation, animated: true)
        // Do any additional setup after loading the view.
        
        
        let latitude2: CLLocationDegrees = emp.routeLat
        let longitude2:CLLocationDegrees = emp.routeLon
        let coordinates2 = CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2)
        
        let sourcePlacemark = MKPlacemark.init(coordinate: coordinates)
        let sourceMapItem = MKMapItem.init(placemark: sourcePlacemark)
        
        let destinationPlacemark = MKPlacemark(coordinate: coordinates2, addressDictionary: nil)
        let destinationMapItem = MKMapItem.init(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.map.addOverlay(route.polyline, level: .aboveRoads)
            
            self.lblDistance.text = "Distancia: \(route.distance) m."
            let minutes = round( route.expectedTravelTime * 100 / 60 ) / 100
            self.lblTime.text = "Tiempo estimado: \(minutes) minutos"
            self.lblClient.text = "Cliente: \(emp.clientName)"
            
            
            /*let annotation2 = MKPointAnnotation()
            annotation2.title = "\(emp.clientName)"
            
            annotation2.subtitle = "\(destinationPlacemark.thoroughfare ?? "") CP \(destinationPlacemark.postalCode ?? ""), Adeudo: \(emp.clientDebt)"
            annotation2.coordinate = coordinates2
            self.map.addAnnotation(annotation2)*/
            self.getAddressFromLatLon(pdblLatitude: "\(latitude2)", withLongitude: "\(longitude2)", coordinates: coordinates2)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    

    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String, coordinates: CLLocationCoordinate2D)  {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                    let emp = self.employee!
                    let annotation2 = MKPointAnnotation()
                    annotation2.title = "\(emp.clientName)"
                    annotation2.subtitle = "\(addressString), Adeudo: \(emp.clientDebt)"
                    annotation2.coordinate = coordinates
                    self.map.addAnnotation(annotation2)
                }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapRouteViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.lineDashPattern = [2,4];
        renderer.lineWidth = 4.0
        renderer.alpha = 1
        return renderer
    }
}
