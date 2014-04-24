//
//  NSObject+JLTContextInfo.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 3/7/13.
//  Copyright (c) 2013 JLTSource. No rights reserved. Do with it what you will.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSObject+JLTContextInfo.h"
#import "objc/runtime.h"

@implementation NSObject (JLTContextInfo)

- (NSMutableDictionary *)JLT_contextInfo
{
#if defined (JLT_CONTEXT_INFO_ATOMIC)
    @synchronized(self) {
#endif
        static char key;
        NSMutableDictionary *contextInfo = objc_getAssociatedObject(self, &key);
        if (!contextInfo) {
            contextInfo = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, &key, contextInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return contextInfo;
#if defined(JLT_CONTEXT_INFO_ATOMIC)
    }
#endif
}

#if defined (JLT_SHORTHAND)
- (NSMutableDictionary *)contextInfo
{
    return self.JLT_contextInfo;
}
#endif

@end
