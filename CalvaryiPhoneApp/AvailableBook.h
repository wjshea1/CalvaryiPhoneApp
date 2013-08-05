//
//  AvailableBook.h
//  CalvaryiPhoneApp
//
//  Created by Bill Shea on 7/20/13.
//  Copyright (c) 2013 Calvary Chapel Mercer County. All rights reserved.
//

#import "JSONModel.h"

@interface AvailableBook : JSONModel
@property(strong, nonatomic) NSString *name;
@property( nonatomic) NSInteger id;
//@property(nonatomic) NSInteger count;
@end
