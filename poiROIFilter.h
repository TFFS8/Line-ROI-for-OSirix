//
//  poiROIFilter.h
//  poiROI
//

#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>

@interface poiROIFilter : PluginFilter {

}

- (long) filterImage:(NSString*) menuName;

@end
