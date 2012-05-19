/*
 * IRFormField.m
 *
 * This file implements the IRFormField base class.
 *
 * Copyright 2012 ImaginaryRealities, LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMANGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import "IRFormField.h"

@implementation IRFormField

#pragma mark Initializers

- (id)init {
    return nil;
}

- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)aModel {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    model = aModel;
    keyPath = [dictionary objectForKey:@"KeyPath"];
    
    return self;
}

- (id)initWithPropertyList:(NSString *)propertyListName
                    bundle:(NSBundle *)bundle
                     model:(id)aModel {
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    
    NSString *path = [bundle pathForResource:propertyListName ofType:@"plist"];
    if (!path) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];

    NSError *error = nil;
    NSDictionary *dictionary = 
        [NSPropertyListSerialization propertyListWithData:data 
                                                  options:NSPropertyListImmutable
                                                   format:NULL
                                                    error:&error];

    return [self initWithDictionary:dictionary model:aModel];
}

#pragma mark Get/set field value

- (id)value {
    return [model valueForKeyPath:keyPath];
}

- (void)setValue:(id)value {
    [model setValue:value forKeyPath:keyPath];
}

@end
