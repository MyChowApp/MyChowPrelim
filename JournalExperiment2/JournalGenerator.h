//
//  JournalGenerator.h
//  journalExperimenter
//
//  Created by Jasmine Mou on 11/11/15.
//  Copyright (c) 2015 Jasmine Mou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@interface JournalGenerator : NSObject

+(void)drawPDF:(NSString*)userName secondStr:(NSString*)bDay thirdStr:(NSString*)foodCantHave firstList:(NSArray*) recipeList secondList:(NSArray*) ingredientList thirdList:(NSArray*) dateList;

+(NSString*)getTextBlock:(NSString*)userName secondStr:(NSString*)bDay thirdStr:(NSString*)foodCantHave firstList:(NSArray*) recipeList secondList:(NSArray*) ingredientList thirdList:(NSArray*) dateList;
@end
