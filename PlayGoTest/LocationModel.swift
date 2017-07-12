import CoreLocation
import Foundation

/*
 *  CLLocation.h
 *  CoreLocation
 *
 *  Copyright (c) 2008-2010 Apple Inc. All rights reserved.
 *
 */

/*
 *  CLLocationDegrees
 *  
 *  Discussion:
 *    Type used to represent a latitude or longitude coordinate in degrees under the WGS 84 reference
 *    frame. The degree can be positive (North and East) or negative (South and West).  
 */
public typealias CLLocationDegrees = Double

/*
 *  CLLocationAccuracy
 *  
 *  Discussion:
 *    Type used to represent a location accuracy level in meters. The lower the value in meters, the
 *    more physically precise the location is. A negative accuracy value indicates an invalid location.
 */
public typealias CLLocationAccuracy = Double

/*
 *  CLLocationSpeed
 *  
 *  Discussion:
 *    Type used to represent the speed in meters per second.
 */
public typealias CLLocationSpeed = Double

/*
 *  CLLocationDirection
 *  
 *  Discussion:
 *    Type used to represent the direction in degrees from 0 to 359.9. A negative value indicates an
 *    invalid direction.
 */
public typealias CLLocationDirection = Double

/*
 *  CLLocationCoordinate2D
 *  
 *  Discussion:
 *    A structure that contains a geographical coordinate.
 *
 *  Fields:
 *    latitude:
 *      The latitude in degrees.
 *    longitude:
 *      The longitude in degrees.
 */
public struct CLLocationCoordinate2D {

    public var latitude: CLLocationDegrees

    public var longitude: CLLocationDegrees

