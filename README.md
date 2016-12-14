# Objective-C迭代器

# 思路
* 需要一个IteratorCursor类记录每一次数组遍历的位置`index` 和每次数组`array`。
* 如遇到数组需要压栈，如果遍历结束时改IteratorCursor `array`出栈。
* 需要一个Iterator类管理IteratorCursor类，实现`nextObject`和`allObjects`。
```objc
- (id)nextObject
{
    if (self->_originArray.count == 0) {
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
        NSArrayIteratorCursor *c = [[NSArrayIteratorCursor alloc] initWithArray:item];
        [_stack addObject:c];
        cursor = c;
        item = cursor->_array[cursor->_index];
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

```
# 趣事
* 写这个Demo纯粹好玩，个人比较喜欢递归解决问题。
* 欢迎联系我QQ：578545715交流。
