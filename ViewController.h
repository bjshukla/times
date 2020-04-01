//
//  ViewController.h
//  Mahurat
//
//  Created by BHAVIN SHUKLA on 10/18/13.
//  Copyright (c) 2013 Trishul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)pickDateButtonAction:(id)sender;
@property (nonatomic, strong) NSMutableArray *cityArrayList;
@property (nonatomic, strong) NSArray *globalCityArray;

-(IBAction)showMessage;

//-(IBAction)getCoordinatesForCurrentLocation;
- (NSDate*)convertStringToDate:(NSString*) inDateString;
- (NSString*)convertDoubleToDateFormat:(double)d;
- (NSString *) getChoghadiyuInString:(int) choghadiyuInt;

@end

