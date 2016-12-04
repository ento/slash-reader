'use strict'
const {app, Menu, BrowserWindow} = require('electron')
require('electron-debug')()

let mainWindow

app.on('ready', createWindow)

function createWindow () {
  mainWindow = new BrowserWindow({
    width: 1024,
    height: 768
  })

  mainWindow.loadURL(`file://${ __dirname }/index.html`)

  mainWindow.on('closed', () => {
    mainWindow = null
  })

  const template = [
    {
      label: "Slash Reader",
      submenu: [
        { label: "About Slash Reader", selector: "orderFrontStandardAboutPanel:" },
        { type: "separator" },
        { label: "Quit Slash Reader", accelerator: "Command+Q", click: function() { app.quit(); }}
      ]},
    {
      label: "Edit",
      submenu: [
        { label: "Undo", accelerator: "CmdOrCtrl+Z", selector: "undo:" },
        { label: "Redo", accelerator: "Shift+CmdOrCtrl+Z", selector: "redo:" },
        { type: "separator" },
        { label: "Cut", accelerator: "CmdOrCtrl+X", selector: "cut:" },
        { label: "Copy", accelerator: "CmdOrCtrl+C", selector: "copy:" },
        { label: "Paste", accelerator: "CmdOrCtrl+V", selector: "paste:" },
        { label: "Select All", accelerator: "CmdOrCtrl+A", selector: "selectAll:" }
      ]}
    ];

  Menu.setApplicationMenu(Menu.buildFromTemplate(template))
}

/* Mac Specific things */

// when you close all the windows on a non-mac OS it quits the app
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') { app.quit() }
})

// if there is no mainWindow it creates one (like when you click the dock icon)
app.on('activate', () => {
  if (mainWindow === null) { createWindow() }
})
