//
//  TrishulCity.h
//  Mahurat
//
//  Created by BHAVIN SHUKLA on 10/18/13.
//  Copyright (c) 2013 Trishul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrishulCity : NSObject

-(id)initWithValues:(NSString *) inCityName withLongitude:(double) inLongitude withLatitude:(double) inLatitude
   withCityTimeZone:(NSString*) inCityTimeZone withTimeZoneOffset:(double) inCityTimeZoneOffset
withDaylightDependence: (bool) inDaylightDependence
withDayLightSavingsTimeOffset:(int) inDaylightSavingsTimeOffset;

- (NSString *) getCityName;
- (double) getCityLatitude;
- (double) getCityLongitude;
- (bool) isDaylightDependence;
- (void) setIsDaylightDependence:(bool) inDaylightDependence;
- (NSString*) getString;

- (NSString*) getCityTimeZone;
- (double) getCityTimeZoneOffset;
- (int) getDaylightSavingsTimeOffset;
- (void) setDaylightSavingsTimeOffset:(int) inDaylightSavingsTimeOffset;

- (void) setCityName:(NSString*) inCityName;

- (void) setCityTimeZoneOffset:(double)inTimeZoneOffset;
- (void) setCityTimeZone:(NSString*) inTimeZone;

- (void)setCityLongitude:(double)inLongitudeValue ;
- (void)setCityLatitude:(double)inLatitudeValue ;

- (NSDate*)convertStringToDate:(NSString*) inDateString ;
- (NSString*)convertDateToString:(NSDate*) inDate ;
- (void)setTodaysDateInDate:(NSDate*) inDate ;
- (NSString *) getGivenDateInString:(NSDate*) inDate;
- (NSString *) getTodaysDateInString;
- (double) getTodaysSunriseInDouble;
- (double) getTodaysSunsetInDouble;
@end
