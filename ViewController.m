//
//  ViewController.m
//  Mahurat
//
//  Created by BHAVIN SHUKLA on 10/18/13.
//  Copyright (c) 2013 Trishul. All rights reserved.
//

#import "ViewController.h"
#import "TrishulUtilities.h"
#import "TrishulCity.h"

/*
 @interface ViewController ()
 
 @end
 */

@implementation ViewController
@synthesize datePicker;
@synthesize cityPicker;
@synthesize cityArrayList;
@synthesize globalCityArray;

@synthesize locationManager;

NSMutableArray *locationsArray;
NSArray *universalChoghadiya;

const int NUMBER_OF_CHOGHADIYAS = 8;
NSMutableArray* WEEK_DAYTIME_CHOGHADIYA;
NSMutableArray* WEEK_NIGHTTIME_CHOGHADIYA;

NSMutableArray* SUNDAY_DAY_CHOGHADIYA;
NSMutableArray* MONDAY_DAY_CHOGHADIYA;
NSMutableArray* TUESDAY_DAY_CHOGHADIYA;
NSMutableArray* WEDNESDAY_DAY_CHOGHADIYA;
NSMutableArray* THURSDAY_DAY_CHOGHADIYA;
NSMutableArray* FRIDAY_DAY_CHOGHADIYA;
NSMutableArray* SATURDAY_DAY_CHOGHADIYA;

NSMutableArray* SUNDAY_NIGHT_CHOGHADIYA;
NSMutableArray* MONDAY_NIGHT_CHOGHADIYA;
NSMutableArray* TUESDAY_NIGHT_CHOGHADIYA;
NSMutableArray* WEDNESDAY_NIGHT_CHOGHADIYA;
NSMutableArray* THURSDAY_NIGHT_CHOGHADIYA;
NSMutableArray* FRIDAY_NIGHT_CHOGHADIYA;
NSMutableArray* SATURDAY_NIGHT_CHOGHADIYA;

const NSInteger CHOGHADIYU_CHAL = 1;
const NSInteger CHOGHADIYU_LABH = 2;
const NSInteger CHOGHADIYU_AMRUT = 3;
const NSInteger CHOGHADIYU_SHUBH = 4;
const NSInteger CHOGHADIYU_UDVEG = 5;
const NSInteger CHOGHADIYU_ROG = 6;
const NSInteger CHOGHADIYU_KAL = 7;

- (void) initializeChoghadiyas {
    
    SUNDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG], nil];
    MONDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT], nil];
    TUESDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG], nil];
    WEDNESDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH], nil];
    THURSDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH], nil];
    FRIDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL], nil];
    SATURDAY_DAY_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_KAL], nil];
    
    WEEK_DAYTIME_CHOGHADIYA = [[NSMutableArray alloc]init];
    
    [WEEK_DAYTIME_CHOGHADIYA addObject:SUNDAY_DAY_CHOGHADIYA];
    [WEEK_DAYTIME_CHOGHADIYA addObject:MONDAY_DAY_CHOGHADIYA];
    [WEEK_DAYTIME_CHOGHADIYA addObject:TUESDAY_DAY_CHOGHADIYA];
    [WEEK_DAYTIME_CHOGHADIYA addObject:WEDNESDAY_DAY_CHOGHADIYA];
    [WEEK_DAYTIME_CHOGHADIYA addObject:THURSDAY_DAY_CHOGHADIYA];
    [WEEK_DAYTIME_CHOGHADIYA addObject:FRIDAY_DAY_CHOGHADIYA];
    [WEEK_DAYTIME_CHOGHADIYA addObject:SATURDAY_DAY_CHOGHADIYA];
    
    // NIGHT TIME CHOGHADIYA
    
    SUNDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH], nil];
    MONDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL], nil];
    TUESDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL], nil];
    WEDNESDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG], nil];
    THURSDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT], nil];
    FRIDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG], nil];
    SATURDAY_NIGHT_CHOGHADIYA = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:CHOGHADIYU_LABH],[NSNumber numberWithInt:CHOGHADIYU_UDVEG],[NSNumber numberWithInt:CHOGHADIYU_SHUBH],[NSNumber numberWithInt:CHOGHADIYU_AMRUT],[NSNumber numberWithInt:CHOGHADIYU_CHAL],[NSNumber numberWithInt:CHOGHADIYU_ROG],[NSNumber numberWithInt:CHOGHADIYU_KAL],[NSNumber numberWithInt:CHOGHADIYU_LABH], nil];
    
    WEEK_NIGHTTIME_CHOGHADIYA = [[NSMutableArray alloc]init];
    
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:SUNDAY_NIGHT_CHOGHADIYA];
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:MONDAY_NIGHT_CHOGHADIYA];
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:TUESDAY_NIGHT_CHOGHADIYA];
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:WEDNESDAY_NIGHT_CHOGHADIYA];
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:THURSDAY_NIGHT_CHOGHADIYA];
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:FRIDAY_NIGHT_CHOGHADIYA];
    [WEEK_NIGHTTIME_CHOGHADIYA addObject:SATURDAY_NIGHT_CHOGHADIYA];
    
}

