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

window.onload = () => {
    document.body.setAttribute('browser', navigator.googleAgent ? "Googlebot" : navigator.detectedAgent);
};

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


(function($) {
    "use strict";
    /*
    @victorvhpg
    Carrega gist na página de forma async
    Exemplo de uso:
    Em vez de usar o "embed"  gerado do gist,  coloque a URL do gist
no   atributo "data-gist"  do elemento onde você deseja exibir o gist.
    <div data-gist="https://gist.github.com/victorvhpg/33889d0611905780e253"></div>
    */

    var _CACHE = {
        ajax: {},
        css: {}
    };

    var carregaGist = {
        //retorna uma promise do jsonp que contem o gist retornado
        getGist: function(url) {
            return $.Deferred(function(promise) {
                //se ja tiver no cache entao ja resolve
                if (_CACHE.ajax[url]) {
                    promise.resolve(_CACHE.ajax[url]);
                    return;
                }
                //jsonp
                $.ajax({
                    timeout: 10000,
                    url: url + ".json",
                    dataType: "jsonp"
                }).done(function(obj) {
                    _CACHE.ajax[url] = obj;
                    promise.resolve(obj);
                }).fail(function() {
                    promise.reject("erro ao carregar Gist " + url);
                });
            }).promise();

        },
        //pega o gist e coloca o html dele na div
        montarGist: function($div) {
            var url = $div.attr("data-gist");
            $div.html("Carregando <a href='" + url + "'>Gist</a>...");
            this.getGist(url).done(function(obj) {
                if (!_CACHE.css[obj.stylesheet]) {
                    if (obj.stylesheet.indexOf("http") === 0) {
                        $("head").append("<link href='" + obj.stylesheet + "'  type='text/css' rel='stylesheet'  />");
                    } else {
                        $("head").append(obj.stylesheet);
                    }
                    _CACHE.css[obj.stylesheet] = obj.stylesheet;
                }
                $div.html($.trim(obj.div));
            }).fail(function(erros) {
                console.error(erros);
                $div.html(erros);
            });
        },

        init: function() {
            var that = this;
            //todos os elementos que tiverem o atributo data-gist serao carregados
            $("[data-gist]:not([data-gist-ok])").each(function(indice, item) {
                var $div = $(this);
                $div.attr("data-gist-ok", "ok");
                that.montarGist($div);
            });
        }
    };

    window.carregaGist = carregaGist;
})(jQuery);

carregaGist.init();