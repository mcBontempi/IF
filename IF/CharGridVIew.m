#import "CharGridView.h"

@implementation CharGridView {
    NSUInteger _rowCount;
    NSUInteger _colCount;
}

- (void)setupWithRows:(NSUInteger)rowCount colCount:(NSUInteger)colCount
{
    _rowCount = rowCount;
    _colCount = colCount;
    
    [self setupViews];
}

- (void)setupViews
{
    CGFloat cellWidth = CGRectGetWidth(self.frame) / _colCount;
    CGFloat cellHeight = CGRectGetHeight(self.frame) / _rowCount;
    
    for (NSUInteger y = 0 ; y < _rowCount ; y++) {
        for (NSUInteger x = 0 ; x < _colCount ; x++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x*cellWidth, y*cellHeight, cellWidth-1, cellHeight-1)];
            label.text = @"0";
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.borderColor = [UIColor blackColor].CGColor;
            label.layer.borderWidth = 1;
            label.layer.cornerRadius = 2;
            
            [self addSubview:label];
            
        }
    }
}

- (void)writeToAddress:(NSUInteger)address withValue:(NSInteger)value
{
    UILabel *label = self.subviews[address];
    label.text = [NSString stringWithFormat:@"%c", value];
}


@end
