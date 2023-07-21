    function GetStanzaInfo( $id, $location )   
    {
        
        var $link = "stanza.html?";
        $link = $link.concat( "stanza_id=", $id , "&amp;stanza_location=" , $location );
        $link = $link.replace('amp;','');
        window.open( $link ); 

    }
