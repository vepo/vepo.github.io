$(document).ready(()=>{
    $('.menu .enabler a').click(()=>{
        $('.menu div.nav').slideToggle();
        return false;
    });
});