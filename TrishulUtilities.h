//
//  TrishulUtilities.h
//  Mahurat
//
//  Created by BHAVIN SHUKLA on 10/18/13.
//  Copyright (c) 2013 Trishul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrishulUtilities : NSObject

- (double)getLongitudeValue ;
- (double)getLatitudeValue ;

- (NSDate*) getTodaysDate ;

- (void) setDayLightSavingsTimeFlag:(BOOL)inFlag ;
- (void) setTimeZoneOffset:(double)inTimeZoneOffset ;
- (double) getTimeZoneOffset ;
- (void)setLongitudeValue:(double)inLongitudeValue ;

- (void)setLatitudeValue:(double)inLatitudeValue ;

- (void)setTodaysDateInDate:(NSDate*) inDate;

- (int) getNumberOfDaysSinceJan1st1900InDate ;
- (int) getNumberOfDaysSinceJan1st1900:(NSString*)endDateString;
- (double)getJulianCenturyForDate;

- (double)getGeomMeanLongSun;

- (double)getGeomMeanAnomSun ;
- (double)getEccentEarthOrbit ;

- (double)getRadiansForDegrees:(double)degrees ;

- (double)getDegreesForRadians:(double)radians;

- (double)getSunEqOfCenter ;

- (double)getSunTrueLong ;
- (double)getSunTrueAnom ;

- (double)getSunRadVector;

- (double)getSunAppLong ;

- (double)getMeanObliqEcliptic;

- (double)getObliqCorr;

// this method is returning the incorrect value
// it's returning the value for a date 1 month ago!!!
// because the intermediate calculations are off...need to traverse the entire chain

- (double)getSunRtAscen;

- (double)getSunDecline ;

- (double)getVarY ;

- (double)getEqOfTime;

- (double)getHASunrise ;

- (double)getTodaysSunriseDoubleValue ;

- (double)getTodaysSunsetDoubleValue ;

- (double) getSolarNoon;

@end
