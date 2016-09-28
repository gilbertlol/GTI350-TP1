//
//  ViewController.m
//  ScoreBoard
//
//  Created by serge nassar on 2016-09-18.
//  Copyright © 2016 serge nassar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *equipe1Txt;
@property (weak, nonatomic) IBOutlet UILabel *equipe1ScoreLbl;
@property (weak, nonatomic) IBOutlet UITableView *equipe1Tbl;
@property (weak, nonatomic) IBOutlet UIButton *equip1RemoveBtn;
@property (weak, nonatomic) IBOutlet UITextField *equipe1PlayerTxt;
@property (weak, nonatomic) IBOutlet UITextField *equipe1PlayerNumTxt;
@property (weak, nonatomic) IBOutlet UIButton *equipe1PlayerAddBtn;
@property (weak, nonatomic) IBOutlet UITextField *equipe2Txt;
@property (weak, nonatomic) IBOutlet UILabel *equipe2ScoreLbl;
@property (weak, nonatomic) IBOutlet UITableView *equipe2Tbl;
@property (weak, nonatomic) IBOutlet UIButton *equipe2RemoveBtn;
@property (weak, nonatomic) IBOutlet UITextField *equipe2PlayerTxt;
@property (weak, nonatomic) IBOutlet UITextField *equipe2PlayerNumTxt;
@property (weak, nonatomic) IBOutlet UIButton *equipe2PlayerAddBtn;
@property (weak, nonatomic) IBOutlet UITextView *logConsoleTxt;
@property (weak, nonatomic) IBOutlet UILabel *periodeLbl;
@property (weak, nonatomic) IBOutlet UIStepper *periodeStp;
@property (weak, nonatomic) IBOutlet UITextField *goalTxt;
@property (weak, nonatomic) IBOutlet UITextField *assist1Txt;
@property (weak, nonatomic) IBOutlet UITextField *assist2Txt;
@property (weak, nonatomic) IBOutlet UIButton *goalBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *equipe1GoalPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *equipe1Assist1Picker;
@property (weak, nonatomic) IBOutlet UIPickerView *equipe1Assist2Picker;
@property (weak, nonatomic) IBOutlet UIButton *equipe1AddGoalBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *equipe2GoalPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *equipe2Assist1Picker;
@property (weak, nonatomic) IBOutlet UIPickerView *equipe2Assist2Picker;
@property (weak, nonatomic) IBOutlet UIButton *equipe2AddGoalBtn;
@property (weak, nonatomic) IBOutlet UIButton *endGameBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@end

@implementation ViewController

NSMutableDictionary* team1Players;
NSMutableDictionary* team2Players;
NSMutableArray* team1Goals;
NSMutableArray* team2Goals;
NSMutableArray<Player*>* team1GPickerArr;
NSMutableArray<Player*>* team1A1PickerArr;
NSMutableArray<Player*>* team1A2PickerArr;
NSMutableArray<Player*>* team2GPickerArr;
NSMutableArray<Player*>* team2A1PickerArr;
NSMutableArray<Player*>* team2A2PickerArr;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    team1Players = [[NSMutableDictionary alloc] init];
    team1Goals = [[NSMutableArray alloc] init];
    
    team2Players = [[NSMutableDictionary alloc] init];
    team2Goals = [[NSMutableArray alloc] init];
    
    team1GPickerArr = [[NSMutableArray alloc] init];
    team1A1PickerArr = [[NSMutableArray alloc] init];
    team1A2PickerArr = [[NSMutableArray alloc] init];
    
    team2GPickerArr = [[NSMutableArray alloc] init];
    team2A1PickerArr = [[NSMutableArray alloc] init];
    team2A2PickerArr = [[NSMutableArray alloc] init];
    
    CALayer *layer = _equipe1Tbl.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: 4.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithWhite: 0.8 alpha: 1.0] CGColor]];
    
    layer = _equipe2Tbl.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: 4.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithWhite: 0.8 alpha: 1.0] CGColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logPlayerAdded:(Player*)player team:(NSString*)team {
    NSString* text = [NSString stringWithFormat:@"Ajout de : %@ a l'equipe %@.\n", player.name, team];
    _logConsoleTxt.text = [_logConsoleTxt.text stringByAppendingString:text];
    
}
- (void)logPlayerRemoved:(Player*)player team:(NSString*)team {
    NSString* text = [NSString stringWithFormat:@"Enlever de : %@ a l'equipe %@.\n", player.name, team];
    _logConsoleTxt.text = [_logConsoleTxt.text stringByAppendingString:text];
    
}

