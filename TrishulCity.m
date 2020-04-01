//
//  TrishulCity.m
//  Mahurat
//
//  Created by BHAVIN SHUKLA on 10/18/13.
//  Copyright (c) 2013 Trishul. All rights reserved.
//

#import "TrishulCity.h"
#import "TrishulUtilities.h"

@implementation TrishulCity {
    
    NSString *cityName;
    double cityLongitude;
    double cityLatitude;
    NSString *cityTimeZone;
    double cityTimeZoneOffset;
    bool daylightDependence;
    int daylightSavingsTimeOffset;
    NSDate* todaysDate;
    NSDate* yesterdaysDate;
    double locationTodaysSunriseInDouble;
    double locationTodaysSunsetInDouble;
    double locationYesterdaysSunsetInDouble;
    TrishulUtilities* todaysUtility;
    
}

-(id)initWithValues:(NSString *) inCityName withLongitude:(double) inLongitude withLatitude:(double) inLatitude
   withCityTimeZone:(NSString*) inCityTimeZone withTimeZoneOffset:(double) inCityTimeZoneOffset
withDaylightDependence: (bool) inDaylightDependence
withDayLightSavingsTimeOffset:(int)inDaylightSavingsTimeOffset {
    self = [super init];
    if (self) {
        cityName = inCityName;
        NSLog(@"City = %@", cityName);
        cityLongitude = inLongitude;
        cityLatitude = inLatitude;
        cityTimeZone = inCityTimeZone;
        cityTimeZoneOffset = inCityTimeZoneOffset;
        daylightDependence = inDaylightDependence;
        daylightSavingsTimeOffset = inDaylightSavingsTimeOffset;
    }
    return self;
}

- (NSString*) getString {
    NSString *returnString = @"City Details: ";
    returnString = [returnString stringByAppendingString:@"Name: "];
    returnString = [returnString stringByAppendingString:cityName];
    returnString = [returnString stringByAppendingString:@" | Latitude: "];
    returnString = [returnString stringByAppendingString:[[NSNumber numberWithDouble:cityLatitude] stringValue]];
    returnString = [returnString stringByAppendingString:@" | Longitude: "];
    returnString = [returnString stringByAppendingString:[[NSNumber numberWithDouble:cityLongitude] stringValue]];
    returnString = [returnString stringByAppendingString:@" | Timezone: "];
    returnString = [returnString stringByAppendingString:cityTimeZone];
    returnString = [returnString stringByAppendingString:@" | Timezone Offset: "];
    returnString = [returnString stringByAppendingString:[[NSNumber numberWithDouble:cityTimeZoneOffset] stringValue]];
    returnString = [returnString stringByAppendingString:@" | Daylight: "];
    return returnString;
}
- (bool) isDaylightDependence {
    return daylightDependence;
}
- (void) setIsDaylightDependence:(bool) inDaylightDependence {
    daylightDependence = inDaylightDependence;
}

- (NSString *) getCityName {
    return cityName;
}
- (double) getCityLatitude {
    return cityLatitude;
}
- (double) getCityLongitude {
    return cityLongitude;
}

- (NSString*) getCityTimeZone {
    return cityTimeZone;
}
- (void) setDaylightSavingsTimeOffset:(int) inDaylightSavingsTimeOffset {
    daylightSavingsTimeOffset = inDaylightSavingsTimeOffset;
}

- (int) getDaylightSavingsTimeOffset {
    return daylightSavingsTimeOffset;
}
- (double) getCityTimeZoneOffset {
    return cityTimeZoneOffset;
}

- (void) setCityName:(NSString*) inCityName {
    cityName = inCityName;
}

- (void) setCityTimeZoneOffset:(double)inTimeZoneOffset {
    cityTimeZoneOffset = inTimeZoneOffset;
}
- (void) setCityTimeZone:(NSString*) inTimeZone {
    cityTimeZone = inTimeZone;
}

- (void)setCityLongitude:(double)inLongitudeValue {
    cityLongitude = inLongitudeValue;
}
- (void)setCityLatitude:(double)inLatitudeValue {
    cityLatitude = inLatitudeValue;
}


- (NSDate*)convertStringToDate:(NSString*) inDateString {
    NSDate* localDate;
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    localDate = [f dateFromString:inDateString];
    return localDate;
}

- (NSString*)convertDateToString:(NSDate*) inDate {
    NSString* localDateString;
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    localDateString = [f stringFromDate:inDate];
    return localDateString;
}

- (void)setTodaysDateInDate:(NSDate*) inDate {
    todaysUtility = [[TrishulUtilities alloc] init];
    
    locationTodaysSunriseInDouble = -999.99;
    locationTodaysSunsetInDouble = -999.99;
    locationYesterdaysSunsetInDouble = -999.99;
    
    todaysDate = inDate;
    // Need to adjust the timezoneOffset based on daylight savings indicator
    NSLog(@"Trishul Utilty Date Before: %@", [self convertDateToString:todaysDate]);
    double localTimeZoneOffset = cityTimeZoneOffset;
    if (daylightDependence) {
        //        int offsetSeconds = daylightSavingsTimeOffset*60*60;
        //        todaysDate = [todaysDate dateByAddingTimeInterval:offsetSeconds];
        localTimeZoneOffset = localTimeZoneOffset + daylightSavingsTimeOffset;
    }
    NSLog(@"Trishul Utilty Date After: %@", [self convertDateToString:todaysDate]);
    
    NSString* todays_date_string = [self convertDateToString:inDate];
    yesterdaysDate = [self convertStringToDate:todays_date_string];
    [todaysUtility setLatitudeValue:cityLatitude];
    [todaysUtility setLongitudeValue:cityLongitude];
    [todaysUtility setTimeZoneOffset:localTimeZoneOffset];
    [todaysUtility setTodaysDateInDate:todaysDate];
    
    
    int numberOfSecondsInADay = 24*60*60;
    yesterdaysDate = [yesterdaysDate dateByAddingTimeInterval:-numberOfSecondsInADay];
    
}

- (NSString *) getGivenDateInString:(NSDate*) inDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, MMM d,''yy"];
    NSString *returnString = [formatter stringFromDate:inDate];
    
    return returnString;
}
- (NSString *) getTodaysDateInString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, MMM d,''yy"];
    NSString *returnString = [formatter stringFromDate:todaysDate];
    return returnString;
}


- (double) getTodaysSunriseInDouble {
    locationTodaysSunriseInDouble = [todaysUtility getTodaysSunriseDoubleValue];
    return locationTodaysSunriseInDouble;
}

- (double) getTodaysSunsetInDouble {
    locationTodaysSunsetInDouble = [todaysUtility getTodaysSunsetDoubleValue];
    return locationTodaysSunsetInDouble;
}


@end
