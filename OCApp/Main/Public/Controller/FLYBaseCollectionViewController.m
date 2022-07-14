//
//  FLYBaseCollectionViewController.m
//  ProvideAged
//
//  Created by fly on 2021/12/24.
//

#import "FLYBaseCollectionViewController.h"

#define k_CellReuseIdentifier @"FLYBaseCollectionViewCellReuseIdentifier"

@interface FLYBaseCollectionViewController ()

@end

@implementation FLYBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}



#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

/**** 如果子类重写了下面方法，这里的就不会执行了 ****/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionView.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_CellReuseIdentifier forIndexPath:indexPath];
  
    return cell;
}



#pragma mark - setters and getters

-(UICollectionView *)collectionView
{
    if ( _collectionView == nil )
    {
        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
        //最小列间距
        flow.minimumInteritemSpacing = 0;
        //最小行间距
        flow.minimumLineSpacing = 15;
        //flow.estimatedItemSize = CGSizeMake(SCREEN_WIDTH - 40, 123);
        flow.itemSize = CGSizeMake(SCREEN_WIDTH - 40, 123);
        flow.sectionInset = UIEdgeInsetsMake(15, 20, 15, 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.backgroundColor = self.view.backgroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:k_CellReuseIdentifier];
    }
    return _collectionView;
}


@end
