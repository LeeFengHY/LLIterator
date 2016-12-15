//
//  NSArrayIterator.m
//  LLIterator
//
//  Created by QFWangLP on 2016/12/14.
//  Copyright © 2016年 LeeFengHY. All rights reserved.
//

#import "NSArrayIterator.h"

@interface NSArrayIteratorCursor : NSObject
{
    @package
    NSArray *_array;
    NSInteger _index;
}
- (instancetype)initWithArray:(NSArray *)array;
@end

@implementation NSArrayIteratorCursor

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _array = array;
        _index = 0;
    }
    return self;
}
@end

@implementation NSArrayIterator
{
    @package
    NSMutableArray *_stack;
    NSArray *_originArray;
}

- (instancetype)initWithArray:(NSArray *)originArray
{
    self = [super init];
    if (self) {
        _originArray = originArray;
        _stack = [NSMutableArray array];
        [self setupStackWithArray:originArray];
    }
    return self;
}

- (void)setupStackWithArray:(NSArray *)array
{
    NSArrayIteratorCursor *cursor = [[NSArrayIteratorCursor alloc] initWithArray:array];
    [_stack addObject:cursor];
}

- (id)nextObject
{
    if (self->_stack.count == 0) {
        return nil;
    }
    NSArrayIteratorCursor *cursor = [self->_stack lastObject];
    while (cursor->_index == cursor->_array.count && self->_stack.count > 0) {
        [self->_stack removeLastObject];
        if (self->_stack.count == 0) break;
        cursor = [_stack lastObject];
    }
    if (_stack.count == 0) {
        return nil;
    }
    //[0,1,[3,4],[5,[6,7]],8]
    id item = cursor->_array[cursor->_index];
    while ([item isKindOfClass:[NSArray class]]) {
        cursor->_index++;
#if 0
        NSArrayIteratorCursor *c = [[NSArrayIteratorCursor alloc] initWithArray:item];
        [_stack addObject:c];
        cursor = c;
        if (cursor->_array.count == 0) {
            item = nil;
            break;
        }
        item = cursor->_array[cursor->_index];
#endif
        [self setupStackWithArray:item];
        return [self nextObject];
    }
    cursor->_index++;
    return item;
}

- (NSArray *)allObjects
{
    NSMutableArray *result = [NSMutableArray new];
    [self fillArray:_originArray into:result];
    return result;
}

- (void)fillArray:(NSArray *)array into:(NSMutableArray *)result
{
    for (NSInteger i = 0, max = array.count; i < max; i++) {
        id item = array[i];
        if ([item isKindOfClass:[NSArray class]]) {
            [self fillArray:item into:result];
        }else{
            [result addObject:item];
        }
    }
}
@end
