    let $stanza_id   := request:get-parameter( 'stanza_id'  , 'Y1.1' )
    let $get_ritual := request:get-parameter( 'stanza_location'  , '2' )
    let $dir := request:get-parameter( 'dir'  , '1' )
    
    
    let $blueprint_location := 
        switch ($get_ritual) 
            case "0" return "/db/apps/cab_db/cab_rituals/blueprint/Dron_ceremonies/Dron_dynamic/"
            case "1" return "/db/apps/cab_db/cab_rituals/blueprint/YasnaR_dynamic/"
            case "2" return "/db/apps/cab_db/cab_rituals/blueprint/Yasna_dynamic/"
            case "3" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_dynamic/"
            case "4" return "/db/apps/cab_db/cab_rituals/blueprint/Videvdad_dynamic/"
            case "5" return "/db/apps/cab_db/cab_rituals/blueprint/Vishtasp_dynamic/"
            case "9" return "/db/apps/cab_db/cab_rituals/blueprint/Dron_ceremonies/HomastParagna_dynamic/"
            case "10" return "/db/apps/cab_db/cabnew_rituals/blueprint/Cluster_rituals/Paragna_dynamic/"
            case "11" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_DH_dynamic/"
                default return 0        
                
(: add @xml:id as an AND condition to avoid empty nodes :)
let $idlist := 
    <val>
    {
        for $i in collection( $blueprint_location )//div[@xml:id]
            return
                <id>{$i/@xml:id}</id>                   
    }
    </val>    

    
return
    <div>
    {
    if ( $dir eq '1' ) then (
                        (: next :)
            let $next := for $i in $idlist/id[@xml:id eq data($stanza_id)]
                         return
                            data($i/following-sibling::*[1]/@xml:id)
            return
                if ($next) then (
                    $next    
                ) else (
                    (: goto first :)  
                    (for $i in collection( $blueprint_location )//div
                        return
                            data($i/@xml:id))[1]
                )
    ) else if ( $dir eq '-1' ) then (
                        (: prev :)    
            let $prev := for $i in $idlist/id[@xml:id eq data($stanza_id)]
                         return
                            data($i/preceding-sibling::*[1]/@xml:id)    
            
            return
                if ($prev) then (
                    $prev    
                ) else (
                    (: goto last :)
                    (for $i in collection( $blueprint_location )//div
                        return
                            data($i/@xml:id))[fn:last()]  
                )
    ) else () 
    }
    </div>