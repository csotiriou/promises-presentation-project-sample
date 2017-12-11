# promises-presentation-project-sample
Accompanying sample project for the iOS Meetup Presentation, held at 12/12/2017

## Usage:
The project uses a small node server returning mock results. Since it runs on localhost, it should be ran in a simulator.

* Install NodeJS 6+. Best option for development is NVM ([GitHub - creationix/nvm: Node Version Manager - Simple bash script to manage multiple active node.js versions](https://github.com/creationix/nvm))
* Open your terminal and write `cd path/to/sample_server/folder`
* run `npm install` or `yarn install` if you are using yarn
* run `npm start` in order to run the server.
* The server should now be running in port 3000.

For the application, use of Cocoapods 1.3+ is mandatory. You should do a `pod Install` in the sample_app directory, and open the workspace that Cocoapods has created for you. You will now be able to run the app in the simulator and make some requests
