$("body").ready(() => {
    $("body").attr("data-scroll", $(window).scrollTop());
    $(this).scroll(() => {
        console.log($(window).scrollTop());
        $("body").attr("data-scroll", $(window).scrollTop());
    });
});