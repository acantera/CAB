    $( document ).ready(function(){  
        
        // deactivate sticky for large pannels
        if ( $(".tab_float").height() > 320 ) {
            $(".tab_float").css("position", "relative" );
        }
        
        // set anchor height
        var $anchor_height = $( "#stanza_text" ).height() + 20 + 85 ; // + 2xPadding + Menu Height
        $(".anchor").css("padding-top", $anchor_height);
        $(".anchor").css("margin-top", $anchor_height);
        
        // rest of fuctions
        $(".tab_float").click(function() {
            Deselect();
        }); 
        
        $("#display-viewer-stanza").click(function() {
            Deselect();
        });    
        
        $(document.body).on('hover', 'wordlist' ,function(){
            $(this).css( 'cursor', 'pointer' );
        });
  
        $(document.body).on('click', 'wordlist' ,function(){
            $( "note" ).remove();
            
            $("wordlist").css("color","#262626");
            $(this).css("color","#cd603f");            

            $(this).css( 'cursor', 'pointer' );
    
            var $parent = $( this ).parent().attr('class');
            
            
            if ( ( $parent == "in1lineblock_stanza" ) || ( $parent == "in1line_stanza" ) ) {
                var $cycle = $(this).parent();
                var $n = 1;
              
                if ( $parent != "in1lineblock_stanza" ) {
                    
                    while ( $cycle.attr('class') == "in1line_stanza" )  {
                        $cycle = $cycle.prev();
                    }
                    
                    $cycle.children('wordlist').css("color","#cd603f");            
                    $cycle.children('wordlist').css( 'cursor', 'pointer' );
                    
                    var $text = $cycle.children('wordlist').first().text();
                    var words = $text.trim().split( /\s+/ );
                    
                    $wordrow = '';
                    words.forEach(function(entry) {
                        $wordrow = $wordrow + '<sup>' + $n + '</sup><word nr="' + $n + '">' + entry + ' </word>';   
                        $n++;
                    });                
                
                    $cycle.children('wordlist').first().html( $wordrow );
                    
                    // go to next
                    $cycle = $cycle.next();
                    
                }
                
                do {
                
                    $cycle.children('wordlist').css("color","#cd603f");            
                    $cycle.children('wordlist').css( 'cursor', 'pointer' );
                    
                    var $text = $cycle.children('wordlist').first().text();
                    var words = $text.trim().split( /\s+/ );
                    
                    $wordrow = '';
                
                    words.forEach(function(entry) {
                        $wordrow = $wordrow + '<sup>' + $n + '</sup><word nr="' + $n + '">' + entry + ' </word>';   
                        $n++;
                    });                
                
                    $cycle.children('wordlist').first().html( $wordrow );
                    
                    // go to next
                    $cycle = $cycle.next();
                    
                } while ( $cycle.attr('class') == "in1line_stanza" );
                
            } else {
                
                var $text = $( this ).first().text();
                var words = $text.trim().split( /\s+/ );
                    
                $wordrow = '';
                $n = 1;
            
                words.forEach(function(entry) {
                    $wordrow = $wordrow + '<sup>' + $n + '</sup><word nr="' + $n + '">' + entry + ' </word>';   
                    $n++;
                });
            
                $( this ).first().html( $wordrow ); 

            }

            $( "word" ).on( "click", function() {
                var $id = $(this).closest('wordlist').attr('id');
               
                var $grand_id = $('#stanza_id').html();
                //TO BE IMPROVED
                if ( $id.replace(/\d+/g, '').indexOf( $grand_id.replace(/\d+/g, '') ) >= 0 )    {
                    $id = $id.substring( $id.length - 1 );
                    $id = $grand_id + $id;                             
                } // else keep original id
                
                $('#modalavestan').dialog('close');
                $('#modalnerang').dialog('close');
                $('#modalvideo').dialog('close');
                $('#modalword').dialog('close');
                
                $('#modalword').dialog(
                { width: 470, close: CloseFunction}); 
                            
                $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );  
                           
                var $wn = $(this).attr('nr');
                var $word = $(this).text();
                GetWordInfo( $id,$wn, $word );                       
                            
                //$('#modal-word-title').html($id + " " + $(this).html() + " " + $wn);                        
    
            });

        });
        
    });

    function Deselect()
    {
        $("wordlist").css("color","#262626");

        $('#current-select').css('display','none');
        
        $('word').contents().unwrap();
        $('sup').remove();
    }
    
    function CloseFunction()
    {
        $('#word-modal').html('<p>' + 'Converting paragraph to Avestan ' + '<i class="fa fa-circle-o-notch fa-spin"/>' +
        '</p>');
    }

    function GetWordInfo( $id, $nr, $word )
    {
        var $link = '';
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_wordinfo.xql?stanza=", $id ,"&amp;n=", $nr, "&amp;word=", $word );
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
           
        $.ajax({
                    
            url: $link,
            async: false,
            success: function( data ) {
                $('#word-modal').html( xmlToString(data) );
                // bibliography
                $( '#word-modal bibl' ).each(function( index ) {
                    getWordBibl( $( this ).text() );
                });
            },
                
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                           
        }).done(function( data ) {
                console.log( data );
                 
        });
            
    };    