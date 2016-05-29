//
//  ViewController.m
//  DynamicCell
//
//  Created by Anton on 5/29/16.
//  Copyright © 2016 AT. All rights reserved.
//

#import "ViewController.h"
#import "DynamicCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, DynamicCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *textSources;

@property (nonatomic, assign) CGFloat textViewWidth;

@end

@implementation ViewController


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        
        _textSources = [@[@"You may not need to specify the column(s) name in the SQLite query if you are adding values for all the columns of the table. But make sure the order of the values is in the same order as the columns in the table. The SQLite INSERT INTO syntax would be as follows:",
                         @"You can populate data into a table through select statement over another table provided another table has a set of fields, which are required to populate first table. Here is the syntax:",
                         @"SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine. SQLite is the most widely deployed SQL database engine in the world. The source code for SQLite is in the public domain.",
                         @"This reference has been prepared for the beginners to help them understand the basic to advanced concepts related to SQLite Database Engine.",
                         @"Before you start doing practice with various types of examples given in this reference, I'm making an assumption that you are already aware about what is database, especially RDBMS and what is a computer programming language."
                         @"The SQLite PRAGMA command is a special command to be used to control various environmental variables and state flags within the SQLite environment. A PRAGMA value can be read and it can also be set based on requirements.",
                         @"The auto_vacuum pragma gets or sets the auto-vacuum mode. Following is the simple syntax:",
                         @"Auto-vacuum is disabled. This is default mode which means that a database file will never shrink in size unless it is manually vacuumed using the VACUUM command.,",
                         @"Auto-vacuum is enabled and fully automatic which allows a database file to shrink as data is removed from the database.",
                         @"Auto-vacuum is enabled but must be manually activated. In this mode the reference data is maintained, but free pages are simply put on the free list. These pages can be recovered using the incremental_vacuum pragma any time."
                         ] mutableCopy];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma markd UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.textSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DynamicCell"];
    
    cell.delegate = self;
    
    cell.textView.attributedText = [self attributedTextForIndexPath:indexPath];
    
    return cell;
}

#pragma markd UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(DynamicCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.textViewWidth = CGRectGetWidth(cell.textView.bounds);
}

- (NSAttributedString *)attributedTextForIndexPath:(NSIndexPath *)indexPath
{
    NSAttributedString *attributedText = [[NSAttributedString alloc ] initWithString:self.textSources[indexPath.row]
                                                                          attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:14],
                                                                                       NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    return attributedText;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.textViewWidth > 0.f)
    {
        NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedTextForIndexPath:indexPath]];
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.textViewWidth, CGFLOAT_MAX)];
        NSLayoutManager *layoutManager = [NSLayoutManager new];
        [layoutManager addTextContainer:textContainer];
        [textStorage addLayoutManager:layoutManager];
        CGRect newSize = [layoutManager usedRectForTextContainer:textContainer];
        
        return newSize.size.height + 17;
    }
    
    return 10;
}

#pragma  DynamicCellProtocol

- (void)cell:(DynamicCell *)cell changedText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.textSources[indexPath.row] = text;
    
    [self.tableView beginUpdates];
    
    [self.tableView endUpdates];
}


@end
