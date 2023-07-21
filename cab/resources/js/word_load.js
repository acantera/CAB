function replaceWordBibl( $biblref, $biblnew )
{
    $( ".morph_note" ).append( "<br/><br/><p>&#8226;" + $biblnew + "</p>" );
}

function getWordBibl( $biblref )
{
    var $link = "";
    $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_bibl.xql?reference=', $biblref );
   
    $.ajax({
                    
            url: $link,
            async: true,
            success: function( data ) {
                replaceWordBibl( $biblref, xmlToString(data) )                
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });

}
