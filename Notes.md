#  Notes

### Documenting our code
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
