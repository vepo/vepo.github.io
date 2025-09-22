
$(document).ready(() => {
    $('pdf').each(i => {
        let $pdfContainer = $('<div>', { class: 'pdf-container' });
        let $canvas = $('<canvas>', { class: 'pdf-canvas' });
        let $pdfControls = $('<div>', { class: 'pdf-controls' });
        let $prevButton = $('<button>', { class: 'prev-page btn btn-secondary', text: 'Anterior' });
        let $pageIndicator = $('<span>').html('<span class="current-page"></span> / <span class="total-pages"></span>');
        let $nextButton = $('<button>', { class: 'next-page btn btn-secondary', text: 'Próxima' });
        $pdfControls.append($prevButton, $pageIndicator, $nextButton);
        $pdfContainer.append($canvas, $pdfControls);

        let pdfElm = $('pdf')[i];
        let pdfContainerElm = $pdfContainer[0];

        // Append the container to the body or a specific parent element
        $(pdfElm.parentElement).append($pdfContainer);
        let pdfDoc = null,
            url = pdfElm.getAttribute('src'),
            currentPage = 1,
            totalPages = 0,
            pdfCanvas = $canvas[0],
            canvasContext = pdfCanvas.getContext('2d');
        // Render a specific page
        function renderPage(pageNum) {
            pdfDoc.getPage(pageNum).then(page => {
                const viewport = page.getViewport({ scale: 1.5 });
                pdfCanvas.width = viewport.width;
                pdfCanvas.height = viewport.height;

                const renderCtx = {
                    canvasContext: canvasContext,
                    viewport: viewport
                };
                page.render(renderCtx);
            });

            // Update current page text
            pdfContainerElm.querySelector('.current-page').textContent = pageNum;
        }
        // Load the PDF
        pdfjsLib.getDocument(url).promise.then(doc => {
            pdfDoc = doc;
            totalPages = doc.numPages;
            pdfContainerElm.querySelector('.total-pages').textContent = totalPages;

            // Render the first page
            renderPage(currentPage);
        });

        // Button event listeners
        pdfContainerElm.querySelector('.prev-page').addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                renderPage(currentPage);
            }
        });

        pdfContainerElm.querySelector('.next-page').addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                renderPage(currentPage);
            }
        });
    });
});