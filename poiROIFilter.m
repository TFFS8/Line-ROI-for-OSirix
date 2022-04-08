//
//  poiROIFilter.m
//  poiROI
//
//  Plugin with a line ROI that provides statistics regarding the ROI points
//

#import "poiROIFilter.h"

@implementation poiROIFilter

- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{

    NSArray     *PixList = [viewerController pixList];
    int         curSlice =  [[viewerController imageView] curImage];
    DCMPix      *curPix = [PixList objectAtIndex: curSlice];
    
    NSMutableArray  *roiSeriesList  = [viewerController roiList];
    NSMutableArray  *roiImageList = [roiSeriesList objectAtIndex: curSlice];
    
    int i,j;
    
    double meansum=0;
    double mean=0;
    double std=0;
    int points;
    double min=999999;
    double max=0;

    
    for( i = 0; i < [roiImageList count]; i++)
    {
        if( [[roiImageList objectAtIndex: i] ROImode] == ROI_selected)
        {
    
            ROI *Roimus;
            Roimus=[roiImageList objectAtIndex:i];
            NSMutableArray  *pts = [Roimus points];
            
            int xoc[[pts count]];
            int yoc[[pts count]];
            double values[[pts count]];
            
            for (j = 0; j < [pts count]; j++){
                
                xoc[j]=[Roimus pointAtIndex:j].x;
                yoc[j]=[Roimus pointAtIndex:j].y;
                values[j]=[curPix getPixelValueX:xoc[j] Y:yoc[j]];
                meansum=meansum+values[j];
                
                if(values[j]<min){
                    min=values[j];
                 }
                
                if(values[j]>max){
                    max=values[j];
                }
                
                    
            }
            
            mean=meansum/[pts count];
            
            for (j = 0; j < [pts count]; j++){
                
            std+=(values[j]-mean)*(values[j]-mean);
                
            
            }
            points=[pts count];
            std=sqrt(std/[pts count]);
            
        }
    }
            

    NSString    *MyResult = [NSString stringWithFormat:@"Nr. Points:%d \nMin:%.3f \nMax:%.3f \nSum:%.3f \n\nMean:%.3f \nStd:%.3f",points,min,max,meansum,mean, std];
    
    NSRunInformationalAlertPanel(@"poiROI - ROI points info",MyResult,@"OK", 0L, 0L);
	
	return 0;
	
}

@end
