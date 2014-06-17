//
//  STStartViewController.m
//  StampAround
//
//  Created by Thibault Guégan on 14/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStartViewController.h"

@interface STStartViewController ()

@property(nonatomic, strong) OJFSegmentedProgressView *progressView;
@property(nonatomic, strong) NSTimer *timer;
@property (nonatomic) float currentProgress;
@property (nonatomic) BOOL presentLoginScreen;

@end

@implementation STStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self view] setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xeef3ed)];
    
    _currentProgress = 0.0;
    
    _progressView = [[OJFSegmentedProgressView alloc] initWithNumberOfSegments:16];
    [_progressView setFrame:CGRectMake(70, 500, 100, 20)];
    [_progressView setTrackTintColor:MY_UICOLOR_FROM_HEX_RGB(0x858688)];
    [_progressView setProgressTintColor:MY_UICOLOR_FROM_HEX_RGB(0xf76228)];
    [_progressView setSegmentSeparatorSize:3.0];
    [_progressView setProgress:_currentProgress];
    
    UILabel *lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(_progressView.frame.origin.x + _progressView.frame.size.width + 10, 500, 100, 20)];
    [lblLoading setTextColor:MY_UICOLOR_FROM_HEX_RGB(0x39393b)];
    [lblLoading setText:@"Loading"];

    [[self view] addSubview:_progressView];
    [[self view] addSubview:lblLoading];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:REFRESH_INTERVAL
                                                      target:self
                                                    selector:@selector(animateProgress)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateProgress
{
    _currentProgress = _currentProgress + 0.1;
    
    [_progressView setProgress:_currentProgress];
    
    if(_currentProgress >= 1.0f)
    {
        [_timer invalidate];
        
        if([[[STSessionManager manager] token] length]!=0  && [[[STSessionManager manager] secret] length]!=0 )
        {
            //send request for validity
            [[STNetworkManager managerWithDelegate:self] requestSessionValid:[[STSessionManager manager] token] secret:[[STSessionManager manager] secret]];
        }
        else
        {
            [MY_APP_DELEGATE switchToScreen:SCREEN_LOGIN];
        }
        
        /*if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
            
            //open session also
            [MY_APP_DELEGATE openFbSession];
            
            //valid session, allow to go to category screen
            [MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
        } else {
            //then check for user token, else present login screen
            if([[[STSessionManager manager] token] length]!=0)
            {
                [MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
            }
            else
            {
                [MY_APP_DELEGATE switchToScreen:SCREEN_LOGIN];
            }
        }*/
        
        //TODO: send accesstoken and accesssecret to backend to check for session validity
    }
}

#pragma mark - Network Delegate


-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
    
    [[STSessionManager manager] saveCredentialsWithUsername:[responseObject objectForKey:@"email"] token:[responseObject objectForKey:@"accessToken"] secret:[responseObject objectForKey:@"secret"]];
    
    [MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    NSLog(@"error %@", message);
    
    /*if (FBSession.activeSession.isOpen) {
        [MY_APP_DELEGATE closeSession];
    }*/
    
    [[STSessionManager manager] saveCredentialsWithUsername:@"" token:@"" secret:@""];
    
    [MY_APP_DELEGATE switchToScreen:SCREEN_LOGIN];
    
}


@end
