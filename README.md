# Saam

Saam is a tool for develop a characteristics model of a product. (In Design Engineering) , this tool was presented in France as part of the thesis "Development of a collaborative-work model to assist product design procceses through the use of computer tools". This tool was made with Electron and NodeJs mainly, Python and MatLab were used for BackEnd - JavaScript (Css,Html) for FrontEnd.

### Requirements

* NPM
* NodeJS
* Python (Libraries WebSockets and Openyxl)
* MongoDB

### Automatic install dependencies
```
npm install
```

### Start

```
npm i --global electron (If you haven't installed Electron globally) 

npm start
```

# Structure

```Saam/ <br>
+--package.json                 Configurations of the project.
+--main.js                      Have default configurations of electron.
+--engine/                      Tools to graph.
   +---equalizer/               
   +---graph/
   +---login/
   +---main/
   +---menu/
   +---modal/
   +---server/
+--matlab/
+--matlab_returns/              [Generated] Files from matlab.
+--resources/
+--server/                      Server package it's made by Julian```
