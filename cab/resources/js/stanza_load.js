$( document ).ready(function() {
    
    // numbering
    getNumbering();
    removeDoubles();
    
    // parallels
    var $paral  = $('parallels').html();
    var $ritual = $('ritual').html();

    if ( $paral )   {
        $paral = replacePassages( $paral );
        $('parallels').replaceWith( $paral );
    }

    if ( $ritual )    {
        $ritual = replacePassages( $ritual );
        $('ritual').replaceWith( $ritual );
    }

    // bibliography
    $( "bibl" ).each(function( index ) {
        getBibl( $( this ).text() );
    });
    
    $( document ).on( "click", "bibl", function() {
        $('#modalbiblio').dialog(
            { width: 470, close: CloseFunction,                                        
                    open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", ui.dialog | ui).show();
                }
        });
        
        $('.ui-dialog').draggable( "option", "containment", '#actual_entry' );
        
        var $bibl = $(this).text();    
        getBiblInfo( $bibl );
        
    } );
});

function CloseFunction()
{
    $('#biblio-modal').html('<p>' + 'Retrieving bibliographical reference ' + '<i class="fa fa-circle-o-notch fa-spin"/>' +
    '</p>');
}

function replacePassages( $toReplace )
{
        $toReplace = $toReplace.replace(/\Y(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=Y$1.$2' target='_blank'>Y$1.$2</a>");
        $toReplace = $toReplace.replace(/\YR(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=YR$1.$2' target='_blank'>YR$1.$2</a>");
        
        $toReplace = $toReplace.replace(/\DrYt(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=DrYtR$1.$2' target='_blank'>DrYt$1.$2</a>");
        
        $toReplace = $toReplace.replace(/\VVrS(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=VVrS$1.$2' target='_blank'>VVrS$1.$2</a>");
        $toReplace = $toReplace.replace(/\ VrS(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=VrS$1.$2' target='_blank'>VrS$1.$2</a>");
        
        $toReplace = $toReplace.replace(/\VS(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=VS$1.$2' target='_blank'>VS$1.$2</a>");
        $toReplace = $toReplace.replace(/\V(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=V$1.$2' target='_blank'>V$1.$2</a>");
            
        $toReplace = $toReplace.replace(/\VytSY(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=VytSY$1.$2' target='_blank'>VytSY$1.$2</a>");
        $toReplace = $toReplace.replace(/\VytVrS(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=VytSY$1.$2' target='_blank'>VytVrS$1.$2</a>");
        
        $toReplace = $toReplace.replace(/\Yt(\d+)\.(\d+)/g, "<a href='stanza.html?stanza_id=Yt$1.$2' target='_blank'>Yt$1.$2</a>");

        return $toReplace;
}

function replaceBibl( $biblref, $biblnew )
{
    var $replaced = $("#display-viewer-stanza").html().replace( $biblref, $biblnew );
    $("#display-viewer-stanza").html($replaced);
}

function replaceWordBibl( $biblref, $biblnew )
{
    $( ".morph_note" ).append( "<br/><br/><p>&#8226;" + $biblnew + "</p>" );
}

function getBiblInfo( $biblref )
{
    var $link = "";
    $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_bibl.xql?reference=', $biblref );
   
    $.ajax({
                    
            url: $link,
            async: true,
            success: function( data ) {
                $('#biblio-modal').html( xmlToString(data) );               
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });

}

function getBibl( $biblref )
{
    var $link = "";
    $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_bibl.xql?reference=', $biblref );
   
    $.ajax({
                    
            url: $link,
            async: true,
            success: function( data ) {
                replaceBibl( $biblref, xmlToString(data) )                
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });

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

function getNumbering()
{
    $( "xmlid" ).each(function( index ) {
        var $stanzaNr = $( this ).text();
        var $stanzaChar = $stanzaNr.charAt( $stanzaNr.length - 3 );
        if ( $stanzaChar == 'x' )   {
            $stanzaNr = $stanzaNr.replace( "x", nextChar('a', index ) );
            $( this ).text($stanzaNr);
        }
        
    });    
    
    var $i = 1;
    
    $( ".table_numeric" ).each(function( index ) {
        var $tableNr = $( this ).text();
        if ( $tableNr == 'no' ) {
            $tableNr = $tableNr.replace( "no", $i );
            $( this ).text( $tableNr );
            $i++;
        }
        
    });
    
}

function removeDoubles()
{
    var $prev_ab1 = "";
    var $prev_ab2 = "";
    var $prev_ab3 = "";
    var $n = 0;
    
    $( ".ab_special" ).each(function( index ) {
      
        var $rowText = $( this ).find( "xmlid" ).text();
        //var $rowAb = $( this ).text();
    
        //if ( $prev === $rowText )    {
        //   $( this ).remove();
        //    $n++;
        //} else {
        //    $prev = $rowText;
            
        //    if ( $n != 1 )  {
        //        $( this ).prev().find( "xmlid" ).html("test");
        //    }
            
        //    $n = 1;
        //} 

        if ( ( ( $prev_ab3 === $rowText ) ||  ( $prev_ab2 === $rowText ) || ( $prev_ab1 === $rowText ) ) && ( $rowText != '' ) )   {
            $( this ).remove();
            $n++;
            
        } else {
            $prev_ab1 = $prev_ab2;
            $prev_ab2 = $prev_ab3;
            $prev_ab3 = $rowText;

            $n = 0;
        }
 
    });  

    // in case it comes at the very end
    if ( ( $n != 0 ) && (  $( "xmlid").size() > 1 ) )  {
        $n = $n / 3 + 1;
        var $newRowText = "[ " + $n + " x ] " + $( ".ab_special" ).find( "xmlid" ).first().text();
        $( ".ab_special" ).find( "xmlid" ).first().html( $newRowText );
    }
    
    // remove doubles in morphology viewer
    $prev_ab1 = $prev_ab2 = $prev_ab3 = "";
    var $n = 0;

    $( ".morph_table_entry" ).each(function( index ) {
      
        var $rowText = $( this ).find( "table" ).attr("xml:id");

        if ( ( $prev_ab3 === $rowText ) ||  ( $prev_ab2 === $rowText ) || ( $prev_ab1 === $rowText ) )    {
            $( this ).remove();
            $n++;

        } else {
            $prev_ab1 = $prev_ab2;
            $prev_ab2 = $prev_ab3;
            $prev_ab3 = $rowText;

            $n = 0;
        }
 
    }); 
}

function nextChar(c,index) 
{
    return String.fromCharCode(c.charCodeAt(0) + index);
}

function StanzaToClipboard() 
{

    var $temp = $("<input>");
    $("body").append( $temp );
    var $stanza_text = $( "#stanza_full" ).clone();
    
    var contentToRemove = $stanza_text.find( "xmlid" ).remove();
    var contentToRemove = $stanza_text.find( "note" ).remove();
    $stanza_text = $stanza_text.text().trim();
    
    $stanza_text = $stanza_text.replace(/ +/g, " ");
    $temp.val( $stanza_text ).select();
    document.execCommand( "copy" );
    $temp.remove();
}

function CopyToClipboard( ElemtoCopy ) 
{
    var $temp = $("<input>");
    $("body").append( $temp );
    
    
    var $toCopy = "";
    
    if ( ElemtoCopy === "morphology" )    {
        $toCopy = "#morphology_entry";
    } else if ( ElemtoCopy === "pahlavi" )    {
        $toCopy = "#pahlavi_entry";
    } else if ( ElemtoCopy === "preved" )    {
        $toCopy = "#preved_entry";
    } else if ( ElemtoCopy === "speaker" )    {
        $toCopy = "#speaker_entry";
    } else if ( ElemtoCopy === "apparatus" )    {
        $toCopy = "#apparatus_entry";
    } else if ( ElemtoCopy === "parallels" )    {
        $toCopy = "#parallels_entry";
    } else if ( ElemtoCopy === "ritual_information" )    {
        $toCopy = "#ritualinfo_entry";
    } else if ( ElemtoCopy === "translations" )    {
        $toCopy = "#translation_entry";
    } else if ( ElemtoCopy === "cite" )    {
        $toCopy = "#cite_entry";
    } 
     
    
    var $stanza_text = $( $toCopy ).clone();

    $stanza_text = $stanza_text.text().trim();
    
    //$stanza_text = $stanza_text.replace(/\s{2,}/g, ' ');

    //$stanza_text = $stanza_text.replace(/ +/g, " ");
    $temp.val( $stanza_text ).select();
    document.execCommand( "copy" );
    $temp.remove();
}

function OpenNav() {
    $('#ceremony_nav').collapse('show');
        
    var $selection = $('input[type=radio][name=ceremonyview]:checked').val();
        
    if ( $selection == 'compare' )  {
        $('#ceremony_nav').css('width','480px');    
    } else {
        $('#ceremony_nav').css('width','300px');
        $('.option_button').css('margin-right','205px');
    }
        
};
    
function OpenManual() {
    $('#ceremony_manual').collapse('show');
        
    //var $selection = $('input[type=radio][name=ceremonyview]:checked').val();
        
    //if ( $selection == 'compare' )  {
        $('#ceremony_manual').css('width','840px');    
    //} else {
    //    $('#ceremony_nav').css('width','300px');
    //    $('.option_button').css('margin-right','205px');
    //}
        
}; 

function CloseNav() {
    $('#ceremony_nav').css('width','0px');
    $('.option_button').css('margin-right','0px');
};

function CloseManual() {
    $('#ceremony_manual').css('width','0px');
    //$('.option_button').css('margin-right','0px');
};


