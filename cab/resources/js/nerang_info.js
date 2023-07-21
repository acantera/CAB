    $( document ).ready(function(){  
        // video module
        
        var ab_mod = 0;
        
        $(document.body).on('hover', 'ab_mod' ,function(){
            $(this).css( 'cursor', 'pointer' );
        }); 
   
        $(document.body).on('click', 'ab_mod' ,function() {
            ab_mod = 1;
            $('#modalword').dialog('close');
            $('#modalvideo').dialog('close');
            $('#modalvideo').dialog({  width: 560,
                                        closeOnEscape: false
                                    });
                                    
            $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );                          
                                    
            var $nerang_video_id = $(this).attr('xml:id');
            
            var $link = '';
            $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_nerang_media.xql?id=", $nerang_video_id );
            $link = $link.replace('amp;','');
                
            $.ajax({
                        
                url: $link,
                async: false,
                success: function( data ) {
                    $('#video-modal').html( xmlToString(data) );
                },
                    
                type: "GET",
                processData: false,  // tell jQuery not to process the data
                contentType: false   // tell jQuery not to set contentType
                               
            }).done(function( data ) {
                    console.log( data );
                     
            });
            
        });        
        
        // nerang module
        $(document.body).on('hover', 'ab1' ,function(){
            $(this).css( 'cursor', 'pointer' );
        }); 
   
        $(document.body).on('click', 'ab1' ,function() {
            if ( ab_mod == 1 )  {
                ab_mod = 0;
                return;
            }

            $('#modalword').dialog('close');
            $('#modalnerang').dialog('close');
            $('#modalnerang').dialog({  width: 560,
                                        closeOnEscape: false
                                    });
                                    
            $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );                          
                                    
            var $nerang_id = $(this).attr('xml:id');
            
            var $link = '';
            $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_nerang.xql?id=", $nerang_id );
            $link = $link.replace('amp;','');
                
            $.ajax({
                        
                url: $link,
                async: false,
                success: function( data ) {
                    $('#nerang-modal').html( xmlToString(data) );
                },
                    
                type: "GET",
                processData: false,  // tell jQuery not to process the data
                contentType: false   // tell jQuery not to set contentType
                               
            }).done(function( data ) {
                    console.log( data );
                     
            });
            
            
        });
        
        //$(document.body).on('click', function( e ) {
        //    if ($(e.target).closest("#modalnerang").length === 0) {
        //        $('#nerang-modal').html('<p>' + 'Retrieving nerang and translation ' 
        //                            + '<i class="fa fa-circle-o-notch fa-spin"/>' + '</p>');
        //    
        //        $('#modalnerang').dialog('close');
        //    }
        //});
    });