    public init()

    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

extension CLLocationCoordinate2D {
}

/*
 *  CLLocationDistance
 *  
 *  Discussion:
 *    Type used to represent a distance in meters.
 */
public typealias CLLocationDistance = Double

/*
 *  kCLDistanceFilterNone
 *  
 *  Discussion:
 *    Use as the distanceFilter property for CLLocationManager. This indicates 
 *    to the location service that no minimum movement filter is desired - ie, client will be informed
 *    of any movement.
 */
public let kCLDistanceFilterNone: CLLocationDistance

/*
 *  kCLLocationAccuracy<x>
 *  
 *  Discussion:
 *    Used to specify the accuracy level desired. The location service will try its best to achieve
 *    your desired accuracy. However, it is not guaranteed. To optimize
 *    power performance, be sure to specify an appropriate accuracy for your usage scenario (eg,
 *    use a large accuracy value when only a coarse location is needed).
 */
@available(iOS 4.0, *)
public let kCLLocationAccuracyBestForNavigation: CLLocationAccuracy
public let kCLLocationAccuracyBest: CLLocationAccuracy
public let kCLLocationAccuracyNearestTenMeters: CLLocationAccuracy
public let kCLLocationAccuracyHundredMeters: CLLocationAccuracy
public let kCLLocationAccuracyKilometer: CLLocationAccuracy
public let kCLLocationAccuracyThreeKilometers: CLLocationAccuracy

/*
 *  CLLocationDistanceMax
 *
 *  Discussion:
 *  	Used to specify the maximum CLLocationDistance
 */
@available(iOS 6.0, *)
public let CLLocationDistanceMax: CLLocationDistance

/*
 *  CLTimeIntervalMax
 *
 *  Discussion:
 *  	Used to specify the maximum NSTimeInterval
 */
@available(iOS 6.0, *)
public let CLTimeIntervalMax: TimeInterval

/*
 *  kCLLocationCoordinate2DInvalid
 *  
 *  Discussion:
 *    Used to specify an invalid CLLocationCoordinate2D.
 */
@available(iOS 4.0, *)
public let kCLLocationCoordinate2DInvalid: CLLocationCoordinate2D

/*
 *  CLLocationCoordinate2DIsValid
 *  
 *  Discussion:
 *    Returns YES if the specified coordinate is valid, NO otherwise.
 */
@available(iOS 4.0, *)
public func CLLocationCoordinate2DIsValid(_ coord: CLLocationCoordinate2D) -> Bool

/*
 *  CLLocationCoordinate2DMake:
 *
 *  Discussion:
 *    Returns a new CLLocationCoordinate2D at the given latitude and longitude
 */
@available(iOS 4.0, *)
public func CLLocationCoordinate2DMake(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) -> CLLocationCoordinate2D

/*
 *  CLFloor
 *
 *  Discussion:
 *    Encapsulates the information about a floor.
 */

@available(iOS 8.0, *)
open class CLFloor : NSObject, NSCopying, NSSecureCoding {

    
    /*
     *  level
     *
     *  Discussion:
     *    This is a logical representation that will vary on definition from building-to-building.
     *    Floor 0 will always represent the floor designated as "ground".
     *    This number may be negative to designate floors below the ground floor
     *    and positive to indicate floors above the ground floor.
     *    It is not intended to match any numbering that might actually be used in the building.
     *    It is erroneous to use as an estimate of altitude.
     */
    open var level: Int { get }
}

/*
 *  CLLocation
 *  
 *  Discussion:
 *    Represents a geographical coordinate along with accuracy and timestamp information.
 */

@available(iOS 2.0, *)
open class CLLocation : NSObject, NSCopying, NSSecureCoding {

    
    /*
     *  initWithLatitude:longitude:
     *  
     *  Discussion:
     *    Initialize with the specified latitude and longitude.
     */
    public init(latitude: CLLocationDegrees, longitude: CLLocationDegrees)

    
    /*
     *  initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:timestamp:
     *  
     *  Discussion:
     *    Initialize with the specified parameters.
     */
    public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, timestamp: Date)

    
    /*
     *  initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:course:speed:timestamp:
     *  
     *  Discussion:
     *    Initialize with the specified parameters.
     */
    @available(iOS 4.2, *)
    public init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, course: CLLocationDirection, speed: CLLocationSpeed, timestamp: Date)

    
    /*
     *  coordinate
     *  
     *  Discussion:
     *    Returns the coordinate of the current location.
     */
    open var coordinate: CLLocationCoordinate2D { get }

    
    /*
     *  altitude
     *  
     *  Discussion:
     *    Returns the altitude of the location. Can be positive (above sea level) or negative (below sea level).
     */
    open var altitude: CLLocationDistance { get }

    
    /*
     *  horizontalAccuracy
     *  
     *  Discussion:
     *    Returns the horizontal accuracy of the location. Negative if the lateral location is invalid.
     */
    open var horizontalAccuracy: CLLocationAccuracy { get }

    
    /*
     *  verticalAccuracy
     *  
     *  Discussion:
     *    Returns the vertical accuracy of the location. Negative if the altitude is invalid.
     */
    open var verticalAccuracy: CLLocationAccuracy { get }

    
    /*
     *  course
     *  
     *  Discussion:
     *    Returns the course of the location in degrees true North. Negative if course is invalid.
     *
     *  Range:
     *    0.0 - 359.9 degrees, 0 being true North
     */
    @available(iOS 2.2, *)
    open var course: CLLocationDirection { get }

    
    /*
     *  speed
     *  
     *  Discussion:
     *    Returns the speed of the location in m/s. Negative if speed is invalid.
     */
    @available(iOS 2.2, *)
    open var speed: CLLocationSpeed { get }

    
    /*
     *  timestamp
     *  
     *  Discussion:
     *    Returns the timestamp when this location was determined.
     */
    open var timestamp: Date { get }

    
    /*
     *  floor
     *
     *  Discussion:
     *    Contains information about the logical floor that you are on
     *    in the current building if you are inside a supported venue.
     *    This will be nil if the floor is unavailable.
     */
    @available(iOS 8.0, *)
    @NSCopying open var floor: CLFloor? { get }

    
    /*
     *  distanceFromLocation:
     *
     *  Discussion:
     *    Returns the lateral distance between two locations.
     */
    @available(iOS 3.2, *)
    open func distance(from location: CLLocation) -> CLLocationDistance
}
