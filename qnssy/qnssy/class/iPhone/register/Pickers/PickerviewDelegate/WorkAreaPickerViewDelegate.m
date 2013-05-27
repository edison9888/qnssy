//
//  WorkAreaPickerViewDelegate.m
//  qnssy
//
//  Created by juchen on 13-5-25.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "WorkAreaPickerViewDelegate.h"
#import "AreaDatabase.h"
#import "AreaInfo.h"

@implementation WorkAreaPickerViewDelegate

- (id)init
{
    if (self = [super init]) {
        //  read provence and city datas from sqlite file
        //  init provenceArray and cityArray with datas
        self.provinceArray = [[AreaDatabase database] getProvince];
        self.cityArray = [[AreaDatabase database] getCityWithProvinceId:1];
        self.provinceId = [NSString stringWithFormat:@"%d",[[self.provinceArray objectAtIndex:0] areaId]];
        self.cityId = [NSString stringWithFormat:@"%d",[[self.cityArray objectAtIndex:0] areaId]];
        self.provinceName = [[self.provinceArray objectAtIndex:0] areaName];
        self.cityName = [[self.cityArray objectAtIndex:0] areaName];
    }
    return self;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = YES;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
//    NSString *resultMessage = [NSString stringWithFormat:@"%@ %@ selected.", self.selectedKey, self.selectedScale, nil];
//    
//    [[[UIAlertView alloc] initWithTitle:@"Success!" message:resultMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    [origin setTitle:[NSString stringWithFormat:@"%@ - %@",self.provinceName, self.cityName] forState:UIControlStateNormal];
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.provinceArray.count;
            break;
        case 1:
            return self.cityArray.count;
            break;
            
        default:
            break;
    }
    return 0;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 160;
}
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[self.provinceArray objectAtIndex:row] areaName];
            break;
        case 1:
            return [[self.cityArray objectAtIndex:row] areaName];
            break;
        default:
            break;
    }
    return nil;
}

/////////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    int areaid;
    switch (component) {
        case 0:
            areaid = [[self.provinceArray objectAtIndex:row] areaId];
            self.provinceId = [NSString stringWithFormat:@"%d",areaid];
            self.cityArray = [[AreaDatabase database] getCityWithProvinceId:areaid];
            self.provinceName = [[self.provinceArray objectAtIndex:row] areaName];
            [pickerView reloadComponent:1];
            self.cityName = [[self.cityArray objectAtIndex:0] areaName];
            break;
        case 1:
            self.cityId = [NSString stringWithFormat:@"%d",[[self.cityArray objectAtIndex:row] areaId]];
            self.cityName = [[self.cityArray objectAtIndex:row] areaName];
            break;
        default:
            break;
    }
}

@end