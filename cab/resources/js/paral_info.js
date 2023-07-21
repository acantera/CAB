    $( document ).ready(function(){  
        $(document.body).on('click','paral', function(){
            
            var $paral = $(this).closest('paral').html();

            $('#modalparallel').dialog(
                { width: 570, close: CloseParallelFunction }
            );  
            
            $('.ui-dialog').position({ my: "center", at: "center", of: ".indiv_paragraph" });
            
            $('#modalparallel').css("display","block");
            GetParalInfo( $paral );
            $('.ui-dialog').draggable( "option", "containment", '.indiv_paragraph' );  
                    
            
        })
            
    });
    
    function GetParalInfo( $paral )
    {
        var $link = '';
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_paral.xql?paralstart=", $paral ,"&amp;paralend=", '0' );
        $link = $link.replace('amp;','');
        
        $.ajax({
                    
            url: $link,
            async: false,
            success: function( data ) {
                $('#parallel-modal').html( xmlToString(data) );
            },
                
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                           
        }).done(function( data ) {
                console.log( data );
                 
        });
            
    }
    
    function SyncCeremonies( $data )
    {
        var $paral_dest = $( $data ).text();
        if ( $paral_dest )  {
            NavParal( $paral_dest );
        } else {
            $('#paral-viewer').find('.tabcontent').css('display','none');
            $('#no-paral').css('display','block');
        }
    }
    
    function SetParal()
    {
        var $sync = $('#sync_paral').attr('val');
        
        if ( $sync == 1 )   {
            $('#sync_paral').attr('val', 0 );
            $('#sync_paral').html('<span class="glyphicon glyphicon-refresh"/> Sync Parallels Off');

        } else {
            $('#sync_paral').attr('val', 1 );
            $('#sync_paral').html('<span class="glyphicon glyphicon-refresh"/> Sync Parallels On');
            GetParal();
        }

    }
    
    function GetParal()
    {

        $('#modalnoparal').dialog('close');
        var $main_id = $(".tabcontent:visible").attr('id');
        
        var $secondary_liturgy = "";
        
        var $second = $("#paral-viewer .tabcontent").attr('id');

        if ( $second.indexOf("DrYt") > -1 ) {
            $secondary_liturgy = 0;
        } else if ( $second.indexOf("YR") > -1 ) {
            $secondary_liturgy = 1;
        } else if ( $second.indexOf("Y") > -1 ) {
            $secondary_liturgy = 2;
        } else if ( $second.indexOf("VVrS") > -1 ) {
            $secondary_liturgy = 4;
        } else if ( $second.indexOf("VytVrS") > -1 ) {
            $secondary_liturgy = 5;
        } else if ( $second.indexOf("VrS") > -1 ) {
            $secondary_liturgy = 3;
        }


        var $link = '';
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_paralstanza.xql?main=", $main_id ,"&amp;paral=", $secondary_liturgy );
        $link = $link.replace('amp;','');
        
        $.ajax({
                    
            url: $link,
            async: false,
            success: function( data ) {
                SyncCeremonies( xmlToString(data) );
            },
                
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                           
        }).done(function( data ) {
                console.log( data );
                 
        });        

    }