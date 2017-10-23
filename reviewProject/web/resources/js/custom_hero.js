/*------------------------------------------------------------------
Project:    Beatrix
Author:     Yevgeny Simzikov
URL:        http://simpleqode.com/
            https://twitter.com/YevSim
Version:    1.0.2
Created:        14/10/2014
Last change:    14/06/2016
-------------------------------------------------------------------*/


/* -------------------- *\
    #HERO BLOCK
\* -------------------- */

/* Requires backstretch.min.js */

/**
 * Backstretch slideshow base setup
 */

$(window).load(function() { // starts after the page is fully loaded
    $(".hero__bs").backstretch([
        "resources/img/혼자가기 좋은 꼬치 요리.PNG"
        , "resources/img/혼자가기 좋은 연어요리.PNG"
        , "resources/img/beer.jpg"
    ], {duration: 5000, fade: 500});

    // Hero content animation
    setTimeout(function(){
        $("#hero__content").animate({
            opacity: 1,
            top: 0
        }, 800);
    }, 1500);
});

/**
 * Backstretch slideshow controls
 */

$(".js-hero-bs__ctrl > a").on('click', function() {
    var slide = $(this).data('slide');
    $(".hero__bs").backstretch(slide);
    if (slide == "pause" || slide == "resume") {
        $(".playback").toggleClass("visible-inline-block hidden");
    }
    return false;
});

/**
 * Carousel slideshow pause/resume
 */

$(".js-hero-crsl__ctrl > a.playback").on('click', function() {
    var slide = $(this).data('slide');
    $('#hero__carousel').carousel(slide);
    $(".playback").toggleClass("visible-inline-block hidden");
    return false;
});