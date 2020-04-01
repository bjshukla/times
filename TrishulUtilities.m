//
//  TrishulUtilities.m
//  Mahurat
//
//  Created by BHAVIN SHUKLA on 10/18/13.
//  Copyright (c) 2013 Trishul. All rights reserved.
//

#import "TrishulUtilities.h"

@implementation TrishulUtilities
{
    double longitudeValue;
    double latitudeValue;
    bool daylightSavingsTimeFlag;
    double timeZoneOffset;
    
    NSDate* todaysDate;
    double todaysSunriseInDouble;
    double todaysSunsetInDouble;
}
- (double)getLongitudeValue  {
    return longitudeValue;
}
- (double)getLatitudeValue  {
    return latitudeValue;
}

- (void) setDayLightSavingsTimeFlag:(BOOL)inFlag {
    daylightSavingsTimeFlag = inFlag;
}

- (void) setTimeZoneOffset:(double)inTimeZoneOffset {
    timeZoneOffset = inTimeZoneOffset;
}

- (double) getTimeZoneOffset {
    return timeZoneOffset;
}
- (void)setLongitudeValue:(double)inLongitudeValue  {
    longitudeValue = inLongitudeValue;
}

- (void)setLatitudeValue:(double)inLatitudeValue {
    latitudeValue = inLatitudeValue;
}

- (void)setTodaysDateInDate:(NSDate*) inDate {
    todaysSunriseInDouble = -999.99;
    todaysSunsetInDouble = -999.99;
    
    todaysDate = inDate;
    [self getGivenDateInString:todaysDate];
    
}

- (NSDate*) getTodaysDate {
    return todaysDate;
}

- (int) getNumberOfDaysSinceJan1st1900InDate {
    int difference = 0;
    NSString *start = @"1900-01-01";
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    // [f release];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:todaysDate
                                                         options:0];
    //[gregorianCalendar release];
    difference = [components day];
    return difference;
    
}
- (int) getNumberOfDaysSinceJan1st1900:(NSString*)endDateString {
    int difference = 0;
    NSString *start = @"1900-01-01";
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:endDateString];
    // [f release];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    //[gregorianCalendar release];
    difference = [components day];
    return difference;
}
- (double)getJulianCenturyForDate {
    int difference = [self getNumberOfDaysSinceJan1st1900InDate];
    int JulianDay = 2415018 + difference;
    double JulianCentury = ((double)JulianDay-2451545) /36525;
    return JulianCentury;
}

- (double)getGeomMeanLongSun {
    double jc = [self getJulianCenturyForDate];
    double number = 280.46646+(jc*(36000.76983 + (jc*0.0003032)));
    int divisor = 360;
    
    //MOD(280.46646+G8*(36000.76983 + G8*0.0003032),360)
    double returnDouble = fmod(number, divisor);
    return returnDouble;
}

- (double)getGeomMeanAnomSun {
    double jc = [self getJulianCenturyForDate];
    double returnDouble = 0.00;
    returnDouble = 357.52911 + jc*(35999.05029 - 0.0001537*jc);
    return returnDouble;
}

- (double)getEccentEarthOrbit {
    double jc = [self getJulianCenturyForDate];
    double returnDouble = 0.00;
    returnDouble = 0.016708634-jc*(0.000042037+0.0000001267*jc);
    return returnDouble;
}

- (double)getRadiansForDegrees:(double)degrees {
    double radians = degrees * 3.141592653589 / 180.0;
    return radians;
}

- (double)getDegreesForRadians:(double)radians {
    //=(B1*180)/3.141592653589
    double degrees = radians * 180 / 3.141592653589;
    return degrees;
}

- (double)getSunEqOfCenter {
    double returnDouble = 0.00;
    //SIN(RADIANS(J8))*(1.914602-G8*(0.004817+0.000014*G8))+SIN(RADIANS(2*J8))*(0.019993-0.000101*G8)+SIN(RADIANS(3*J8))*0.000289
    //g8 = julian century
    //j8 = geom mean anom sun
    double jc = [self getJulianCenturyForDate];
    double gmas = [self getGeomMeanAnomSun];
    double radiansOfgmas = [self getRadiansForDegrees:gmas];
    double radiansOfgmasTimes2 = [self getRadiansForDegrees:gmas*2];
    double radiansOfgmasTimes3 = [self getRadiansForDegrees:gmas*3];
    double sinOfgmas = sin(radiansOfgmas);
    double sinOfgmasTimes2 = sin(radiansOfgmasTimes2);
    double sinOfgmasTimes3 = sin(radiansOfgmasTimes3);
    returnDouble = sinOfgmas * (1.914602-jc*(0.004817+0.000014*jc)) + sinOfgmasTimes2*(0.01993-0.000101*jc) + sinOfgmasTimes3*0.000289;
    return returnDouble;
}