- (NSString *) getChoghadiyuInString:(int) choghadiyuInt {
    NSString* choghadiyuInString;
    switch (choghadiyuInt) {
        case CHOGHADIYU_CHAL:
            choghadiyuInString = @"Chal";
            break;
        case CHOGHADIYU_LABH:
            choghadiyuInString = @"Labh";
            break;
        case CHOGHADIYU_AMRUT:
            choghadiyuInString = @"Amrut";
            break;
        case CHOGHADIYU_SHUBH:
            choghadiyuInString = @"Shubh";
            break;
        case CHOGHADIYU_UDVEG:
            choghadiyuInString = @"Udveg";
            break;
        case CHOGHADIYU_ROG:
            choghadiyuInString = @"Rog";
            break;
        case CHOGHADIYU_KAL:
            choghadiyuInString = @"Kal";
            break;
        default:
            break;
    }
    return choghadiyuInString;
}

// todaysWeekday is already formatted to handle the rolling day (Sunday =1, Saturday = 7)
- (NSString *) printDayChoghadiya:(int)todaysWeekday withTodaysSunrise:(double)todaysSunrise withDayUnit:(double)dayUnit {
    // todaysWeekDay is a date DAY variable...but need to subtract 1 to make it array index friendly
    double temp1 = todaysSunrise;
    double temp2 = 0.00;
    NSString* returnString = @"";
    NSString *temp1String, *temp2String, *choghadiyuInString;
    todaysWeekday = todaysWeekday - 1;
    NSMutableArray *localArray = [WEEK_DAYTIME_CHOGHADIYA objectAtIndex:todaysWeekday];
    NSInteger localChoghadiyu = 0;
    for (int i = 0; i < NUMBER_OF_CHOGHADIYAS; i++) {
        localChoghadiyu = [[localArray objectAtIndex:i] integerValue];
        
        temp2 = temp1 + dayUnit;
        temp1String = [self convertDoubleToDateFormat:temp1];
        temp2String = [self convertDoubleToDateFormat:temp2];
        choghadiyuInString = [self getChoghadiyuInString:localChoghadiyu];
        returnString = [returnString stringByAppendingString:[self getPrintOutputOfGoodChoghadiyas:temp1String withToTime:temp2String withChoghadiyu:choghadiyuInString withChoghadiyuInInteger:localChoghadiyu]];
        NSLog(@"ReturnString = %@", returnString);
        
        temp1 = temp2;
    }
    return returnString;
}

