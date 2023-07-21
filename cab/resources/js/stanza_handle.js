$(document).ready(function(){   
    
        $stanza_id = $.urlParam( 'stanza_id' );
        $stanza_location = $.urlParam( 'stanza_location' );

    
        PopulateStanza( $stanza_id, $stanza_location );
        PopulateNavigator( $stanza_id, $stanza_location );
        
        function ButtonName( $todo )
        {
            if ($( $todo ).text().trim() == 'Collapse Δ') {
                $( $todo ).text('Expand ∇');
            } else {
                $( $todo ).text('Collapse Δ');
            }           
        }
    
        $('.expander').click(function(){
            ButtonName( this );

        });
   
        $( "#navLeft" ).click(function(){
            NavigateStanza( "-1", $stanza_id, $stanza_location );
        });        
        
        $( "#navRight" ).click(function(){
            NavigateStanza( "1", $stanza_id, $stanza_location );
        });

});
    
$(document).on("click", "#morpho_button", function(){
            if ($( "#morpho_button_expand" ).text().trim() == 'Collapse Δ') {
                $( "#morpho_button_expand" ).text('Expand ∇');
            } else {
                $( "#morpho_button_expand" ).text('Collapse Δ');
            }   
});    
    
function SetMenu( $stanza_id )
{
        $( '.always_visible' ).css( 'display', 'block');
        
        if ( $( '.entry_pahlavi' ).length )   {
           $( '#pahlavi_button' ).css( 'display', 'block');
        }
        
        if ( $( '.entry_speaker' ).length )   {
           $( '#speaker_button' ).css( 'display', 'block');
        }
        
        if ( $( '.entry_parallels' ).length )   {
           $( '#parallels_button' ).css( 'display', 'block');
        }
        
        if ( $( '.entry_ritual' ).length )   {
           $( '#ritual_button' ).css( 'display', 'block');
        }
        
}
    
function PopulateGlossary()
{
        $( '#glossing_entry' ).html( "" );
        $stanza_id = $.urlParam( 'stanza_id' );

        var $indx = 0;
        var $wordlist = $( "wordlist", "#stanza_full" );
        
        $( $wordlist ).each(function( index ) {

            var $word =  $( this ).clone();
            $( $word ).find( 'span' ).remove();
            $( $word ).find( 'note' ).remove();
            
            var $wordl = $.trim( $( $word ).text().replace(/zōt ud rāspīg|zōt|rāspīg/ig, "") );
            $list_id = $( this ).attr('id');
            
            if ( $wordl.length ) {
                $indx++;
            } else {
                return;
            }
            var $local_indx = $indx;   
            $( '#glossing_entry' ).append( '<div class="glossclass" id="gloss_' + $indx + '"/>' );
            
            $link = "";
            $link = $link.concat( 'https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_morphology.xql?id=' + $stanza_id + "&amp;ids=" + $list_id + "&amp;indx=" + $indx + "&amp;stanza=" + $wordl );      
            
            $link = $link.replace('amp;','');
            $link = $link.replace('amp;','');
            $link = $link.replace('amp;','');
        
            $.ajax({
                    
                url: $link,
                async: true,
                success: function( data ) {
                    $( '#gloss_' + $local_indx ).append( xmlToString(data) );      
                },
                
                type: "GET",
                processData: false,  // tell jQuery not to process the data
                contentType: false   // tell jQuery not to set contentType
                           
            }).done(function( data ) {
                    console.log( data );
            }); 
            
        });

}
    
function PopulateStanza( $stanza_id, $stanza_location )
{  
        var $link = "";
            
        $link = $link.concat( 'https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/stanza_full.xql?stanza_id=' + $stanza_id + "&amp;stanza_location=" + $stanza_location );
   
        $.ajax({
                    
            url: $link,
            async: true,
            success: function( data ) {
                var $val_data = xmlToString(data);
                $( '#display-viewer-stanza' ).html( $val_data );      
                SetMenu( $stanza_id );
                PopulateGlossary();
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        }); 
} 
    
function PopulateNavigator( $stanza_id, $stanza_location )
{  
        var $link = "";
            
        $link = $link.concat( 'https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/stanza_getnavigator.xql?stanza_id=' + $stanza_id + "&amp;stanza_location=" + $stanza_location );
   
        $.ajax({
                    
            url: $link,
            async: true,
            success: function( data ) {
                var $val_data = xmlToString(data);
                $( '#stanza_navigator' ).html( $val_data );            
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        }); 
}   
    
function NavigateStanza( $dir, $stanza_id, $stanza_location )
{
        var $link = "";
            
        $link = $link.concat( 'https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/stanza_nextprev.xql?stanza_id=' + $stanza_id + "&amp;stanza_location=" + $stanza_location + "&amp;dir=" + $dir );
   
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
   
        $.ajax({
                    
            url: $link,
            async: false,
            success: function( data ) {
                var $val_data = $( xmlToString(data) ).text();
                var $link_open = 'stanza.html?stanza_id=' + $val_data + '&amp;stanza_location=' + $stanza_location;
                $link_open = $link_open.replace('amp;','');
                window.open( $link_open );
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        }); 
}