- (void)logGoalScored:(NSString*)scorer assist:(NSString*)assist quarter:(NSString*)quarter team:(NSString*)team {
    if([assist  isEqual: @""]) {
        assist = @"Sans aide";
    }
    NSString* text = [NSString stringWithFormat:@"Période: %@, %@ - But: %@, Aides: %@.\n", quarter, team, scorer, assist];
    _logConsoleTxt.text = [_logConsoleTxt.text stringByAppendingString:text];
}


- (IBAction)equipeAdd:(id)sender {
    if(sender == _equipe1PlayerAddBtn) {
        if([team1Players count] <=5 && [team1Players objectForKey:_equipe1PlayerNumTxt.text] == nil) {
            Player* player = [[Player alloc] init];
            player.number = [NSNumber numberWithInteger: [_equipe1PlayerNumTxt.text integerValue]];
            player.name = _equipe1PlayerTxt.text;
            player.equipe = 1;
            NSArray* names = [_equipe1PlayerTxt.text componentsSeparatedByString:@"-"];
            player.lastName = [names objectAtIndex:names.count-1];
            
            [team1Players setObject:player forKey:_equipe1PlayerNumTxt.text];
            
            [self logPlayerAdded:player team:@"1"];
            
            [team1GPickerArr removeAllObjects];
            
            [team1GPickerArr addObjectsFromArray:team1Players.allValues];
            
            [self reloadPicker];
            
            [_equipe1Tbl reloadData];
            
            _equipe1PlayerTxt.text = @"";
            _equipe1PlayerNumTxt.text = @"";
            
            _equipe1PlayerAddBtn.enabled = NO;
        }
    } else if([team2Players count] <=5 && [team2Players objectForKey:_equipe2PlayerNumTxt.text] == nil) {
        Player* player = [[Player alloc] init];
        player.number = [NSNumber numberWithInteger: [_equipe2PlayerNumTxt.text integerValue]];
        player.name = _equipe2PlayerTxt.text;
        player.equipe = 2;
        NSArray* names = [_equipe2PlayerTxt.text componentsSeparatedByString:@"-"];
        player.lastName = [names objectAtIndex:names.count-1];
        
        [team2Players setObject:player forKey:_equipe2PlayerNumTxt.text];
        
        [self logPlayerAdded:player team:@"2"];
        
        [team2GPickerArr removeAllObjects];
        
        [team2GPickerArr addObjectsFromArray:team2Players.allValues];
        
        [self reloadPicker];
        
        [_equipe2Tbl reloadData];
        
        _equipe2PlayerTxt.text = @"";
        _equipe2PlayerNumTxt.text = @"";
        
        _equipe2PlayerAddBtn.enabled = NO;
    }
}

