// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Foundation;
@import UIKit;
@import CoreLocation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

SWIFT_CLASS("_TtC10PlayGoTest10AlphaModel")
@interface AlphaModel : NSObject <NSURLSessionDataDelegate>
@property (nonatomic, copy) NSData * _Nonnull data;
@property (nonatomic, readonly, copy) NSString * _Nonnull urlPath;
- (void)downloadItems;
- (void)parseJSON:(NSData * _Nonnull)data;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIApplication;

SWIFT_CLASS("_TtC10PlayGoTest11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions SWIFT_WARN_UNUSED_RESULT;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class MKMapView;
@class UILabel;
@class UIImageView;
@class LocationModel;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC10PlayGoTest20DetailViewController")
@interface DetailViewController : UIViewController
@property (nonatomic, weak) IBOutlet MKMapView * _Null_unspecified mapView;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified eventImage;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified eventLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified venueLabel;
@property (nonatomic, strong) LocationModel * _Nullable selectedLocation;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)viewDidAppear:(BOOL)animated;
- (NSString * _Nullable)formattedDateFromStringWithDateString:(NSString * _Nonnull)dateString withFormat:(NSString * _Nonnull)format SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class CLLocation;
@class CLLocationManager;

SWIFT_CLASS("_TtC10PlayGoTest19FirstViewController")
@interface FirstViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocation * _Null_unspecified currentLocation;
@property (nonatomic, strong) CLLocationManager * _Null_unspecified locationManager;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC10PlayGoTest9HomeModel")
@interface HomeModel : NSObject <NSURLSessionDataDelegate>
@property (nonatomic, copy) NSData * _Nonnull data;
@property (nonatomic, readonly, copy) NSString * _Nonnull urlPath;
- (void)downloadItems;
- (void)parseJSON:(NSData * _Nonnull)data;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC10PlayGoTest13LocationModel")
@interface LocationModel : NSObject
@property (nonatomic, copy) NSString * _Nullable name;
@property (nonatomic, copy) NSString * _Nullable address;
@property (nonatomic, copy) NSString * _Nullable latitude;
@property (nonatomic, copy) NSString * _Nullable longitude;
@property (nonatomic, copy) NSString * _Nullable image;
@property (nonatomic, copy) NSString * _Nullable event;
@property (nonatomic, copy) NSString * _Nullable eventimage;
@property (nonatomic, copy) NSString * _Nullable date;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithName:(NSString * _Nonnull)name address:(NSString * _Nonnull)address latitude:(NSString * _Nonnull)latitude longitude:(NSString * _Nonnull)longitude image:(NSString * _Nonnull)image event:(NSString * _Nonnull)event eventimage:(NSString * _Nonnull)eventimage date:(NSString * _Nonnull)date OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly, strong) CLLocation * _Nonnull location;
- (CLLocationDistance)distanceTo:(CLLocation * _Nonnull)location SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
@end

@class UIView;

SWIFT_CLASS("_TtC10PlayGoTest14TableViewCell1")
@interface TableViewCell1 : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified eventLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified distanceLable;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified dateLabel;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified backgroundCardView;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified eventImage;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified venueImage;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified venueLabel;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIImageView (SWIFT_EXTENSION(PlayGoTest))
- (void)setRounded;
@end

@class UITableView;
@class UIButton;
@class NSArray;
@class UIRefreshControl;
@class UIStoryboardSegue;

SWIFT_CLASS("_TtC10PlayGoTest14ViewController")
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified listTableView;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified azButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified distanceButton;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified lblCurrentLOcation;
@property (nonatomic, strong) NSArray * _Nonnull feedItems;
@property (nonatomic, strong) CLLocation * _Null_unspecified currentLocation;
@property (nonatomic, strong) CLLocationManager * _Null_unspecified locationManager;
@property (nonatomic, strong) LocationModel * _Nonnull selectedLocation;
- (void)viewDidLoad;
- (void)refreshDataWithSender:(UIRefreshControl * _Nonnull)sender;
- (void)itemsDownloadedWithItems:(NSArray * _Nonnull)items;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (IBAction)azPress:(id _Nonnull)sender;
- (IBAction)sortByDistancePressed:(id _Nonnull)sender;
- (NSString * _Nullable)formattedDateFromStringWithDateString:(NSString * _Nonnull)dateString withFormat:(NSString * _Nonnull)format SWIFT_WARN_UNUSED_RESULT;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)didReceiveMemoryWarning;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