- (Boolean) isChoghadiyuGood:(NSInteger*)inChoghadiyu {
    Boolean returnFlag = false;
    int c = inChoghadiyu;
    
    if (c == CHOGHADIYU_AMRUT || c == CHOGHADIYU_LABH || c == CHOGHADIYU_SHUBH) {
        returnFlag = true;
    }
    return returnFlag;
}
- (NSString *) printEarlyMorningChoghadiya:(int)yesterdaysWeekday withYesterdaysSunset:(double)yesterdaysSunset withNightUnit:(double)nightUnit {
    // yesterdaysWeekday is a date DAY variable...but need to subtract 1 to make it array index friendly
    double temp1 = yesterdaysSunset;
    double temp2 = 0.00;
    NSString* returnString = @"";
    NSString *temp1String, *temp2String, *choghadiyuInString;
    yesterdaysWeekday = yesterdaysWeekday - 1;
    NSMutableArray *localArray = [WEEK_NIGHTTIME_CHOGHADIYA objectAtIndex:yesterdaysWeekday];
    NSInteger localChoghadiyu = 0;
    BOOL dayChanged = NO;
    for (int i = 0; i < NUMBER_OF_CHOGHADIYAS; i++) {
        temp2 = temp1 + nightUnit;
        if (temp2 > 1.00) {
            dayChanged = YES;
            temp2 = temp2 - 1.00;
        }
        if (dayChanged == YES) {
            if (temp1 > temp2) {
                temp1 = 0.00;
            }
            localChoghadiyu = [[localArray objectAtIndex:i] integerValue];
            temp1String = [self convertDoubleToDateFormat:temp1];
            temp2String = [self convertDoubleToDateFormat:temp2];
            choghadiyuInString = [self getChoghadiyuInString:localChoghadiyu];
            // print only the good choghadiyas!!
            returnString = [returnString stringByAppendingString:[self getPrintOutputOfGoodChoghadiyas:temp1String withToTime:temp2String withChoghadiyu:choghadiyuInString withChoghadiyuInInteger: localChoghadiyu]];
            
            NSLog(@"ReturnString = %@", returnString);
        }
        temp1 = temp2;
    }
    return returnString;
}

- (NSString *) getPrintOutputOfGoodChoghadiyas:(NSString*) fromTime withToTime:(NSString*) toTime withChoghadiyu: (NSString*) choghadiyu withChoghadiyuInInteger:(NSInteger) intChoghadiyu{
    int c = intChoghadiyu;
    NSString* returnString = @"";

    // why doesn't following code work??
    /*
    Boolean b = [self isChoghadiyuGood:&intChoghadiyu];
    if (b == true)
    {
        */
    if (c == CHOGHADIYU_AMRUT || c == CHOGHADIYU_LABH || c == CHOGHADIYU_SHUBH) {
        
        NSLog(@"%@-%@ = %@", fromTime, toTime, choghadiyu);
        returnString = [returnString stringByAppendingString:fromTime];
        returnString = [returnString stringByAppendingString:@"-"];
        returnString = [returnString stringByAppendingString:toTime];
        returnString = [returnString stringByAppendingString:@": "];
        returnString = [returnString stringByAppendingString:choghadiyu];
        returnString = [returnString stringByAppendingString:@"\n"];
    }
    return returnString;
    
}
- (NSString*) printEveningChoghadiya:(int)todaysWeekday withTodaysSunset:(double)todaysSunset withNightUnit:(double)nightUnit {
    // todaysWeekday is a date DAY variable...but need to subtract 1 to make it array index friendly
    double temp1 = todaysSunset;
    double temp2 = 0.00;
    NSString* returnString = @"";
    NSString *temp1String, *temp2String, *choghadiyuInString;
    todaysWeekday = todaysWeekday - 1;
    NSMutableArray *localArray = [WEEK_NIGHTTIME_CHOGHADIYA objectAtIndex:todaysWeekday];
    NSInteger localChoghadiyu = 0;
    BOOL dayChanged = NO;
    
    for (int i = 0; i < NUMBER_OF_CHOGHADIYAS; i++) {
        temp2 = temp1 + nightUnit;
        if (temp2 > 1.00) {
            temp2 = temp2 - 1.00;
        }
        if (dayChanged == NO) {
            if (temp2 < temp1) {
                temp2 = 0.00;
                dayChanged = YES;
            }
            localChoghadiyu = [[localArray objectAtIndex:i] integerValue];
            temp1String = [self convertDoubleToDateFormat:temp1];
            temp2String = [self convertDoubleToDateFormat:temp2];
            choghadiyuInString = [self getChoghadiyuInString:localChoghadiyu];
            returnString = [returnString stringByAppendingString:[self getPrintOutputOfGoodChoghadiyas:temp1String withToTime:temp2String withChoghadiyu:choghadiyuInString withChoghadiyuInInteger:localChoghadiyu]];
            NSLog(@"ReturnString = %@", returnString);
            
        }
        temp1 = temp2;
    }
    return returnString;
}

- (NSString *)getMessageOfCityCoordinates {
    NSString *messageOfCityCoordinates = @"Coordinates for New Jersey are";
    return messageOfCityCoordinates;
}

