// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/dropdown
//= require_tree .
//= require_tree ./channels

$(".chat-count-link").hide()
function countdown( elementName, minutes, seconds )
{
    var endTime, hours, mins, msLeft, time;

    function twoDigits( n )
    {
        return (n <= 9 ? "0" + n : n);
    }

    function updateTimer()
    {
        msLeft = endTime - (+new Date);
        if ( msLeft < 1000 ) {
            App.valid_user.valid_user_count()
            countdown( "countdown", 1, 15 );
        } else {
            time = new Date( msLeft );
            hours = time.getUTCHours();
            mins = time.getUTCMinutes();
            setTimeout( updateTimer, time.getUTCMilliseconds() + 500 );
        }
    }

    endTime = (+new Date) + 1000 * (60*minutes + seconds) + 500;
    updateTimer();
}

countdown( "countdown", 1, 1 );

var minutesLabel = document.getElementById("minutes");
var secondsLabel = document.getElementById("seconds");

if (minutesLabel != null) {
    var totalSeconds = gon.sign_time;
    setInterval(setTime, 1000);
}

function setTime()
{
    ++totalSeconds;
    secondsLabel.innerHTML = pad(totalSeconds%60);
    minutesLabel.innerHTML = pad(parseInt(totalSeconds/60));
}

function pad(val)
{
    var valString = val + "";
    if(valString.length < 2)
    {
        return "0" + valString;
    }
    else
    {
        return valString;
    }
}


var secondsRemaining;
var intervalHandle;
startCountdown();

function resetPage() {
    document.getElementById("inputArea").style.display = "block";
}

function tick() {
    // grab the h1
    var minuteDisplay = $(".minutes");
    var secondsDisplay = $(".seconds")
    
    // turn seconds into mm:ss
    var min = parseInt(Math.floor(secondsRemaining / 60));
    var sec = parseInt(secondsRemaining - (min * 60));
    
    // add a leading zero (as a string value) if seconds less than 10
    if (sec < 10) {
        sec = "0" + sec;
    }
    // concatenate with colon
    minuteDisplay.text(min);
    secondsDisplay.text(sec);
    secondsRemaining = parseInt(secondsRemaining)
    // stop if down to zero
    if (secondsRemaining === 0) {
        App.valid_user.valid_user_count()
        clearInterval(intervalHandle);
        resetPage();
    }
    // subtract from seconds remaining
    secondsRemaining--;
}

function startCountdown() {
    // get contents of the "minutes" text box
    var minutes = (16 * 60) - gon.chats_time;
    // check if not a number
    if (isNaN(minutes)) {
        return;
    }
    // how many seconds?
    secondsRemaining = minutes;
    
    // every second, call the "tick" function
    intervalHandle = setInterval(tick, 1000);
    // hide the form
}
