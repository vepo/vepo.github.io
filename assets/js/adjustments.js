navigator.googleAgent = navigator.userAgent.indexOf('Googlebot') > 0;
navigator.detectedAgent = (function(){
    var ua= navigator.userAgent;
    var tem; 
    var M= ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if(/trident/i.test(M[1])){
        tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
        return 'IE '+(tem[1] || '');
    }
    if(M[1]=== 'Chrome'){
        tem= ua.match(/\b(OPR|Edge)\/(\d+)/);
        if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
    }
    M= M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
    if((tem= ua.match(/version\/(\d+)/i))!= null) M.splice(1, 1, tem[1]);
    return M.join(' ');
})();

document.body.setAttribute('browser', navigator.googleAgent ? "Googlebot" : navigator.detectedAgent);

$(document).ready(() => {
    $("p > img").each((index, elm) => {
        if (elm.parentElement.children.length == 1) {
            $(elm.parentElement).addClass("img-block");
        }
    });
    $('p > a > img').each((index, elm) => {
        if($(elm.parentElement.parentElement).text().length == 0) {
            $(elm.parentElement.parentElement).addClass("img-block");
        }
    });
    
    $("article > table, article > .gist").each((index, elm) => {
        var tableContainer = document.createElement('div');
        tableContainer.classList.add('table-container');
        elm.parentNode.insertBefore(tableContainer, elm);
        tableContainer.appendChild(elm);
    });

    $("article > iframe").each((index, elm) => {
        var iframeContainer = document.createElement('div');
        iframeContainer.classList.add('img-block');
        elm.parentNode.insertBefore(iframeContainer, elm);
        iframeContainer.appendChild(elm);
    });
});