- (double)getSunTrueLong {
    double returnDouble = 0.0;
    double geomMeanLongSun = [self getGeomMeanLongSun];
    double sunEqOfCenter = [self getSunEqOfCenter];
    returnDouble = geomMeanLongSun + sunEqOfCenter;
    return returnDouble;
}
- (double)getSunTrueAnom {
    double returnDouble = 0.0;
    double geomMeanAnomSun = [self getGeomMeanAnomSun];
    double sunEqOfCenter = [self getSunEqOfCenter];
    returnDouble = geomMeanAnomSun + sunEqOfCenter;
    return returnDouble;
}

- (double)getSunRadVector {
    double returnDouble = 0.00;
    double eccentEarthOrbit = [self getEccentEarthOrbit];
    double sunTrueAnom = [self getSunTrueAnom];
    double radiansOfSunTrueAnom = [self getRadiansForDegrees:sunTrueAnom];
    double cosOfSunTrueAnom = cos(radiansOfSunTrueAnom);
    // (1.000001018*(1-K8*K8))/(1+K8*COS(RADIANS(N8)))
    returnDouble = (1.000001018*(1-eccentEarthOrbit*eccentEarthOrbit))/(1+eccentEarthOrbit*cosOfSunTrueAnom);
    return returnDouble;
}

- (double)getSunAppLong {
    // M8-0.00569-0.00478*SIN(RADIANS(125.04-1934.136*G8))
    // m8 = sun true long
    // g8 = julian century
    double returnDouble = 0.00;
    double sunTrueLong = [self getSunTrueLong];
    double jc = [self getJulianCenturyForDate];
    double radiansOfJulianCenturyDerivative = [self getRadiansForDegrees:(125.04-1934.136*jc)];
    double sinOfJulianCenturyDerivative = sin(radiansOfJulianCenturyDerivative);
    returnDouble = sunTrueLong - 0.00569-0.00478*sinOfJulianCenturyDerivative;
    return returnDouble;
}

- (double)getMeanObliqEcliptic {
    double returnDouble = 0.0;
    // =23+(26+((21.448-G8*(46.815+G8*(0.00059-G8*0.001813))))/60)/60
    // g8 = julian century
    double jc = [self getJulianCenturyForDate];
    returnDouble = 23+(26+((21.448-jc*(46.815+jc*(0.00059-jc*0.001813))))/60)/60;
    return returnDouble;
}

- (double)getObliqCorr {
    double returnDouble = 0.0;
    // =Q8+0.00256*COS(RADIANS(125.04-1934.136*G8))
    //q8 = mean obliq ecliptic
    // g8 = julian century
    double jc = [self getJulianCenturyForDate];
    double radiansOfJulianCenturyDerivative = [self getRadiansForDegrees:(125.04-1934.136*jc)];
    double cosOfJulianCenturyDerivative = cos(radiansOfJulianCenturyDerivative);
    double meanObliqEcliptic = [self getMeanObliqEcliptic];
    returnDouble = meanObliqEcliptic+0.00256*cosOfJulianCenturyDerivative;
    
    return returnDouble;
    
}

// this method is returning the incorrect value
// it's returning the value for a date 1 month ago!!!
// because the intermediate calculations are off...need to traverse the entire chain

- (double)getSunRtAscen {
    double returnDouble = 0.00;
    // =DEGREES(ATAN2(COS(RADIANS(P8)),COS(RADIANS(R8))*SIN(RADIANS(P8))))
    // p8 = sun app long
    // r8 = obliq corr
    double sunAppLong = [self getSunAppLong];
    double radiansOfSunAppLong = [self getRadiansForDegrees:sunAppLong];
    double cosOfSunAppLong = cos(radiansOfSunAppLong);
    
    double obliqCorr = [self getObliqCorr];
    double radiansOfObliqCorr = [self getRadiansForDegrees:obliqCorr];
    double cosOfObliqCorr = cos(radiansOfObliqCorr);
    
    double sinOfSunAppLong = sin(radiansOfSunAppLong);
    
    double intermediateProduct = cosOfObliqCorr*sinOfSunAppLong;
    
    double atan2Of2Points = atan2(cosOfSunAppLong, intermediateProduct);
    
    double degreesOfAtan2 = [self getDegreesForRadians:atan2Of2Points];
    returnDouble = degreesOfAtan2;
    return returnDouble;
}

