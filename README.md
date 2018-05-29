WinPaths
========

Mac OSX services for working with Windows SMB share paths

This creates 2 services, one that opens a file using its Windows path, and one that copies the Windows path of a selected file to the clipboard.

To install, simply drag the application to either /Library/Services or ~/Library/Services

WinPaths is licensed under the Apache License, version 2.0.  For more information, see the LICENSE file.

Using the App
-------------
In Finder, select a folder on a networked server and right click.  Using this menu item will copy the Windows-style network path to clipboard so that Windows users can use the link to open the file.

![Using the "copy path to clipboard" item](https://user-images.githubusercontent.com/2175841/40635213-79506370-62e8-11e8-9693-e35eb478282f.png)

To open a Windows-style network link, right click on the text and go to Services -> Open as Windows Link.  The link should then open in Finder.

![Using "open as Windows link"](https://user-images.githubusercontent.com/2175841/40635461-a8ffb4c6-62e9-11e8-9ad4-b3c31aa0cc3a.png)
