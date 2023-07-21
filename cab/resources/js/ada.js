    function GotoADA( $getId, $getCorresp )
    {
        $id = $getId;
    
        var $secid = '';
        if ( $getCorresp.indexOf(' ') > -1 )    {
            $secid = $getCorresp.substr(1, $getCorresp.indexOf(' '));
        } else {
            $secid = $getCorresp.substr(1, $getCorresp.length);
        }
        
        $link = '';
        $link = $link.concat( "https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_adaconnection.xql?stanza=", $id );
        
        var $work = '';
        var $work_name_length = 0;
        var $book = '';
        var $paragraph = '';

    if ( $secid.indexOf("GY") > -1 ) {
            $work = 3;      
            $work_name_length = "GY".length;
    } else if ( $secid.indexOf("GVr") > -1 ) {
            $work = 4;      
            $work_name_length = "GVr".length;
    } else if ( $secid.indexOf("CVrS") > -1 ) {
            $work = 19;      
            $work_name_length = "CVrS".length;
            
    } else if ( $secid.indexOf("GVyt") > -1 ) {
            $work = 10;      
            $work_name_length = "GVyt".length;
            
    } else if ( $secid.indexOf("GV") > -1 ) {
            $work = 2;      
            $work_name_length = "GV".length;
    }
    
    $book = $secid.substring( $work_name_length, $secid.indexOf(".") );
    $paragraph = $secid.substring( $secid.indexOf(".") + 1, $secid.length );

    if ( $work.length == 0 ) {
        if ( $getId.indexOf("YR") > -1 ) {
            $work = 57;
            $work_name_length = "YR".length;
        }
        
        $book = $getId.substring( $work_name_length, $getId.indexOf(".") );
        $paragraph = $getId.substring( $getId.indexOf(".") + 1, $getId.length );        
    }


        $open = "https://ada.geschkult.fu-berlin.de/ada_exist/#/manuscripts-cab?work=" + $work + "&amp;book=" + $book + "&amp;paragraph=" + $paragraph  ;
        $open = $open.replace('amp;','');
        $open = $open.replace('amp;','');
        window.open( $open );

        
    }