/*
 - (void)addLocationObjectToArray:(MyLocation*)inputLocation {
 [locationsArray addObject:inputLocation];
 }
 */

- (NSDate*)convertStringToDate:(NSString*) inDateString {
    NSDate* localDate;
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    localDate = [f dateFromString:inDateString];
    return localDate;
}

- (NSString*)printChoghadiya:(NSDate*) inDate withYesterdaysSunset:(double) yesterdaysSunset
           withTodaysSunrise:(double) todaysSunrise withTodaysSunset:(double) todaysSunset {
    // Assumption: Tomorrow's Sunrise is same as today's sunrise
    NSString* returnString = @"";
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:inDate];
    
    // weekday: SUNDAY = 1; MONDAY = 2; TUESDAY = 3; WEDNESDAY = 4; THURSDAY = 5; FRIDAY = 6
    // SATURDAY = 7
    int todaysWeekDay = [weekdayComponents weekday];
    int tomorrowsWeekday = todaysWeekDay + 1;
    if (tomorrowsWeekday == 8) {
        tomorrowsWeekday = 1;
    }
    int yesterdaysWeekday = todaysWeekDay - 1;
    if (yesterdaysWeekday == 0) {
        yesterdaysWeekday = 7;
    }
    
    // tomorrow's night choghadiya
    double yesterdaysNightChoghadiyaElapsedTime = 1 - yesterdaysSunset + todaysSunrise;
    double nightUnit = yesterdaysNightChoghadiyaElapsedTime / 8;
    double dayUnit = (todaysSunset - todaysSunrise) / 8;
    returnString = [returnString stringByAppendingString:[self printEarlyMorningChoghadiya:yesterdaysWeekday withYesterdaysSunset:yesterdaysSunset withNightUnit:nightUnit]];
    returnString = [returnString stringByAppendingString:[self printDayChoghadiya:todaysWeekDay  withTodaysSunrise:todaysSunrise withDayUnit:dayUnit]];
    returnString = [returnString stringByAppendingString:[self printEveningChoghadiya:todaysWeekDay withTodaysSunset:todaysSunset withNightUnit:nightUnit]];
    return returnString;
}

- (NSString*)convertDoubleToDateFormat:(double)d {
    //    NSNumber *theDouble = [NSNumber numberWithDouble:d];
    NSString* ampm = @"AM";
    double dd = d * 24*3600;
    NSNumber *theDouble = [NSNumber numberWithDouble:dd];
    int inputSeconds = [theDouble intValue];
    int hours = inputSeconds / 3600;
    
    int minutes = (inputSeconds - hours * 3600)/60;
    //int seconds = inputSeconds - hours * 3600 - minutes * 60;
    if (hours > 12) {
        hours = hours - 12;
        ampm = @"PM";
    }
    NSString *theTime = [NSString stringWithFormat:@"%.2d:%.2d %@", hours, minutes, ampm];
    return theTime;
}

/*
 - (void)printChoghadiya:(NSDate*) inDate withYesterdaysSunset:(double) yesterdaysSunset
 withTodaysSunrise:(double) todaysSunrise withTodaysSunset:(double) todaysSunset {
 */

