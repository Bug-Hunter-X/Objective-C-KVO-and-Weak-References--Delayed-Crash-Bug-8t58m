In Objective-C, a rare but perplexing issue can arise when dealing with KVO (Key-Value Observing) and weak references.  Consider this scenario:

```objectivec
@interface MyObject : NSObject
@property (nonatomic, weak) MyOtherObject *otherObject;
@end

@implementation MyObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // ... observation logic ...
}
@end
```

If `otherObject` is deallocated while `MyObject` is still observing it, a crash might *not* occur immediately. Instead, the KVO mechanism might continue trying to send updates to a deallocated object, leading to delayed and unpredictable crashes or silent data corruption later in the app's lifecycle. This is insidious because the initial deallocation doesn't trigger an immediate crash, making debugging much harder. 