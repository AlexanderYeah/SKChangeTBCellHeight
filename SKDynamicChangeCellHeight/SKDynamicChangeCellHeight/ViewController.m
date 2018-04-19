//
//  ViewController.m
//  SKDynamicChangeCellHeight
//
//  Created by Alexander on 2018/4/19.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
static NSString *ID = @"cell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


/**
 标记当前选中的
 */
@property (nonatomic, strong) NSIndexPath *index;
/** 背景 tableview */
@property (nonatomic,strong)UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self createMainTB];
}

- (void)createMainTB
{
	
	CGFloat offset = 0;

    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height  - offset - 64) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleBlue;
    self.mainTableView.showsVerticalScrollIndicator = NO;
	 
	
    [self.view addSubview:self.mainTableView];
	
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
	return 0.01;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f  blue:arc4random_uniform(256)/255.0f  alpha:1];
	
	cell.textLabel.text =  [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 如果选中的行数是当前的行数 改变其高度
	if (self.index == indexPath) {
		return 180;
	}else{
		return 90;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	// 实现点击一下 放大 再次点击缩小的效果
	if (self.index == indexPath) {
		self.index = nil;
	}else{
			// 标记当前选中的行数
		self.index = indexPath;
	
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
	// 重点是这2句代码实现的功能
    [tableView beginUpdates];
    [tableView endUpdates];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
