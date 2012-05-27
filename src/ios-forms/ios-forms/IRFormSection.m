/*
 * IRFormSection.m
 *
 * This file implements the IRFormSection class.
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

#import "IRFormSection.h"
#import "IRTextFormField.h"

@implementation IRFormSection

@synthesize footer;
@synthesize header;

#pragma mark - Initializers

- (id)init {
    return nil;
}

- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)model {
    self = [super init];
    if (!self) {
        return self;
    }
    
    header = [dictionary objectForKey:@"Header"];
    footer = [dictionary objectForKey:@"Footer"];
    
    NSArray *formFields = [dictionary objectForKey:@"Fields"];
    NSUInteger fieldCount = [formFields count];
    fields = [[NSMutableArray alloc] initWithCapacity:fieldCount];
    for (NSUInteger i = 0; i < fieldCount; i++) {
        NSDictionary *formField = [formFields objectAtIndex:i];
        IRFormField *field = [[IRTextFormField alloc] initWithDictionary:formField model:model];
        [fields addObject:field];
    }
    
    return self;
}

- (id)initWithPropertyList:(NSString *)propertyListName
                    bundle:(NSBundle *)bundle
                     model:(id)model {
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
    
    return [self initWithDictionary:dictionary model:model];
}

#pragma mark - Number of fields in the section

- (NSInteger)numberOfFields {
    return [fields count];
}

- (IRFormField *)fieldAtIndex:(NSInteger)index {
    return [fields objectAtIndex:index];
}

@end