- (IBAction)equipeRemove:(id)sender {
    if(sender == _equip1RemoveBtn) {
        UITableViewCell* selectedCell = [_equipe1Tbl cellForRowAtIndexPath:_equipe1Tbl.indexPathForSelectedRow];
        
        NSString* playerNumber = [[[selectedCell.textLabel.text componentsSeparatedByString:@"-"] objectAtIndex:0] stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [self logPlayerRemoved:[team1Players objectForKey:playerNumber] team:@"1"];
        
        [team1Players removeObjectForKey:playerNumber];
        
        [_equipe1Tbl reloadData];
        
        _equip1RemoveBtn.enabled = NO;
    } else {
        UITableViewCell* selectedCell = [_equipe2Tbl cellForRowAtIndexPath:_equipe2Tbl.indexPathForSelectedRow];
        NSString* playerNumber = [[[selectedCell.textLabel.text componentsSeparatedByString:@"-"] objectAtIndex:0] stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [self logPlayerRemoved:[team2Players objectForKey:playerNumber] team:@"2"];
        
        [team2Players removeObjectForKey:playerNumber];
        
        [_equipe2Tbl reloadData];
        
        _equipe2RemoveBtn.enabled = NO;
    }
}

- (IBAction)periodeStepperValueChange:(UIStepper*)sender {
    [_periodeLbl setText:[NSString stringWithFormat:@"%d", (int)sender.value]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView == _equipe1Tbl ? team1Players.allKeys.count : team2Players.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    Player* player;
    if (tableView == _equipe1Tbl) {
        player = [[team1Players allValues] objectAtIndex:indexPath.row];
    } else {
        player = [[team2Players allValues] objectAtIndex:indexPath.row];
    }
    [cell.textLabel setText:[[NSString alloc] initWithFormat:@"%@ - %@", player.number, player.name]];
    [cell.detailTextLabel setText:[[NSString alloc] initWithFormat:@"But : %d Aide : %d", player.goal, player.assist]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _equipe1Tbl) {
        if(indexPath.row >= 0) {
            _equip1RemoveBtn.enabled = YES;
        } else {
            _equip1RemoveBtn.enabled = NO;
        }
    } else {
        if(indexPath.row >= 0) {
            _equipe2RemoveBtn.enabled = YES;
        } else {
            _equipe2RemoveBtn.enabled = NO;
        }
    }
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
 (NSInteger)section{
 return @"# - Nom - But - aide";
 }*/

- (IBAction)team1PlayerValueChanged:(id)sender {
    if(_equipe1PlayerNumTxt.text.length > 0 && _equipe1PlayerTxt.text.length > 0) {
        _equipe1PlayerAddBtn.enabled = YES;
    } else {
        _equipe1PlayerAddBtn.enabled = NO;
    }
}

- (IBAction)team2PlayerValueChanged:(id)sender {
    if(_equipe2PlayerNumTxt.text.length > 0 && _equipe2PlayerTxt.text.length > 0) {
        _equipe2PlayerAddBtn.enabled = YES;
    } else {
        _equipe2PlayerAddBtn.enabled = NO;
    }
}

- (IBAction)
goalValueChanged:(id)sender {
    if(_goalTxt.text.length > 0 && _assist1Txt.text.length > 0 && _assist2Txt.text.length > 0) {
        _goalBtn.enabled = YES;
    } else {
        _goalBtn.enabled = NO;
    }
}

- (IBAction)addGoalPressed:(id)sender {
    if(sender == _equipe1AddGoalBtn) {
        int goalPosition = (int) [_equipe1GoalPicker selectedRowInComponent:0] - 1;
        int assist1Position = (int) [_equipe1Assist1Picker selectedRowInComponent:0] - 1;
        int assist2Position = (int) [_equipe1Assist2Picker selectedRowInComponent:0] - 1;

        Player* player = [team1Players objectForKey:team1GPickerArr[goalPosition].number.stringValue];
        player.goal++;
        NSString* scorerName = player.lastName;
        NSMutableString* assistNames = [[NSMutableString alloc] init];
        if(assist1Position >= 0) {
            player = [team1Players objectForKey:team1A1PickerArr[assist1Position].number.stringValue];
            player.assist++;
            [assistNames appendString:player.name];
        }
        if(assist2Position >= 0) {
            player = [team1Players objectForKey:team1A2PickerArr[assist2Position].number.stringValue];
            player.assist++;
            [assistNames appendFormat:@", %@", player.name];
        }
        [_equipe1Tbl reloadData];
        [_equipe1GoalPicker selectRow:0 inComponent:0 animated:YES];
        [team1A1PickerArr removeAllObjects];
        [team1A2PickerArr removeAllObjects];
        [self logGoalScored:scorerName assist:[NSString stringWithFormat:@"%@", assistNames] quarter:_periodeLbl.text team:_equipe1Txt.text];
    } else {
        int goalPosition = (int) [_equipe2GoalPicker selectedRowInComponent:0] - 1;
        int assist1Position = (int) [_equipe2Assist1Picker selectedRowInComponent:0] - 1;
        int assist2Position = (int) [_equipe2Assist2Picker selectedRowInComponent:0] - 1;
        Player* player = [team2Players objectForKey:team2GPickerArr[goalPosition].number.stringValue];
        player.goal++;
        NSString* scorerName = player.name;
        NSMutableString* assistNames = [[NSMutableString alloc] init];
        if(assist1Position >= 0) {
            player = [team2Players objectForKey:team2A1PickerArr[assist1Position].number.stringValue];
            player.assist++;
            [assistNames appendString:player.name];
        }
        if(assist2Position >= 0) {
            player = [team2Players objectForKey:team2A2PickerArr[assist2Position].number.stringValue];
            player.assist++;
            [assistNames appendFormat:@", %@", player.name];
        }
        [_equipe2Tbl reloadData];
        [_equipe2GoalPicker selectRow:0 inComponent:0 animated:YES];
        [team2A1PickerArr removeAllObjects];
        [team2A2PickerArr removeAllObjects];
        [self logGoalScored:scorerName assist:[NSString stringWithFormat:@"%@", assistNames] quarter:_periodeLbl.text team:_equipe2Txt.text];
    }
    [self reloadGoals];
    [self reloadPicker];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return (int) 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == _equipe1GoalPicker) {
        return (int) team1GPickerArr.count + 1;
    } else if(pickerView == _equipe1Assist1Picker) {
        return (int) team1A1PickerArr.count + 1;
    } else if(pickerView == _equipe1Assist2Picker) {
        return (int) team1A2PickerArr.count + 1;
    } else if(pickerView == _equipe2GoalPicker) {
        return (int) team2GPickerArr.count + 1;
    } else if(pickerView == _equipe2Assist1Picker) {
        return (int) team2A1PickerArr.count + 1;
    } else if(pickerView == _equipe2Assist2Picker) {
        return (int) team2A2PickerArr.count + 1;
    }
    return 1;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == _equipe1GoalPicker) {
        if(row == 0) {
            _equipe1AddGoalBtn.enabled = NO;
            return @"But";
        }
        _equipe1AddGoalBtn.enabled = YES;
        return team1GPickerArr[row - 1].toPickerString;
    } else if(pickerView == _equipe1Assist1Picker) {
        if(row == 0) {
            return @"Aide";
        }
        return team1A1PickerArr[row - 1].toPickerString;
    } else if(pickerView == _equipe1Assist2Picker) {
        if(row == 0) {
            return @"Aide";
        }
        return team1A2PickerArr[row - 1].toPickerString;
    } else if(pickerView == _equipe2GoalPicker) {
        if(row == 0) {
            _equipe2AddGoalBtn.enabled = NO;
            return @"But";
        }
        _equipe2AddGoalBtn.enabled = YES;
        return team2GPickerArr[row - 1].toPickerString;
    } else if(pickerView == _equipe2Assist1Picker) {
        if(row == 0) {
            return @"Aide";
        }
        return team2A1PickerArr[row - 1].toPickerString;
    } else if(pickerView == _equipe2Assist2Picker) {
        if(row == 0) {
            return @"Aide";
        }
        return team2A2PickerArr[row - 1].toPickerString;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView == _equipe1GoalPicker) {
        [team1A1PickerArr removeAllObjects];
        if(row == 0) {
            [team1A2PickerArr removeAllObjects];
        } else {
            for(Player* player in team1GPickerArr) {
                if(player != team1GPickerArr[row - 1]) {
                    [team1A1PickerArr addObject:player];
                }
            }
        }
    } else if(pickerView == _equipe1Assist1Picker) {
        [team1A2PickerArr removeAllObjects];
        if(row != 0) {
            for(Player* player in team1A1PickerArr) {
                if(player != team1A1PickerArr[row - 1]) {
                    [team1A2PickerArr addObject:player];
                }
            }
        }
    }  else if(pickerView == _equipe2GoalPicker) {
        [team2A1PickerArr removeAllObjects];
        if(row == 0) {
            [team2A2PickerArr removeAllObjects];
        } else {
            for(Player* player in team2GPickerArr) {
                if(player != team2GPickerArr[row - 1]) {
                    [team2A1PickerArr addObject:player];
                }
            }
        }
    } else if(pickerView == _equipe2Assist1Picker) {
        [team2A2PickerArr removeAllObjects];
        if(row != 0) {
            for(Player* player in team2A1PickerArr) {
                if(player != team2A1PickerArr[row - 1]) {
                    [team2A2PickerArr addObject:player];
                }
            }
        }
    }
    [self reloadPicker];
}

-(void)reloadPicker {
    [_equipe1GoalPicker reloadAllComponents];
    [_equipe1Assist1Picker reloadAllComponents];
    [_equipe1Assist2Picker reloadAllComponents];
    [_equipe2GoalPicker reloadAllComponents];
    [_equipe2Assist1Picker reloadAllComponents];
    [_equipe2Assist2Picker reloadAllComponents];
}

-(void)reloadGoals {
    int goals = 0;
    for(Player* player in team1Players.allValues) {
        goals += player.goal;
    }
    _equipe1ScoreLbl.text = [NSString stringWithFormat:@"%d",goals];
    
    goals = 0;
    for(Player* player in team2Players.allValues) {
        goals += player.goal;
    }
    _equipe2ScoreLbl.text = [NSString stringWithFormat:@"%d",goals];
}
- (IBAction)endGame:(id)sender {
    [self calculateStars];
}

-(void) calculateStars {
    Player* player1 = nil;
    Player* player2 = nil;
    Player* player3 = nil;
    NSInteger gagnant = 1;
    
    NSMutableDictionary* temp = [[NSMutableDictionary alloc] init];
    
    if(_equipe2ScoreLbl.text.intValue > _equipe1ScoreLbl.text.intValue ){
        gagnant = 2;
    }
    
    for(Player* p in team1Players.allValues) {
     /*   if(player1 == nil || player1.getScoreValue < p.getScoreValue) {
            player3 = player2;
            player2 = player1;
            player1 = p;
        } else if(player2.getScoreValue < p.getScoreValue) {
            player3 = player2;
            player2 = p;
        } else if(player3.getScoreValue < p.getScoreValue) {
            player3 = p;
        }*/
        [temp setObject:p forKey:[NSString stringWithFormat:p.number.stringValue , @" " , p.equipe]];
       

        
    }
    
    for(Player* p in team2Players.allValues) {
       /* if(player1 == nil || player1.getScoreValue < p.getScoreValue) {
            player3 = player2;
            player2 = player1;
            player1 = p;
        } else if(player2.getScoreValue < p.getScoreValue) {
            player3 = player2;
            player2 = p;
        } else if(player3.getScoreValue < p.getScoreValue) {
            player3 = p;
        }*/
        [temp setObject:p forKey:[NSString stringWithFormat:p.number.stringValue , @" " , p.equipe]];
    }
    /*trouver le meilleur joueur de la partie dans lequipe gagnante*/
     for(Player* p in temp.allValues) {
         if(player1 == nil && p.equipe == gagnant){
             player1 = p;
         }else if(player1 != nil){
            if(player1.getScoreValue < p.getScoreValue && p.equipe == gagnant) {
                player1 = p;
            }
         }
     }
    for(Player* p in temp.allValues) {
        if(player1.number == p.number && player1.equipe== p.equipe){
        }else if(player2 == nil ){
            player2 = p;
        }else if(player2.getScoreValue < p.getScoreValue) {
             player3 = player2;
             player2 = p;
         } else if(player3.getScoreValue < p.getScoreValue) {
             player3 = p;
         }
    }
    
    
    NSString* star1 = [NSString stringWithFormat:@"1 - %@, %dB %dP", player1.name, player1.goal, player1.assist];
    NSString* star2 = [NSString stringWithFormat:@"2 - %@, %dB %dP", player2.name, player2.goal, player2.assist];
    NSString* star3 = [NSString stringWithFormat:@"3 - %@, %dB %dP", player3.name, player3.goal, player3.assist];
    
    NSString* starsText = [NSString stringWithFormat:@"Les trois etoiles sont\n\n1 : %@\n2 : %@\n3 : %@", star1, star2, star3];
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Les 3 etoiles"
                                                                   message:starsText
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Reinitialiser" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) resetGame {
    _periodeStp.stepValue = 1;
    _periodeLbl.text = @"1";
    _equipe1Txt.text = @"";
    _equipe1PlayerTxt.text = @"";
    _equipe1PlayerNumTxt.text = @"";
    _equipe1ScoreLbl.text = @"0";
    _equipe1PlayerAddBtn.enabled = NO;
    _equip1RemoveBtn.enabled = NO;
    _equipe1AddGoalBtn.enabled = NO;
    _equipe2Txt.text = @"";
    _equipe2ScoreLbl.text = @"0";
    _equipe2PlayerTxt.text = @"";
    _equipe2PlayerNumTxt.text = @"";
    _equipe2PlayerAddBtn.enabled = NO;
    _equipe2RemoveBtn.enabled = NO;
    _equipe2AddGoalBtn.enabled = NO;
    
    [team1Players removeAllObjects];
    [team2Players removeAllObjects];
    [team1Goals removeAllObjects];
    [team2Goals removeAllObjects];
    [team1GPickerArr removeAllObjects];
    [team1A1PickerArr removeAllObjects];
    [team1A2PickerArr removeAllObjects];
    [team2GPickerArr removeAllObjects];
    [team2A1PickerArr removeAllObjects];
    [team2A2PickerArr removeAllObjects];
    
    [self reloadPicker];
    [_equipe1Tbl reloadData];
    [_equipe2Tbl reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength < 3));
}

@end
