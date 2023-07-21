$(document).ready(function(){    
    LoadDatabaseEntry();
});    

$.urlParam = function( param ){
	var results = new RegExp('[\?&]' + param + '=([^&#]*)').exec(window.location.href);
	return results[1] || 0;
}

function LoadDatabaseEntry()
{
    var $link = "";
    
    var $manuscript = $.urlParam( 'manuscript' );
    
    $link = $link.concat( 'https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_database_entry.xql?manuscript=' + $manuscript );
   
    $.ajax({
                    
            url: $link,
            async: false,
            success: function( data ) {
                var $val_data = xmlToString(data);
                $( '#entry_database' ).html( $val_data );                
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });
}