//
//  CharGridVIew.h
//  IF
//
//  Created by Daren David Taylor on 22/04/2014.
//  Copyright (c) 2014 com.DDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoryWritable.h"

@interface CharGridView : UIView <MemoryWritable>

- (void)setupWithRows:(NSUInteger)rowCount colCount:(NSUInteger)colCount;

@end
