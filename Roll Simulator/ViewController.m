//
//  ViewController.m
//  Roll Simulator
//
//  Created by Brad Taylor on 2/20/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import "ViewController.h"
#import "RollSystem.h"

@interface ViewController () {
    NSInteger attempts;
}

@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

@property (weak, nonatomic) IBOutlet UILabel *attemptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *spentLabel;

@property (strong, nonatomic) NSMutableDictionary *collected;

@property (nonatomic, strong) RollSystem *rollSystem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    attempts = 0;
    self.rollSystem = [[RollSystem alloc] init];
   
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 180.0, 300.0, 280.0) style:UITableViewStylePlain];
    self.legendaries = tableView;
   
    [self.view addSubview:self.legendaries];
    
    self.legendaries.dataSource = self;
    self.legendaries.delegate = self;
    
    
    
    tableView = nil;
}

- (IBAction)didPressRollButton:(UIButton *)sender {
    // update label for winner
    NSString *winner = [self.rollSystem doARoll];
    self.winnerLabel.text = winner;
    self.attemptsLabel.text = [NSString stringWithFormat:@"%@", @(++attempts)];
    self.spentLabel.text = [NSString stringWithFormat:@"%@", @(attempts * 150)];
    
    if ( [self.rollSystem isLegendary:winner] ) { // add to dictionary and update count
        if ( ! [self.collected valueForKey:winner] ) { // new one
            NSLog(@"New Legendary found: %@", winner);
            [self.collected setObject:[NSNumber numberWithInt:1] forKey:winner];
        }
        else { // existing, update the amount
            NSInteger value = [[self.collected valueForKey:winner] integerValue];
            value += 1;
            NSLog(@"Existing Legendary found: %@, %ld", winner, (long)value);
            [self.collected setValue:[NSNumber numberWithInteger:value] forKey:winner];
        }
        [self.legendaries reloadData];
    }
    winner = nil;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;//[self.collected count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSString *name = [self tableView:tableView titleForHeaderInSection:section];
    return [[self.collected allKeys] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.collected allKeys] objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeroCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *name = [[self.collected allKeys] objectAtIndex:indexPath ];// tableView:tableView titleForHeaderInSection:indexPath.row];
    NSString *amount = [self.collected valueForKey:name];// objectAtIndex:indexPath.row];
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = amount;
    
    return cell;
}

-(NSMutableDictionary *)collected
{
    if ( ! _collected )
        _collected = [[NSMutableDictionary alloc] init];
    return _collected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
