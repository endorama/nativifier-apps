// ==UserScript==
// @name         Next, Previous, and play/pause key shortcuts for bandcamp
// @description  Allows the left and right keyboard arrows to be used to go to the previous and next songs on bandcamp.
// @author       Zach Saucier
// @namespace    https://zachsaucier.com/
// @version      1.2
// @match        https://bandcamp.com/*
// @match        https://*.bandcamp.com/*
// ==/UserScript==

(function() {
    'use strict'
    function getPlayButton() {
        if (document.querySelector('.playbutton'))
            return document.querySelector('.playbutton')
        if (document.querySelector('.play-button'))
            return document.querySelector('.play-button')
    }

    var prevButton = document.querySelector('.prevbutton')
    var nextButton = document.querySelector('.nextbutton')
    var playButton = getPlayButton()

    window.addEventListener('keydown', (event) => {
        console.log(event.code)
        switch(event.code) {
            case 'ArrowLeft':
                prevButton.click()
                break
            case 'ArrowRight':
                nextButton.click()
                break
            case 'Space':
                playButton.click()
                event.preventDefault()
                break
        }
    }, false)

    // remove all target=_blank from links
    document.querySelectorAll("a[target=_blank]").forEach((e) => e.removeAttribute("target"))
})();

