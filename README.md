#JLTContextInfo

A simple way to add extra data to any object (as long as it’s derived from
NSObject).

##Basic Use

Unlike lots of Objective-C old schoolers, I really like dot-property and
subscripted key syntax. Here I'll save a little extra data to object.

    object.JLT_contextInfo[@"extra"] = data;

Later on, I can get that extra data back.

    id savedData = object.JLT_contextInfo[@"extra"];

If you define `JLT_SHORTHAND` in your project -Prefix.pch, then you can leave
off the `JLT_` part.

    object.contextInfo[@"extra"] = data;

##Improving UIAlertView

There have been a couple of times when having some context info has cut down on
the number of properties I've needed to store in my view controllers. Here I can
change the text of any button to magic without having to save it out as it's
own separate property.

    - (IBAction)buttonTextToMagic:(UIButton *)button
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Make Magic"
                                                            message:@"Do you want to make the button title \"Magic\"?"
                                                           delegate:self
                                                  cancelButtonTitle:@"NO"
                                                  otherButtonTitles:@"YES", nil];

        alertView.contextInfo[@"button"] = button;
        [alertView show];
    }

    - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        if (buttonIndex != alertView.cancelButtonIndex) {
            UIButton *button = alertView.contextInfo[@"button"];
            [button setTitle:@"Magic" forState:UIControlStateNormal];
        }
    }

##Unit Tests for JLTContextInfo

JLTContextInfo passes the following unit tests.

    - (void)testContextInfo
    {
      NSObject *object = [[NSObject alloc] init];
      NSMutableDictionary *contextInfo = [object JLT_contextInfo];
      STAssertNotNil(contextInfo, nil);
      STAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]], nil);
    }

    #if defined(JLT_SHORTHAND)
    - (void)testContextInfoShorthand
    {
      NSObject *object = [[NSObject alloc] init];
      NSMutableDictionary *contextInfo = [object contextInfo];
      STAssertNotNil(contextInfo, nil);
      STAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]], nil);
    }
    #endif

    - (void)testContextInfoSaveString
    {
      NSObject *object = [[NSObject alloc] init];
      [[object JLT_contextInfo] setObject:@"Test String" forKey:@"saved"];

      NSString *saved = [[object JLT_contextInfo] objectForKey:@"saved"];
      STAssertEqualObjects(saved, @"Test String", nil);
    }

    - (void)testContextInfoAsProperty
    {
      NSObject *object = [[NSObject alloc] init];
      NSMutableDictionary *contextInfo = object.JLT_contextInfo;
      STAssertNotNil(contextInfo, nil);
      STAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]], nil);
    }

    - (void)testContextInfoWithSubscriptedKey
    {
      NSObject *object = [[NSObject alloc] init];
      object.JLT_contextInfo[@"saved"] = @"Test String";

      NSString *saved = object.JLT_contextInfo[@"saved"];
      STAssertEqualObjects(saved, @"Test String", nil);
    }

    #if defined(JLT_SHORTHAND)
    - (void)testContextInfoShorthandWithSubscriptedKey
    {
      NSObject *object = [[NSObject alloc] init];
      object.contextInfo[@"saved"] = @"Test String";

      NSString *saved = object.contextInfo[@"saved"];
      STAssertEqualObjects(saved, @"Test String", nil);
    }
    #endif