- (double)getSunDecline {
    // DEGREES(ASIN(SIN(RADIANS(R8)) * SIN(RADIANS(P8))))
    // r8 = obliq corr
    // p8 = sun app long
    double returnDouble = 0.00;
    double obliqCorr = [self getObliqCorr];
    double radiansOfObliqCorr = [self getRadiansForDegrees:obliqCorr];
    double sinOfRadiansOfObliqCorr = sin(radiansOfObliqCorr);
    
    double sunAppLong = [self getSunAppLong];
    double radiansOfSunAppLong = [self getRadiansForDegrees:sunAppLong];
    double sinOfRadiansOfSunAppLong = sin(radiansOfSunAppLong);
    
    double intermediateProduct = sinOfRadiansOfObliqCorr*sinOfRadiansOfSunAppLong;
    
    double asinOfProduct = asin(intermediateProduct);
    double degreesOfAsin = [self getDegreesForRadians:asinOfProduct];
    returnDouble = degreesOfAsin;
    return returnDouble;
}

- (double)getVarY {
    double returnDouble = 0.00;
    // =TAN(RADIANS(R8/2))*TAN(RADIANS(R8/2))
    // r8 = obliq corr
    double obliqCorr = [self getObliqCorr];
    double obliqCorrDividedBy2 = obliqCorr/2;
    double radiansOfObliqCorr = [self getRadiansForDegrees:obliqCorrDividedBy2];
    double tanOfRadiansOfObliqCorr = tan(radiansOfObliqCorr);
    
    returnDouble = tanOfRadiansOfObliqCorr*tanOfRadiansOfObliqCorr;
    
    return returnDouble;
}

- (double)getEqOfTime {
    double returnDouble = 0.00;
    // 4*DEGREES(U8*SIN(2*RADIANS(I8))-2*K8*SIN(RADIANS(J8))+4*K8*U8*SIN(RADIANS(J8))*COS(2*RADIANS(I8))-0.5*U8*U8*SIN(4*RADIANS(I8))-1.25*K8*K8*SIN(2*RADIANS(J8)))
    // u8 = var Y
    // i8 = geom mean long sun
    // k8 = eccent earth orbit
    // j8 = geom mean anom sun
    
    double varY = [self getVarY];
    
    double geomMeanLongSun = [self getGeomMeanLongSun];
    double radiansOfGeomMeanLongSun = [self getRadiansForDegrees:geomMeanLongSun];
    double radiansOfGeomMeanLongSunTimes2 = radiansOfGeomMeanLongSun*2;
    double sinOfradiansOfGeomMeanLongSunTimes2 = sin(radiansOfGeomMeanLongSunTimes2);
    double cosOfradiansOfGeomMeanLongSunTimes2 = cos(radiansOfGeomMeanLongSunTimes2);
    double radiansOfGeomMeanLongSunTimes4 = radiansOfGeomMeanLongSun*4;
    double sinOfradiansOfGeomMeanLongSunTimes4 = sin(radiansOfGeomMeanLongSunTimes4);
    
    double eccentEarthOrbit = [self getEccentEarthOrbit];
    
    double geomMeanAnomSun = [self getGeomMeanAnomSun];
    double radiansOfGeomMeanAnomSun = [self getRadiansForDegrees:geomMeanAnomSun];
    double sinOfradiansOfGeomMeanAnomSun = sin(radiansOfGeomMeanAnomSun);
    double radiansOfGeomMeanAnomSunTimes2 = radiansOfGeomMeanAnomSun*2;
    double sinOfradiansOfGeomMeanAnomSunTimes2 = sin(radiansOfGeomMeanAnomSunTimes2);
    
    
    double product1 = varY*sinOfradiansOfGeomMeanLongSunTimes2;
    double product2 = 2*eccentEarthOrbit*sinOfradiansOfGeomMeanAnomSun;
    double product3 = 4*eccentEarthOrbit*varY*sinOfradiansOfGeomMeanAnomSun*cosOfradiansOfGeomMeanLongSunTimes2;
    double product4 = 0.5*varY*varY*sinOfradiansOfGeomMeanLongSunTimes4;
    double product5 = 1.25*eccentEarthOrbit*eccentEarthOrbit*sinOfradiansOfGeomMeanAnomSunTimes2;
    double intermediateProduct = product1-product2+product3-product4-product5;
    double degreesOfIntermediateProduct = [self getDegreesForRadians:intermediateProduct];
    returnDouble = 4*degreesOfIntermediateProduct;
    
    return returnDouble;
}