- (NSString*)getChoghadiyasForDateAndLocation:(NSDate*) inDate withLocation:(TrishulCity*)inputCity {
    //MyLocation *myLocation = [[MyLocation alloc] init];
    NSLog (@"Input City: %@", [inputCity getString]);
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    dateString = [formatter stringFromDate:inDate];
    
    NSLog (@"Input Date: %@", dateString);
        
    [self initializeChoghadiyas];
    
    // MyLocation *locationFromArray = [locationsArray objectAtIndex:1];
    
    NSString *coordinatesAlertTitleString = @"Coordinates Title";
    //NSString *messageString = [self getMessageOfCityCoordinates];
    // NSString *messageString = [myLocation getString];
    //NSString *messageString = [locationFromArray getString];
    NSString *messageString = @"";
    
    NSString *cancelBUttonTitleString = @"Close";
    // NSString *otherButtonTitleString = @"Other";
    
    /*
     NSString *todaysDateString = @"2013-08-14";
     NSDate *todaysDateObject = [self convertStringToDate:todaysDateString];
     */
    
    [inputCity setTodaysDateInDate:inDate];
    
    /*
     int daysSince1900 = [myLocation getNumberOfDaysSinceJan1st1900:todaysDateString];
     NSString *daysSince1900String;
     daysSince1900String = [NSString stringWithFormat:@"%d", daysSince1900];
     */
    
    // HERE IS WHAT's being printed
    double todaysSunriseValue = [inputCity getTodaysSunriseInDouble];
    double todaysSunsetValue = [inputCity getTodaysSunsetInDouble];
    // Assumption: Yesterday's sunset is same as today's sunset
    double yesterdaysSunsetValue = [inputCity getTodaysSunsetInDouble];
    //yesterdaysSunsetValue = 0.99;
    NSString* todaysSunriseString = [self convertDoubleToDateFormat:todaysSunriseValue];
    
    NSString* todaysSunsetString = [self convertDoubleToDateFormat:todaysSunsetValue];
    NSString* printString = [[NSString alloc] init];
    printString = [printString stringByAppendingString:[self printChoghadiya:inDate withYesterdaysSunset:yesterdaysSunsetValue withTodaysSunrise:todaysSunriseValue withTodaysSunset:todaysSunsetValue]];
    
    //messageString = [myLocation convertDoubleToDateFormat:sunsetValue];
    //messageString = [messageString stringByAppendingString:@"Today's Date = "];
    //NSString *todaysDateInString = [self getGivenDateInString:inDate];
    //messageString = [messageString stringByAppendingString:todaysDateInString];
    messageString = [messageString stringByAppendingString:@"Sunrise: "];
    messageString = [messageString stringByAppendingString:todaysSunriseString];
    messageString = [messageString stringByAppendingString:@"\nSunset = "];
    messageString = [messageString stringByAppendingString:todaysSunsetString];
    //    messageString = [messageString stringByAppendingString:@"; Yesterday's Sunset = "];
    //    messageString = [messageString stringByAppendingString:yesterdaysSunsetString];
    messageString = [messageString stringByAppendingString:@"\nChoghadiyas:\n"];
    messageString = [messageString stringByAppendingString:printString];
    //messageString = [NSString stringWithFormat:@"Today's Sunrise = %s", productValue];
    
    UIAlertView *coordinatesAlert = [[UIAlertView alloc]
                                     initWithTitle:coordinatesAlertTitleString message:messageString delegate:nil cancelButtonTitle:cancelBUttonTitleString otherButtonTitles:nil];
    [coordinatesAlert show];
    return messageString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*cityArrayList = [[NSArray alloc]
     initWithObjects:@"Piscataway",@"Mumbai",@"London",nil];
     */
    
    TrishulCity* usa_hi_hawaii = [[TrishulCity alloc] initWithValues:@"Hawaii" withLongitude:-74.00597 withLatitude:40.71435 withCityTimeZone:@"HST" withTimeZoneOffset:-10 withDaylightDependence:YES withDayLightSavingsTimeOffset:1];
    TrishulCity *usa_ca_losangeles = [[TrishulCity alloc] initWithValues:@"Los Angeles, CA" withLongitude:-118.24368 withLatitude:34.05223 withCityTimeZone:@"PDT" withTimeZoneOffset:-8 withDaylightDependence:YES withDayLightSavingsTimeOffset:1];
    TrishulCity *usa_az_phoenix = [[TrishulCity alloc] initWithValues:@"Phoenix, AZ" withLongitude:-118.24368 withLatitude:34.05223 withCityTimeZone:@"MST" withTimeZoneOffset:-7 withDaylightDependence:YES withDayLightSavingsTimeOffset:1];
    TrishulCity *usa_il_chicago = [[TrishulCity alloc] initWithValues:@"Chicago, IL" withLongitude:-87.62980 withLatitude:41.87811 withCityTimeZone:@"CDT" withTimeZoneOffset:-6 withDaylightDependence:YES withDayLightSavingsTimeOffset:1];
    TrishulCity* usa_ny_newyork = [[TrishulCity alloc] initWithValues:@"New York, NY" withLongitude:-74.00597 withLatitude:40.71435 withCityTimeZone:@"EST" withTimeZoneOffset:-5 withDaylightDependence:YES withDayLightSavingsTimeOffset:1];
    TrishulCity *india_maharashtra_mumbai = [[TrishulCity alloc] initWithValues:@"Mumbai" withLongitude:72.87766 withLatitude:19.07598 withCityTimeZone:@"IST" withTimeZoneOffset:5.5 withDaylightDependence:NO withDayLightSavingsTimeOffset:0];
    TrishulCity *uk_london = [[TrishulCity alloc] initWithValues:@"London" withLongitude:-0.11982 withLatitude:51.51121 withCityTimeZone:@"BST" withTimeZoneOffset:0 withDaylightDependence:YES withDayLightSavingsTimeOffset:1];
    /*
     TrishulCity* usa_ny_newyork = [[TrishulCity alloc] init];
     [usa_ny_newyork setCityName:@"New York"];
     [usa_ny_newyork setCityLatitude:40];
     [usa_ny_newyork setCityLongitude:50];
     TrishulCity* usa_il_chicago = [[TrishulCity alloc] init];
     [usa_il_chicago setCityName:@"Chicago"];
     TrishulCity* usa_ca_losangeles = [[TrishulCity alloc] init];
     [usa_ca_losangeles setCityName:@"Los Angeles"];
     TrishulCity* india_maharashtra_mumbai = [[TrishulCity alloc] init];
     [india_maharashtra_mumbai setCityName:@"Mumbai"];
     TrishulCity* uk_london = [[TrishulCity alloc] init];
     [uk_london setCityName:@"London"];
     */
    globalCityArray = [[NSArray alloc] initWithObjects:usa_ny_newyork, usa_il_chicago, usa_az_phoenix, usa_ca_losangeles, usa_hi_hawaii, india_maharashtra_mumbai, uk_london, nil];
    
    cityArrayList = [[NSMutableArray alloc] initWithCapacity:5];
    /*
     cityArrayList = [[NSMutableArray alloc] initWithObjects:[usa_ny_newyork getCityName], [usa_il_chicago getCityName], [usa_ca_losangeles getCityName], [india_maharashtra_mumbai getCityName], [uk_london getCityName], nil];
     */
    TrishulCity *tempCity;
    NSString *tempCityName;
    for (int i = 0; i < globalCityArray.count; i++) {
        tempCity = [globalCityArray objectAtIndex:i];
        NSLog (@"Adding City: %@", [tempCity getString]);
        
        tempCityName = [tempCity getCityName];
        NSLog(@"Adding %@ at index %d", tempCityName, i);
        [cityArrayList insertObject:tempCityName atIndex:i];
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    locationManager.desiredAccuracy = kCLErrorDeferredAccuracyTooLow;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
    [locationManager stopUpdatingLocation];
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    //    NSLog(@"Latitude = %@", latitude);
    //    NSLog(@"Longitude = %@", longitude);
    //
    //    NSLog(@"2 Latitude: %f", locationManager.location.coordinate.latitude);
    //    NSLog(@"2 Longitude: %f", locationManager.location.coordinate.longitude);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *) getGivenDateInString:(NSDate*) inDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, MMM d,''yy"];
    NSString *returnString = [formatter stringFromDate:inDate];
    return returnString;
}

- (IBAction)pickDateButtonAction:(id)sender {
    NSDate *dateChosen = [datePicker date];
    int cityChosenIndex = [cityPicker selectedRowInComponent:0];
    //NSString *cityChosen = cityArrayList[cityChosenIndex];
    TrishulCity *chosenCity = [globalCityArray objectAtIndex:cityChosenIndex];
    
    NSString *outputFromMethod = [self getChoghadiyasForDateAndLocation:dateChosen
                                                           withLocation:chosenCity];
    NSLog(@"output = %@", outputFromMethod);
    
    /*
     
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"EEEE MM.dd.yyyy"];
     NSString *datePicked = [formatter stringFromDate:dateChosen];
     NSString *msg = [[NSString alloc] initWithFormat:@"Chosen Date %@, Chosen City %@", datePicked, cityChosen];
     
     UIAlertView *myAlert = [[UIAlertView alloc]
     initWithTitle:@"Message"
     message:msg
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [myAlert show];
     */
}

// row #s start from 0
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [cityArrayList objectAtIndex:row];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [cityArrayList count];
}
@end
