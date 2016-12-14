//
//  NSArrayIterator.h
//  LLIterator
//
//  Created by QFWangLP on 2016/12/14.
//  Copyright © 2016年 LeeFengHY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArrayIterator : NSObject

- (instancetype)initWithArray:(NSArray *)originArray;
- (id)nextObject;
- (NSArray *)allObjects;

@end
