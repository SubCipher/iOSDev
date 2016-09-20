//
//  AttributorUIViewController.m
//  Attributor
//
//  Created by MacMan on 9/19/16.
//  Copyright © 2016 StepWiseDesigns. All rights reserved.
//

#import "AttributorUIViewController.h"

@interface AttributorUIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UITextView *body;

@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorUIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc]initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{ NSStrokeWidthAttributeName: @3,
                            NSStrokeWidthAttributeName: self.outlineButton.tintColor }
                   range:NSMakeRange(0, [title length])];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name: UIContentSizeCategoryDidChangeNotification
                                                       object:nil];
}


-(void)preferredFontsChanged:(NSNotification *)notification{
    [self usePreferredFonts];
    
    
}


-(void)usePreferredFonts{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headLine.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
- (IBAction)changeBodySelectionToMatchButtonColor:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}


- (IBAction)outlineBodySelection:(UIButton *)sender {

    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName: @-3,
                                           NSStrokeColorAttributeName: [UIColor blackColor] }
                                  range:self.body.selectedRange];

}


- (IBAction)unOutlineBodySelection:(UIButton *)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}





@end