- (double)getHASunrise {
    double returnDouble = 0.00;
    // DEGREES(ACOS (COS(RADIANS(90.833)) / (COS(RADIANS($B$2)) * COS(RADIANS(T8))) - TAN(RADIANS($B$2)) * TAN(RADIANS(T8)) ) )
    // b2 = latitude of location
    // t8 = sun decline
    
    double radiansOfFix = [self getRadiansForDegrees:90.833];
    double cosOfRadiansOfFix = cos(radiansOfFix);
    
    double localLatitude = [self getLatitudeValue];
    double radiansOfLatitude = [self getRadiansForDegrees:localLatitude];
    double cosOfRadiansOfLatitude = cos(radiansOfLatitude);
    double tanOfRadiansOfLatitude = tan(radiansOfLatitude);
    
    double sunDecline = [self getSunDecline];
    double radiansOfSunDecline = [self getRadiansForDegrees:sunDecline];
    double cosOfRadiansOfSunDecline = cos(radiansOfSunDecline);
    double tanOfRadiansOfSunDecline = tan(radiansOfSunDecline);
    
    double product = (cosOfRadiansOfFix / (cosOfRadiansOfLatitude * cosOfRadiansOfSunDecline)) - (tanOfRadiansOfLatitude * tanOfRadiansOfSunDecline);
    double acosOfProduct = acos(product);
    double degreesOfAcosOfProduct = [self getDegreesForRadians:acosOfProduct];
    returnDouble = degreesOfAcosOfProduct;
    
    return returnDouble;
}

- (NSString *) getGivenDateInString:(NSDate*) inDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, MMM d,''yy"];
    NSString *returnString = [formatter stringFromDate:inDate];
    
    return returnString;
}

- (double)getTodaysSunriseDoubleValue {
    if (todaysSunriseInDouble == -999.99) {
        // (X8*1440-W8*4)/1440
        // x8 = solar noon
        // w8 = ha sunrise
        
        double solarNoon = [self getSolarNoon];
        double haSunrise = [self getHASunrise];
        todaysSunriseInDouble = (solarNoon*1440-haSunrise*4)/1440;
        NSLog(@"Today's Sunrise = %f", todaysSunriseInDouble);
    }
    return todaysSunriseInDouble;
    
}
- (NSString*)convertDoubleToDateFormat:(double)d {
    //    NSNumber *theDouble = [NSNumber numberWithDouble:d];
    NSString* ampm = @"AM";
    int inputSeconds = d * 24 * 60 * 60;
    int hours =  inputSeconds / 3600;
    if  (hours >= 12) {
        ampm = @"PM";
        if (hours > 12) {
            hours = hours - 12;
        }
    }
    int minutes = ( inputSeconds - (hours * 3600) ) % 60;
    //int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
    //    NSString *theTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
    NSString *theTime = [NSString stringWithFormat:@"%.2d:%.2d %@", hours, minutes, ampm];
    
    return theTime;
}
- (double)getTodaysSunsetDoubleValue {
    if (todaysSunsetInDouble == -999.99) {
        
        // (X8*1440+W8*4)/1440
        // x8 = solar noon
        // w8 = ha sunrise
        
        double solarNoon = [self getSolarNoon];
        double haSunrise = [self getHASunrise];
        todaysSunsetInDouble = (solarNoon*1440+haSunrise*4)/1440;
    }
    
    return todaysSunsetInDouble;
}

- (double) getSolarNoon {
    double returnDouble = 0.00;
    // (720-4*$B$3-V8+$B$4*60)/1440
    // b3 = longitude
    // b4 = timezone
    // v8 = eq of time
    double localLongitude = [self getLongitudeValue];
    double localTimeZoneOffset = [self getTimeZoneOffset];
    double eqOfTime = [self getEqOfTime];
    returnDouble = (720-4*localLongitude-eqOfTime+localTimeZoneOffset*60)/1440;
    NSString* solarnoonTimeString = [self convertDoubleToDateFormat:returnDouble];
    NSLog(@"Solar Noon = %@", solarnoonTimeString);
    return returnDouble;
}


@end
