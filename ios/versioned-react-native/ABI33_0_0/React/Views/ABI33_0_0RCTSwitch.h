/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>

#import <ReactABI33_0_0/ABI33_0_0RCTComponent.h>

@interface ABI33_0_0RCTSwitch : UISwitch

@property (nonatomic, assign) BOOL wasOn;
@property (nonatomic, copy) ABI33_0_0RCTBubblingEventBlock onChange;

@end
