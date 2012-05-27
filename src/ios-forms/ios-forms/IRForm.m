/*
 * IRForm.m
 *
 * This file implements the IRForm class.
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

#import "IRForm.h"
#import "IRFormSection.h"
#import "IRFormField.h"

@implementation IRForm

#pragma mark - Initializers

- (id)init {
    return nil;
}

- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)model {
    self = [super init];
    if (!self) {
        return self;
    }

    NSArray *formSections = [dictionary objectForKey:@"Sections"];
    NSUInteger numberOfSections = [formSections count];
    sections = [[NSMutableArray alloc] initWithCapacity:numberOfSections];
    for (NSUInteger i = 0; i < numberOfSections; i++) {
        NSDictionary *formSection = [formSections objectAtIndex:i];
        IRFormSection *section = [[IRFormSection alloc]
                                  initWithDictionary:formSection
                                  model:model];
        [sections addObject:section];
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
    if (error) {
        return nil;
    }
    
    return [self initWithDictionary:dictionary model:model];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IRFormSection *formSection = [sections objectAtIndex:section];
    return [formSection numberOfFields];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IRFormSection *formSection = [sections objectAtIndex:[indexPath section]];
    IRFormField *formField = [formSection fieldAtIndex:[indexPath row]];
    return [formField cellForTableView:tableView];
}

@end
