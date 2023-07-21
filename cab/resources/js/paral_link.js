    $( document ).ready(function(){  
        $("#display-viewer").click(function() {
            $('.parral').contents().unwrap();
        });    
        
        $(document.body).on('hover', 'prl' ,function(){
            $(this).css( 'cursor', 'pointer' );
        });
        
        $(document.body).on('click', 'prl' ,function() {
            var $text = $( this ).first().text(); // keep zot ud rasping intact
            var words = $text.trim().split( /\s+/ );
            
            $linkrow = '';
            
            words.forEach(function(entry) {
                if ( ( entry.includes( "=" ) ) || ( entry.includes( "≈" ) ) ) {
                    $linkrow = $linkrow + entry + ' ';
                } else {
                    $linkrow = $linkrow + '<a class="parral" href="stanza.html?stanza_id=' + entry + '" target="_blank">' + entry + '</a> ';
                }
            });
            
            $( this ).first().html( $linkrow );   
            
        });
        
    });