# Nativifier Applications

[nativifier](https://github.com/jiahaog/Nativefier) creates native wrappers around web applications.

But creating wrappers is not that easy. Most websites don't like being put in a cage and integration with the OS as a
whole is generally lacking.

Fortunately nativifier provides more than one way to improve on this.

This repository wants to act as a colletion of "nativifier's scripts" for Linux platform.

## How to use it

- Each website should have a folder
- Each folder should have a `nativefy` executable script performing nativefication

Under `libs/` there is a small BASH framework to help in creating nativefication scripts.

Each script should have 3 main responsibilities:
1. nativefy the app with all appropriate options
1. eventually add integration scripts (look at `bandcamp.com` for inspiration)
1. create and install a desktop file
