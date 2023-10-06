$(document).ready(function(){
    // add activation hotspot on the top left corner, and the table of contents
    $('body')
            .prepend('<div id="generated-toc"><div class="title">Table of Contents <a>(click to hide)</a></div><ul></ul><div class="title">Hover the top left corner to activate the TOC</div></div>')
            .prepend('<div id="generated-toc-show"></div>');

    // activation hotspot: show (and resize) TOC on hover, hide on click
    $('#generated-toc-show').mouseover(function(event){
        if ($('#generated-toc').height() > window.innerHeight) {
            $('#generated-toc').height(window.innerHeight - 5);
        } 
        $('#generated-toc').fadeIn('slow');
    }).click(function(event){
        $('#generated-toc').fadeOut('slow');
    });

    // hide TOC when clicking anywhere on TOC
    // (as a desired side-effect, it hides the TOC 'after use', i.e, after clicking a link)
    $('#generated-toc').click(function(event){
        $('#generated-toc').fadeOut('slow');
    });
    //// explicitly hide TOC link
    //$('#generated-toc .title a').click(function(event){
    //    event.preventDefault();
    //    $('#generated-toc').fadeOut('slow');
    //});
    //// hide TOC after use
    //$('#generated-toc ul a').click(function(event){
    //    //$('#generated-toc').fadeOut('slow');
    //});
    
    // generate TOC
    $('*:header').each(function(i) {
        var x = 'toc-header-' + i;
        var level = parseFloat($(this).attr('tagName').substring(1)) * 0.5 - 0.5;
        $(this).prepend('<a name="'+x+'">');
        $('#generated-toc ul').append('<li style="padding-left: '+level+'em;"><a href="#'+x+'">' + $(this).text() + '</a></li>');
    });
    

});
