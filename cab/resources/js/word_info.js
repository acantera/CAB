    $( document ).ready(function(){  
        $("#display-viewer").click(function() {
            Deselect();
        });    
        
        $( '#main-paral-viewer' ).on( 'scroll', function(){
            Deselect();
        });    

        $(".stanza_paragraph").click(function() {
            Deselect();
        });  

        $(document.body).on('hover', 'ab' ,function(){
            $(this).css( 'cursor', 'pointer' );
        });
        
        $(document.body).on('click', 'ab' ,function(){
             
            if ( $(this).parents('#stanza-modals').length )  {
                return;
            }              
        
            var $direction = $('#avestan_char').attr('val');
        
            if ( $direction == -1 ) {
                if ( $(this).parents('#display-viewer').length )  {
                    return;
                }
            }
             
            $(this).css( 'cursor', 'pointer' );
            
            if ( $( this).has( "l" ).length == 0)   {
                
                $("ab").css("color","black");
                $("l").css("color","black");
                $(this).css("color","#cd603f");
                
                var $text = $( this ).first().text().replace('zōt ud rāspīg', 'zōtudrāspīg'); // keep zot ud rasping intact
                var words = $text.trim().split( /\s+/ );
                
                $wordrow = '';
                $n = 1;
        
                words.forEach(function(entry) {
                    if ( entry.includes("zōtudrāspīg") ) {
                        $wordrow = $wordrow + '<note>' + "zōt ud rāspīg" + '</note>' + ' ';    
                    
                    } else if ( entry.includes("rāspīg") )    {
                        $wordrow = $wordrow + '<note>' + "rāspīg" + '</note>' + ' ';    
                    } else if ( entry.includes("zōt") )    {
                        $wordrow = $wordrow + '<note>' + "zōt" + '</note>' + ' ';
                        
                    } else {
                        $wordrow = $wordrow + '<word nr="' + $n + '">' + entry + ' </word>';   
                        $n++;
                    }
                    
                });
                
                $('#current-select').css({
                    top: ( $( this ).first().position().top + 3 ),
                    left: 0
                });
                
                $('#current-select').css('display','block');
                
                $( this ).first().html( $wordrow );                
                
                    $( "word" ).on( "click", function() {
                        var $id = $(this).closest('ab').attr('xml:id');
                        var $grand_id = $(this).closest('.tabcontent').attr('id');

                        if ( $id.includes( "Ratu" ) || $id.includes( "Roz" ) 
                                || $id.includes( "Waz" ) || $id.includes( "Shnuman" ) 
                                || $id.includes( "Gahanbar" ) || $id.includes( "AV" )
                                || $id.includes( "YAV" ) || $id.includes( "YeH" ) ) {
                            $id = $id;
                        } else {
                            $id = $grand_id +  $id.substring( $id.length - 1 );                            
                        }

                        $('#modalword').dialog('close'); 
                        $('#modalnerang').dialog('close');
                        $('#modalword').dialog(
                            { width: 470, close: CloseFunction,                                        
                                        open: function(event, ui) {
                                            $(".ui-dialog-titlebar-close", ui.dialog | ui).show();
                                        } }
                        ); 
                        
                        $('#modalword').css("display","block");
        
                        $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );  
                        
                        var $wn = $(this).attr('nr');
                        var $word = $(this).text();
                        GetWordInfo( $id,$wn, $word );
            
                        $('#modal-word-title').html($id + " " + $(this).html() + " " + $wn);
                    }); 
                
                } 
                
            });
            
        $(document.body).on('click','paral', function(){
            
            var $paral = $(this).closest('paral').html();

            $('#modalparallel').dialog(
                { width: 570, close: CloseParallelFunction }
            );  
            
            $('#modalparallel').css("display","block");
            GetParalInfo( $paral );
            $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );  
            
        })
            
        $(document.body).on('click', 'l' ,function(){
                
                var $direction = $('#avestan_char').attr('val');
                
                if ( $(this).parents('#stanza-modals').length )  {
                    return;
                }              
    
                if ( $direction == -1 ) {
                    if ( $(this).parents('#display-viewer').length )  {
                        return;
                    }
                }         
    
                $(this).css( 'cursor', 'pointer' );
    
                $("ab").css("color","black");
                $("l").css("color","black");
                $(this).css("color","#cd603f");
                
                var $text = $( this ).first().text().replace('zōt ud rāspīg', 'zōtudrāspīg'); // keep zot ud rasping intact
                var words = $text.trim().split( /\s+/ );
                
                $wordrow = '';
                $n = 1;
        
                words.forEach(function(entry) {
                    if ( entry.includes("zōtudrāspīg") ) {
                        $wordrow = $wordrow + '<note>' + "zōt ud rāspīg" + '</note>' + ' ';    
                    
                    } else if ( entry.includes("rāspīg") )    {
                        $wordrow = $wordrow + '<note>' + "rāspīg" + '</note>' + ' ';    
                    } else if ( entry.includes("zōt") )    {
                        $wordrow = $wordrow + '<note>' + "zōt" + '</note>' + ' ';
                    } else {
                        $wordrow = $wordrow + '<word nr="' + $n + '">' + entry + ' </word>';   
                        $n++;
                    }
                    
                });
                
                $('#current-select').css({
                    top: ( $( this ).first().position().top + 3 ),
                    left: ( $( this ).first().position().left - 10 )
                });
                
                $('#current-select').css('display','block');
                
                $( this ).first().html( $wordrow );                
                
                    $( "word" ).on( "click", function() {
                        var $id = $(this).closest('ab').attr('xml:id');
                        var $grand_id = $(this).closest('.tabcontent').attr('id');

                        if ( $id.includes( "Ratu" ) || $id.includes( "Roz" ) 
                                || $id.includes( "Waz" ) || $id.includes( "Shnuman" ) 
                                || $id.includes( "Gahanbar" ) || $id.includes( "AV" )
                                || $id.includes( "YAV" ) || $id.includes( "YeH" ) ) {
                            $id = $id;
                        } else {
                            $id = $grand_id +  $id.substring( $id.length - 1 );                            
                        }
                        
                        //TO BE IMPROVED
                        $id = $grand_id + $id;   
                        $('#modalword').dialog('close');
                        $('#modalnerang').dialog('close');
                        $('#modalword').dialog(
                            { width: 470, close: CloseFunction,                                        
                                        open: function(event, ui) {
                                            $(".ui-dialog-titlebar-close", ui.dialog | ui).show();
                                        } }
                        ); 
                        
                        $('#modalword').css("display","block");
        
                        $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );  
                        
                        var $wn = $(this).attr('nr');
                        var $word = $(this).text();
                        GetWordInfo( $id,$wn, $word );

                        $('#modal-word-title').html($id + " " + $(this).html() + " " + $wn);                        
                    }); 
    
        });        
        
    });

    function Deselect()
    {
        $("ab").css("color","black");
        $("l").css("color","black");
        
        $('#current-select').css('display','none');
        
        $('word').contents().unwrap();
    }
    
    function CloseFunction()
    {
        $('#word-modal').html('<p>' + 'Retrieving word information ' + '<i class="fa fa-circle-o-notch fa-spin"/>' +
        '</p>');
    }

    function CloseParallelFunction()
    {
        $('#parallel-modal').html('<p>' + 'Retrieving information on parallels ' + '<i class="fa fa-circle-o-notch fa-spin"/>' +
        '</p>');
    }

    function GetWordInfo( $id, $nr, $word )
    {
        var $link = '';
        if ( [ '⁺', '†', '+'].includes($word[0]) ) {        // remove supra and corrupt signs
            $word = $word.substring(1);
        }
        
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_wordinfo.xql?stanza=", $id ,"&amp;n=", $nr, "&amp;word=", $word );
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');

        $.ajax({
                    
            url: $link,
            async: false,
            beforeSend: function () {
                $('#modalword').css("display","block");         // to fix weird bug in Chrome
            },
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
    