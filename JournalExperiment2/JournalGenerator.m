//
//  JournalGenerator.m
//  journalExperimenter
//
//  Created by Jasmine Mou on 11/11/15.
//  Copyright (c) 2015 Jasmine Mou. All rights reserved.
//

#import "JournalGenerator.h"

@implementation JournalGenerator

CGSize pageSize;

-(NSString*)getJournalPath
{
    NSString* fileName = @"MyChowLog.pdf";
    NSArray* currentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSLog(@"this is currentDirectory: %@", currentDirectory);
    
    NSString* docDirectory = [currentDirectory objectAtIndex:0];
    NSLog(@"this is docDirectory: %@", docDirectory);
    
    NSString* journalPath = [docDirectory stringByAppendingPathComponent:fileName];
    
    
    journalPath = [journalPath stringByDeletingLastPathComponent];
    NSLog(@"this is journalPath: %@", journalPath);
    
    return journalPath;
}


+(void)drawPDF:(NSString*)userName secondStr:(NSString*)bDay thirdStr:(NSString*)foodCantHave firstList:(NSArray*) recipeList secondList:(NSArray*) ingredientList thirdList:(NSArray*) dateList
{
    // pageSize = CGSizeMake(612, 792);
    pageSize = CGSizeMake(612, 10000);
    // Create the PDF context using default page size
    NSString* journalPath = [self getJournalPath];
    UIGraphicsBeginPDFContextToFile(journalPath, CGRectZero, nil);
    
    // Mark the beginning of a page
    //UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(-20, 0, 612, 10000), nil);
    
    [self drawText:userName secondStr:bDay thirdStr:foodCantHave firstList:recipeList secondList:ingredientList thirdList:dateList];
    
    
    UIGraphicsEndPDFContext();
}

+(void)drawText: (NSString*)userName secondStr:(NSString*)bDay thirdStr:(NSString*)foodCantHave firstList:(NSArray*) recipeList secondList:(NSArray*) ingredientList thirdList:(NSArray*) dateList
{
    // context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, pageSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect textRect = CGRectMake(0, 0, pageSize.width, pageSize.height);
    CGPathAddRect(path, NULL, textRect);
    
    // text
    NSString *textString = [self getTextBlock:userName secondStr:bDay thirdStr:foodCantHave firstList:recipeList secondList:ingredientList thirdList:dateList];
    
    // set text attributes
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];  /*CHANGE CONTENTS HERE*/
    NSDictionary *attrs = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:textString attributes:attrs];
    
    // frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [textString length]), path, NULL);
    
    // draw
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}


+(NSString*)getTextBlock:(NSString*)userName secondStr:(NSString*)bDay thirdStr:(NSString*)foodCantHave firstList:(NSArray*) recipeList secondList:(NSArray*) ingredientList thirdList:(NSArray*) dateList{
    NSString *textBlock = @"\n";
    
    // TITLE
    NSString *title = @"MY CHOW REPORT \n\n";                 /*CHANGE CONTENTS HERE*/
    textBlock = [textBlock stringByAppendingString:title];
    
    // NAME
    NSString *nameTag = @"Name";
    NSString *nameContent = userName;                    /*CHANGE CONTENTS HERE*/
    NSString *name= [NSString stringWithFormat:@"%@: %@ \n\n", nameTag, nameContent];
    textBlock = [textBlock stringByAppendingString:name];
    
    // DOB
    NSString *DOBContent = bDay;                   /*CHANGE CONTENTS HERE*/
    NSString *DOB = [NSString stringWithFormat:@"DOB: %@ \n\n", DOBContent];
    textBlock = [textBlock stringByAppendingString:DOB];
    
    // ALLERGY
    NSString *allergies = @"Allergies: \n";
    NSString *allergyArray = foodCantHave; /*CHANGE CONTENTS HERE*/
//    NSUInteger allergyCount = [allergyArray count];
//    
//    for(int iterator = 0; iterator < allergyCount - 1; iterator ++){
//        NSString *algyEntry = [NSString stringWithFormat:@"%@, ", allergyArray[iterator]];
//    }
    allergies = [allergies stringByAppendingString:allergyArray];
//    NSString *lastAlgyEntry = @" \n\n";
//    allergies = [allergies stringByAppendingString:lastAlgyEntry];
    
    textBlock = [textBlock stringByAppendingString:allergies];
    
    // RECIPES HISTORY
    NSString *history = @"\n\nRecipe History: \n";

    //// Raw Data Format Translation
    NSArray *recipeNames = recipeList;
    
    NSArray *recipeIngs = ingredientList;
    
    NSArray *dateArray = dateList;
    
    //// Data Structure of recipeDict and historyDict
    
    //// recipeDict
    //// key: recipe name
    //// value: recipe ingredients
    
    NSMutableDictionary *recipeDict = [NSMutableDictionary dictionaryWithObjects:recipeIngs forKeys:recipeNames];
    NSLog(@"%@", recipeDict); // test recipeDict
    
        
    //// historyDict
    //// key: date
    //// value: an array of recipe names
    
    NSArray *recipeDay0 = @[recipeNames[0]];
    NSArray *recipeDay1 = @[recipeNames[1], recipeNames[2]];
    
    NSMutableDictionary *historyDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              recipeDay0, dateArray[0],
                              recipeDay1, dateArray[1],
                              nil];
    NSLog(@"%@", historyDict); // test historyDict
    
    //// output
    
    NSUInteger historyCount = [dateArray count];
    
    
    for(int k = 0; k < historyCount; k++){
        NSString *dateContent = dateArray[k];
        NSString *date = [NSString stringWithFormat:@"\n%@ \n", dateContent];
        history = [history stringByAppendingString:date];
        
        NSArray *recipeNamesSingleDay = historyDict[dateContent];
        for(id recipeNameContent in recipeNamesSingleDay){
            NSString *recipeName = [NSString stringWithFormat:@"\n%@: \n", recipeNameContent];
            history = [history stringByAppendingString:recipeName];
            
            NSString *recipeIngSingleDayContent = recipeDict[recipeNameContent];
            NSString *recipeIng = [NSString stringWithFormat:@"%@ \n", recipeIngSingleDayContent];
            history = [history stringByAppendingString:recipeIng];
        }
    }
    
    textBlock = [textBlock stringByAppendingString:history];
    
    // END
    textBlock = [textBlock stringByAppendingString:@"end. \n"];
    return textBlock;
}

+ (NSString*)getJournalPath{
    
    NSString* fileName = @"MyChowLog.pdf";
    NSArray* currentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString* docDirectory = [currentDirectory objectAtIndex:0];
    NSString* journalPath = [docDirectory stringByAppendingPathComponent:fileName];
    
    return journalPath;
}



@end
