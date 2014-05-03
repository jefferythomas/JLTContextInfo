//
//  NSObject+JLTContextInfo.h
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

#if defined (JLT_CONTEXT_INFO_ATOMIC)
#define JLT_CONTEXT_INFO___ATOMIC___ atomic
#else
#define JLT_CONTEXT_INFO___ATOMIC___ nonatomic
#endif

#import <Foundation/Foundation.h>

@interface NSObject (JLTContextInfo)

///
/// @brief A mutable dictionary which can contain any additional data an object may need.
///
/// By default @c JLT_contextInfo is @c nonatomic. Define @c JLT_CONTEXT_INFO_ATOMIC to make
/// @c JLT_contextInfo @c atomic.
///
/// Define @c JLT_SHORTHAND to create the property contextInfo.
///
@property (JLT_CONTEXT_INFO___ATOMIC___, readonly) NSMutableDictionary *JLT_contextInfo;

#if defined (JLT_SHORTHAND)
///
/// @brief A mutable dictionary which can contain any additional data an object may need.
///
/// This is a shorthand alias for @c JLT_contextInfo. Either property will return the same
/// dictionary.
///
@property (JLT_CONTEXT_INFO___ATOMIC___, readonly) NSMutableDictionary *contextInfo;
#endif

@end
