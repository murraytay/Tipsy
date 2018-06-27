//
//  ViewController.m
//  tipsy
//
//  Created by Taylor Murray on 6/26/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mealBillField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIView *extraCalc;
@property (weak, nonatomic) IBOutlet UILabel *twoPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *threePersonLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
//    if(doubleValue == 15.){
//        self.tipControl.selectedSegmentIndex = 0;
//    } else if(doubleValue == 20.){
//        self.tipControl.selectedSegmentIndex = 1;
//    } else{ //doubleValue == 22.
//        self.tipControl.selectedSegmentIndex = 2;
//    }
    self.extraCalc.alpha = 0;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"View will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int default_index = [defaults doubleForKey:@"default_tip_index"];
    self.tipControl.selectedSegmentIndex = default_index;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"View did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"View will disappear");
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"View did disappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    
    
    [self.view endEditing:YES];
}
- (IBAction)editingDidBegin:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mealBillField.frame = CGRectMake(self.mealBillField.frame.origin.x, self.mealBillField.frame.origin.y - 150, self.mealBillField.frame.size.width, self.mealBillField.frame.size.height);
        self.extraCalc.frame =
            CGRectMake(self.extraCalc.frame.origin.x, self.extraCalc.frame.origin.y - 150, self.extraCalc.frame.size.width, self.extraCalc.frame.size.height);
        self.extraCalc.alpha = 1;
    }];

    
}
- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.mealBillField.frame;
    newFrame.origin.y += 150;
    
    CGRect newBottomFrame = self.extraCalc.frame;
    newBottomFrame.origin.y += 150;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mealBillField.frame = newFrame;
        self.extraCalc.frame = newBottomFrame;
    }];
    
}

- (IBAction)onEdit:(id)sender {
    
    
    double bill = [self.mealBillField.text doubleValue];
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    double tip = tipPercentage*bill;
    double total = tip + bill;
    double two_total = total/2;
    double three_total = total/3;
    self.tipLabel.text =[NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text =[NSString stringWithFormat:@"$%.2f", total];
    self.threePersonLabel.text =[NSString stringWithFormat:@"$%.2f", two_total];
    self.twoPersonLabel.text =[NSString stringWithFormat:@"$%.2f", three_total];
}

@end
