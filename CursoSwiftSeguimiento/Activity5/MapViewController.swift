//
//  MapViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    var empleado : Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let latitude: CLLocationDegrees = 19.4336523
        let longitude:CLLocationDegrees = -99.1454316
        let latDelta: CLLocationDegrees = 0.5
        let lonDelta: CLLocationDegrees = 0.5
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.delegate = self
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Ciudad de México"
        annotation.subtitle = "Me encuentro aquí"
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        // Do any additional setup after loading the view.
        
        
        let latitude2: CLLocationDegrees = 19.4336523
        let longitude2:CLLocationDegrees = -99.1554316
        let coordinates2 = CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2)
        
        let sourcePlacemark = MKPlacemark.init(coordinate: coordinates)
        let sourceMapItem = MKMapItem.init(placemark: sourcePlacemark)
        
        let destinationPlacemark = MKPlacemark.init(coordinate: coordinates2)
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
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
           
            self.lblDistance.text = "Distancia: \(route.distance) m."
            self.lblTime.text = "Tiempo estimado: \(route.expectedTravelTime)"
            /*self.lblClient.text = "Cliente \(empleado)"*/
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
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

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.lineDashPattern = [2,4];
        renderer.lineWidth = 4.0
        renderer.alpha = 1
        return renderer
    }
}

public struct Employee {
    var name = ""
    var isBoss = false
    var routeLat = 0.00
    var routeLon = 0.00
    var clientName = ""
    var clientDebt = 0.00
    var postalCode = ""
    var address = ""
}
