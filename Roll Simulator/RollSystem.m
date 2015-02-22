//
//  RollSystem.m
//  Roll Simulator
//
//  Created by Brad Taylor on 2/20/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import "RollSystem.h"
#import <UIKit/UIKit.h>

@interface RollSystem () {
    NSInteger winner;
    NSInteger subWinner;
}

@property (nonatomic, strong) NSArray *gemLegendaries;
@property (nonatomic, strong) NSArray *shardLegendaries;
@property (nonatomic, strong) NSArray *elites;
@property (nonatomic, strong) NSArray *ordinaries;
@property (nonatomic, strong) NSArray *slimes;

@end

@implementation RollSystem

-(NSString *) doARoll
{
    winner = (random() % 100) + 1;
    
    if ( winner >= 1 && winner <= 5 ) { // legendary, need subcase
        subWinner = (random() % 100) + 1;
        if ( subWinner >= 1 && subWinner <= 35 ) // gem
            return [self getRandomFromArray:self.gemLegendaries];
        else // shard
            return [self getRandomFromArray:self.shardLegendaries];
    }
    else if ( winner >= 6 && winner <= 65) // elite
        return [self getRandomFromArray:self.elites];
    else if ( winner >= 66 && winner <= 75 ) // ordinary
        return [self getRandomFromArray:self.ordinaries];
    else { // slime, need subcase
        subWinner = (random() % 100) + 1;
        if ( subWinner >= 1 && subWinner <= 85 )
            return @"Crystal Ooze";
        else
            return @"Gelatinus Champion";
    }
}

-(id) getRandomFromArray:(NSArray *)array
{
    long unsigned index = random () % [array count];
    return [array objectAtIndex:index];
}

-(BOOL) isLegendary:(NSString *)hero
{
    if ( [hero isEqualToString:@"Gelatinus Champion"] || winner <= 5 )
        return YES;
    return NO;
}

-(NSArray *) gemLegendaries
{
    if ( ! _gemLegendaries )
        _gemLegendaries = [NSArray arrayWithObjects:@"Pumpkin Duke", @"Snowzilla", @"Cupid", @"Aries", @"Vlad Dracula", @"Orksbane", @"Santa Boom", @"Pixie", nil];
    return _gemLegendaries;
}

-(NSArray *) shardLegendaries
{
    if ( ! _shardLegendaries )
        _shardLegendaries = [NSArray arrayWithObjects:@"Paladin",
                        @"Champion", @"Succubus", @"Druid", @"Ninja", @"Thunder God", @"Atlanticore", @"Grizzly Reaper", @"Immortep", nil];
    return _shardLegendaries;
}

-(NSArray *) elites
{
    if ( ! _elites )
        _elites = [NSArray arrayWithObjects:@"Executioner", @"Assassin", @"Werewolf", @"Cyclops", @"Shaman", @"Pain-Da", @"Serpent Queen", @"Ice Demon", @"Triton", nil];
    return _elites;
}

-(NSArray *) ordinaries
{
    if ( ! _ordinaries )
        _ordinaries = [NSArray arrayWithObjects:@"Angel", @"Marauder", @"Hill Giant", @"Engineer", @"Frost Witch", @"Dryad", @"Alchemist", @"Marksman", nil];
    return _ordinaries;
}

-(NSArray *) slimes
{
    if ( ! _slimes )
        _slimes = [NSArray arrayWithObjects:@"Crystal Ooze", @"Gelatinous Champion", nil];
    return _slimes;
}

@end
