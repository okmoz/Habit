#  Notes (Paul Hudson)

## Documenting our code
3 kinds of code comments form Paul:
1. Summary - multiple lines of code into 1-2 sentences.
2. Context - why one solution was chose rather than a different solution.
3. Warning - when your code does something unexpected, weird, that makes you want to do a double-take. E.g.: a workaround for a known framework bug.

*Documentation*
These comments work best when they mean somebody doesn't have to read your code in order to understand it. 
This means you should explain briefly what your code is used for, what assumptions you make, perhaps even give some guidance on what performance they should expect. 
If you are documenting a method, you should explain what each parameter does and what return values mean and what kind of errors might be thrown and more.
Paul believes that documentation comments should exist almost everywhere. For every class, struct, extension or protocol, for every property and method inside. The only exception is when the functionality is very obvious(like the body property in a SwiftUI view).
Remember, these comments are designed for folks who are using the code and not modifying it. But they are also useful for interviewers who want to read your code and understand its structure without having to ask you questions. Docs are also useful for you.
(see Jazzy for automated documentation generation)
Shortcut: option+command+/
Start with "a/an/the": "A structure that..."
For inits, start with "Initializes": "Initializes the `DataController` instance."
For methods that throw, explain what errors can be thrown.

Paul thinks that almost every type, method and property should be documented. E.g.: you might think that save() method in DataController is self-explainatory, he still thinks it's worth being clear on why it exists and how it works.

iff - if and only if

If you are struggling to describe what the property does, you should consider making it private.

>> Make your README good. It's like a cover letter for your portfolio, summarizing what it does. So make sure your cover letter is clear and thorough and shows your ability to communicate, your goals, your approaches and more.
Have a clear introductory paragraph that outlines what the project does in 2-3 sentences. What platform is it run on, what Swift version it is written in.
State really clearly any prerequisites you have, any 3rd party tools and frameworks that you chose to use in your project.
After reading this, users should be able to download and build your code.
Explain any important choices you've made. Such as: whether you've made some unusual architectural choices, how thorough your tests are, how accessible your code is to users with VoiceOver or similar.
If you want, you can say how to contribute to the project. Make clear what you accept: require users to make sure that all your tests pass, or that there should be no swiftlint warnings or perhaps whole code of conduct(?).
You should probably have a license. Say what your code is: open source or closed source. At least say because you've thought about it.
And finally, any acknowledgements for folks that have helped you along the way.

see https://github.com/twostraws/Unwrap

Do not undervalue code comments because they will make an impression on others reading your code.
You are showing that you are able to think about folks coming to your code in a year's time, that you are able to communicate your goals clearly, that you are able to work on a team.


## Project organization
2 ways to organize:
1. Models, Views, Controllers, Extensions, Localization, Configuration
Configuration: CoreData model, info.plist, .entitlements
Note: when moving .entitlements or .plist file into Configuration group, don't forget to change its location in Build Settings. Otherwise, the app won't be able to build.

2. (better way for bigger projects) Oranizing file in terms of what they do from the user facing perspective, what's their job in the application.
Activities (or Screen/Sections/Tabs) - groups inside shold match the tabs in our app. Eg: Home, Projects, Awards

.... better re-watch Paul's video (24)


## Testing, the basics
Enable code coverage: press opt+cmd+U, press on a little arrow that shows when hovering over app's name, go to Code Coverage, select you app

Enable code coverage as a side pane for editor.

Code coverage is a term we use to describe how much of your main app's code was run as part of your test code.

However, code coverage tells nothing how stable your software actually is. Are those tests useful, are they checking results correctly etc?
Also, some parts of your code are just naturally very hard to test. And as a result of that your code coverage will be lower.

100% code coverage does not mean any of your tests are meaningful, your code works as expected. This just means that all the lines were hit in execution. 100% code coverage is rather a warning sign. 70-80%(?) is a sweet spot.

"A good tester looks both ways before crossing a one way the street."

All test methods should start with "test"

⌘U      Build and Run All Test Cases
⇧⌘U     Build the Test Target (without running any test cases)
⌃⌘U     Run All the Test Cases (without building the test target)
⌃⌥⌘G    Run Previous Test Case(s)
⌃⌥⌘U    Run Selected Test Case

Paul believes that you should write tests for non-public parts of your program (parts used while testing, developing or previewing)
Ensuring that the development code works as you expect does wonders for ensuring your unit tests pass because they can rely on it every time.

Fixtures - files for testing.

Comment your tests:
- use "Given, When, Then" method (for longer tests where it makes sense)
GIVEN - describe the prerequisites for the test, set all necessary parameters
WHEN - specify some action for the test
THEN - describe the changes you expect as a result of action


**Performance testing**
We can pick a few parts of our code that are particularly peformance sensitive and have Xcode check the performance in a controller environment.
Xcode tests 10 times automatically to determine the deviation of performance of each test, which by default should be <10%.

Good parts to test are the ones that are run regularly. E.g. Awards in UPA app.

It's best to have own test target for these types of tests because they are run 10 times.


**UI Testing with SwiftUI**
If you want great test coverage, you have to write UI tests as well.


## MVVM
MVVM is a small refinement of MVC, the older, classic way of building applications. It's designed to store all the state of your app apart from the UI.

MVVM is NOT required for SwiftUI.

It's entirely possible that the best way to implement MVVM into your app is not to implement MVVM at all.

MVVM is easier to test because our logic is removed from view. And also, CoreData becomes an implementation detail for these views. Another thing we don't care from the view's perspective. We could replace our CoreData with something else and it wouldn't matter. The views wouldn't care.

Why NOT to use MVVM in this SwiftUI project: 
1. "There was a time when the ViewModel approach was the mainstream in mobile app development with MVVM. In a world with declarative UI such as SwiftUI, the thinking needs to change. ViewModel was originally introduced for the purpose of Binding the state to the View and reflecting it to Reactive, but since the declarative UI includes that functionality, ViewModel is unnecessary."
2. "For small to medium scale applications, MV (Model and View) is all you need."
3. "In the era of declarative UI, what we really want in large-scale app development is MVI (unidirectional data flow), Flux (The Composable Architecture), and Store/Provider patterns."
Source: https://medium.com/@karamage/stop-using-mvvm-with-swiftui-2c46eb2cc8dc
