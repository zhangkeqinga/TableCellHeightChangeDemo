//
//  ViewController.m
//  TableCellHeightChangeDemo
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 com.cn.qz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)   NSIndexPath *selectedCellIndexPath;
@property (strong, nonatomic)   NSMutableArray *indexPaths;
@property (strong, nonatomic)   NSString * stringValue;
@property (strong, nonatomic)   NSString * stringValue2;


@end

@implementation ViewController

@synthesize selectedCellIndexPath;
@synthesize stringValue;
@synthesize stringValue2;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexPaths = [[NSMutableArray alloc] init];
    for (int i=0 ; i < 50 ; i++){
        NSIndexPath * indp = [[NSIndexPath alloc]init];
        [self.indexPaths addObject:indp];
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =  [[UITableViewCell alloc]init];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] ;
//        UITextField *label = [[UITextField alloc] initWithFrame:CGRectZero];
//        label.tag = 1;
//        label.backgroundColor = [UIColor grayColor];
//        [cell.contentView addSubview:label];
//        label.delegate = self;
//    }
    
    UITextField *label = [[UITextField alloc]init];
    label.tag = indexPath.row;

//    UITextField *label = (UITextField *)[cell viewWithTag:1];
    [cell.contentView addSubview:label];
    label.frame = CGRectMake(0, 0, 300, 20);
    label.backgroundColor = [UIColor redColor];
    label.delegate = self;
    label.tag = indexPath.row;
    
    if(selectedCellIndexPath != nil
       &&[selectedCellIndexPath compare:indexPath] == NSOrderedSame){
        label.text  = stringValue;
        [label becomeFirstResponder];
    }
    self.indexPaths[indexPath.row] = indexPath;

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if(selectedCellIndexPath != nil
       &&[selectedCellIndexPath compare:indexPath] == NSOrderedSame && ![stringValue2 isEqualToString:@""])
        return 100;

    return 50;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    selectedCellIndexPath = indexPath;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //判断是否有数据 ，没有数据就合并 刷新cell高度
    
    NSIndexPath *indp = self.indexPaths[textField.tag];
    
    selectedCellIndexPath = indp;
    NSString * newContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    stringValue2 = newContent;

    stringValue = textField.text;
    NSLog(@"stringValue=%@",newContent);
    NSLog(@"textField.text=%@",textField.text);

    if(indp != nil ) {
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indp]withRowAnimation:UITableViewRowAnimationNone];
        
    }

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];

    return YES;

}// called when 'return' key pressed. return NO to ignore.

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //结束 判断是否有数据 有就刷新
//    [textField becomeFirstResponder];
    
//    if(selectedCellIndexPath != nil ) {
//        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:selectedCellIndexPath]withRowAnimation:UITableViewRowAnimationNone];
//    }

    
}


@end
