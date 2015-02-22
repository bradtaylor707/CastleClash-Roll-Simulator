//
//  RollSystem.h
//  Roll Simulator
//
//  Created by Brad Taylor on 2/20/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RollSystem : NSObject

-(NSString *) doARoll;
-(id) getRandomFromArray:(NSArray *) array;
-(BOOL) isLegendary:(NSString *) hero;

@end
