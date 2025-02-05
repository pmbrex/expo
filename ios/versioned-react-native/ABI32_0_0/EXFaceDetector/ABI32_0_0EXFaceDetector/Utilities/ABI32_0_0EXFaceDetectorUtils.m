//
//  ABI32_0_0EXFaceDetectorUtils.m
//  Exponent
//
//  Created by Stanisław Chmiela on 22.11.2017.
//  Copyright © 2017 650 Industries. All rights reserved.
//

#import <ABI32_0_0EXFaceDetector/ABI32_0_0EXFaceDetectorUtils.h>
#import <ABI32_0_0EXFaceDetector/ABI32_0_0CSBufferOrientationCalculator.h>
#import "Firebase.h"

NSString *const ABI32_0_0EXGMVDataOutputWidthKey = @"Width";
NSString *const ABI32_0_0EXGMVDataOutputHeightKey = @"Height";

static const NSString *kModeOptionName = @"mode";
static const NSString *kDetectLandmarksOptionName = @"detectLandmarks";
static const NSString *kRunClassificationsOptionName = @"runClassifications";
static const NSString *kTrackingEnabled = @"tracking";

@implementation ABI32_0_0EXFaceDetectorUtils

+ (NSDictionary *)constantsToExport
{
  return @{
           @"Mode" : @{
               @"fast" : @(FIRVisionFaceDetectorPerformanceModeFast),
               @"accurate" : @(FIRVisionFaceDetectorPerformanceModeAccurate)
               },
           @"Landmarks" : @{
               @"all" : @(FIRVisionFaceDetectorLandmarkModeAll),
               @"none" : @(FIRVisionFaceDetectorLandmarkModeNone)
               },
           @"Classifications" : @{
               @"all" : @(FIRVisionFaceDetectorClassificationModeAll),
               @"none" : @(FIRVisionFaceDetectorClassificationModeNone)
               }
           };
}

+ (BOOL)didOptionsChange:(FIRVisionFaceDetectorOptions *)options comparingTo:(FIRVisionFaceDetectorOptions *)other
{
  return options.performanceMode == other.performanceMode &&
  options.classificationMode == other.classificationMode &&
  options.contourMode == other.contourMode &&
  options.minFaceSize == other.minFaceSize &&
  options.landmarkMode == other.landmarkMode &&
  options.trackingEnabled == other.trackingEnabled;
}

+ (FIRVisionFaceDetectorOptions *)createCopy:(FIRVisionFaceDetectorOptions *)from
{
  FIRVisionFaceDetectorOptions *options = [FIRVisionFaceDetectorOptions new];
  options.performanceMode = from.performanceMode;
  options.classificationMode = from.classificationMode;
  options.contourMode = from.contourMode;
  options.minFaceSize = from.minFaceSize;
  options.landmarkMode = from.landmarkMode;
  options.trackingEnabled = from.trackingEnabled;
  return options;
}


+ (FIRVisionFaceDetectorOptions *) mapOptions:(NSDictionary*)options {
  return [self newOptions:[FIRVisionFaceDetectorOptions new] withValues:options];
}

+ (FIRVisionFaceDetectorOptions *) newOptions:(FIRVisionFaceDetectorOptions*)options withValues:(NSDictionary *)values
{
  FIRVisionFaceDetectorOptions *result = [self createCopy:options];
  if([values objectForKey:kModeOptionName]) {
    result.performanceMode = [values[kModeOptionName] longValue];
  }
  if([values objectForKey:kDetectLandmarksOptionName]) {
    result.landmarkMode = [values[kDetectLandmarksOptionName] longValue];
  }
  if([values objectForKey:kRunClassificationsOptionName]) {
    result.classificationMode = [values[kRunClassificationsOptionName] longValue];
  }
  if([values objectForKey:kTrackingEnabled]) {
    result.trackingEnabled = values[kTrackingEnabled];
  }
  return result;
}

+ (BOOL) areOptionsEqual:(FIRVisionFaceDetectorOptions *)first to:(FIRVisionFaceDetectorOptions*)second {
  return [self didOptionsChange:first comparingTo:second];
}

+ (NSDictionary *)defaultFaceDetectorOptions
{
  return @{
           kModeOptionName: @(FIRVisionFaceDetectorPerformanceModeFast),
           kDetectLandmarksOptionName: @(FIRVisionFaceDetectorLandmarkModeNone),
           kRunClassificationsOptionName: @(FIRVisionFaceDetectorClassificationModeNone)
           };
}

+ (int)toCGImageOrientation:(UIImageOrientation)imageOrientation
{
  switch (imageOrientation) {
    case UIImageOrientationUp:
      return kCGImagePropertyOrientationUp;
      break;
    case UIImageOrientationUpMirrored:
      return kCGImagePropertyOrientationUpMirrored;
      break;
    case UIImageOrientationDown:
      return kCGImagePropertyOrientationDown;
      break;
    case UIImageOrientationDownMirrored:
      return kCGImagePropertyOrientationDownMirrored;
      break;
    case UIImageOrientationRight:
      return kCGImagePropertyOrientationRight;
      break;
    case UIImageOrientationRightMirrored:
      return kCGImagePropertyOrientationRightMirrored;
      break;
    case UIImageOrientationLeft:
      return kCGImagePropertyOrientationLeft;
      break;
    case UIImageOrientationLeftMirrored:
      return kCGImagePropertyOrientationLeftMirrored;
      break;
  }
};

# pragma mark - Encoder helpers

+ (ABI32_0_0EXFaceDetectionAngleTransformBlock)angleTransformerFromTransform:(CGAffineTransform)transform
{
  return ^(float angle) {
    return (float)(angle - (atan2(transform.b, transform.a) * (180 / M_PI)));
  };
}

@end
