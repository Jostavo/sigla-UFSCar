$(document).ready(function() {
    // init
    var m = moment();
    var minutes = (m.hour() * 60) + m.minute();
    var progresshour = 0;
    var clockHeight = $('#clock').height();
    var viewportHeight = window.innerHeight;
    var scrollbarHeight = viewportHeight / $(document).height() * viewportHeight;

    console.log(clockHeight);

    function posLayout(scrollbarHeight) {
        $('.schedule').css('margin-top', scrollbarHeight / 2);
        $('.schedule').css('margin-bottom', scrollbarHeight / 2);
    }

    function progressToText(progress, ratio, modulo, addZero) {
        const val = modulo ? Math.floor(progress * ratio) % modulo : Math.floor(progress * ratio);
        return (val > 9 && addZero) ? val.toString() : "0" + val.toString();
    }

    function translateElement(id, val) {
        $(id).css({
            transform: 'translateY(' + val + 'px)',
            '-webkit-transform': 'translateY(' + val + 'px)',
            '-ms-transform': 'translateY(' + val + 'px)'
        });
    }

    function updateUI() {
        var today = new Date();
        var hour = today.getHours();
        var minutes = today.getMinutes();
        $('.digital-time').text('' + checkTime(hour) + ':' + checkTime(minutes) + '');
        translateElement('#clock', (hour*100)+(minutes*1.6));
    }
    function checkTime(i) {
        if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
        return i;
    }

    // main
    posLayout(scrollbarHeight);
    window.scrollTo(0, (minutes / 1440) * ($(document).height() - window.innerHeight));
    updateUI();

    window.setInterval(updateUI,60000);
});

