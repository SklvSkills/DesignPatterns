//
//  Strategy
//

import CoreLocation

protocol RouteStrategy {
    func buildRoute(from pointA: CLLocationCoordinate2D, to pointB: CLLocationCoordinate2D)
}

class RoadStrategy: RouteStrategy {
    func buildRoute(from pointA: CLLocationCoordinate2D, to pointB: CLLocationCoordinate2D) {
        print("A route for the car has been built.")
    }
}

class BikeStrategy: RouteStrategy {
    func buildRoute(from pointA: CLLocationCoordinate2D, to pointB: CLLocationCoordinate2D) {
        print("A bike route has been built.")
    }
}

class WalkingStrategy: RouteStrategy {
    func buildRoute(from pointA: CLLocationCoordinate2D, to pointB: CLLocationCoordinate2D) {
        print("A pedestrian route has been built.")
    }
}

// Navigator

class Navigator {
    private lazy var strategy: RouteStrategy = RoadStrategy()
    
    func set(strategy: RouteStrategy) {
        self.strategy = strategy
    }
    
    func buildRoute(from pointA: CLLocationCoordinate2D, to pointB: CLLocationCoordinate2D) {
        strategy.buildRoute(from: pointA, to: pointB)
    }
}

// Client

class Client {
    func run() {
        let navigator = Navigator()
        navigator.set(strategy: WalkingStrategy())
        
        let pointA = CLLocationCoordinate2D()
        let pointB = CLLocationCoordinate2D()
        navigator.buildRoute(from: pointA, to: pointB)
    }
}

// Client().run()

// A pedestrian route has been built.
