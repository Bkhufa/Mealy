# Overview
Mealy is an iOS App that lets user see list of meals from [themealdb](https://www.themealdb.com/). 
User can zoom, pan, and double tap the image on the list, and also see the meal instructions in more detail.
The fetching are paginated with each meals first name, starting from a to z. The fetching are only done after user scrolled to the bottom of the list.

Users are required to sign up by registering a username and password, and then login to enjoy the app fully. 
The credentials are saved locally inside Apple's KeyChain.

# Architecture
![image](https://github.com/Bkhufa/Mealy/assets/47885514/414013ed-3aa7-41b7-b2e2-52f87ebaa3e5)
The overall app architecture is MVVM with some separation on the domain layer using UseCase. 
UseCase is the inner most layer where the core functionality of the app resides. 
I used Dependency Inversion to abstract the dependency of the usecase with NetworkService and LocalStorage.
Navigation is using a simple Flow mechanism to lessen the coupling of the View with the navigational logic. 
This architecture is chosen to have a good separation of concern and better readability.

# Third Party Packages
- Alamofire: Streamlining HTTP request process

# Project Specifications
- Swift 5
- iOS 16.4+
- XCode 14.3

# How to Run
- Clone project
- Wait SPM to resolve the dependency
- Click CMD + R to run the project
- Click CMD + U to run the unit tests

# Demo
<div style="display:flex;flex-direction:row">
    <img src="https://github.com/Bkhufa/Mealy/assets/47885514/942422a0-b85c-4035-b8af-0aac9c25dea1" height="410" width="200" />
    <img src="https://github.com/Bkhufa/Mealy/assets/47885514/9bc0b980-17e3-4d05-a895-5d227cc9580c" height="410" width="200" />
    <img src="https://github.com/Bkhufa/Mealy/assets/47885514/f7d6eb25-9f47-4fc8-9c0e-230c67d1c533" height="410" width="200" />
</div>
