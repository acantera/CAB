xquery version "3.1";

let $stanza_id   := request:get-parameter( 'stanza_id'  , '' )
let $ritual_id := request:get-parameter( 'stanza_location'  , '-1' )
    
let $get_ritual := if ( not( $ritual_id eq '-1' ) ) then (
                        $ritual_id
                    ) else if ( contains( $stanza_id, "YR" ) ) then (
                        "1"
                    ) else if ( contains( $stanza_id, "Y" ) ) then (
                        "2"
                    ) else if ( contains( $stanza_id, "VVrS" ) or contains( $stanza_id, "VS" )  ) then (
                        "4" 
                    ) else if ( contains( $stanza_id, "VytVrS" ) ) then (
                        "5" 
                    ) else if ( contains( $stanza_id, "VrS" ) ) then (
                        "3"
                    ) else if ( contains( $stanza_id, "ParagnaLL" ) ) then (
                        "10"                            
                    ) else () 
    
(: first and prev, next and last:)
let $blueprint_location := 
    switch ($get_ritual) 
            case "0" return "/db/apps/cab_db/cab_rituals/blueprint/Dron_ceremonies/Dron_dynamic/"
            case "1" return "/db/apps/cab_db/cab_rituals/blueprint/YasnaR_dynamic/"
            case "2" return "/db/apps/cab_db/cab_rituals/blueprint/Yasna_dynamic/"
            case "3" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_dynamic/"
            case "4" return "/db/apps/cab_db/cab_rituals/blueprint/Videvdad_dynamic/"
            case "5" return "/db/apps/cab_db/cab_rituals/blueprint/Vishtasp_dynamic/"
            case "9" return "/db/apps/cab_db/cab_rituals/blueprint/Dron_ceremonies/HomastParagna_dynamic/"
            case "10" return "/db/apps/cab_db/cab_rituals/blueprint/Cluster_rituals/Paragna_dynamic/"
            case "11" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_DH_dynamic/"
                default return 0   
                
let $ceremony_title := 
    switch ($get_ritual) 
            case "0" return "Dron"
            case "1" return "Yasna Rapithwin"
            case "2" return "Yasna"
            case "3" return "Visperad"
            case "4" return "Videvdad"
            case "5" return "Vištasp Yašt"
            case "9" return "Homast Paragna"
            case "10" return "Paragna"
            case "11" return "Visperad Do-Homast"
                default return 0               
                
                
return
    <div>
        <h3 id="nav_ceremony_title">{$ceremony_title}</h3>
        {
            for $i at $pos in collection( $blueprint_location )/div/div
                return
                    <div>
                        <a href="#/" data-toggle="collapse" data-target="#list{$pos - 1}"><h4 id="nav_ceremony_header"><span class="glyphicon glyphicon-chevron-down"></span>&#160;{data($ceremony_title)}&#160;{$pos - 1}</h4></a>
                        <div id="list{$pos - 1}" class="collapse" aria-expanded="true" style="height: auto;">
                        <ul id="#li{$pos - 1}">
                            {
                                for $j in $i/div
                                let $jid := data( $j/@xml:id )
                                let $jcorresp := data( $j/@corresp )
                                    return
                                    <li>
                                        <a href="stanza.html?stanza_id={$jid}&amp;stanza_location={$get_ritual}&amp;stanza_type={substring( $jcorresp, 2 )}" target="_blank"> <span class="glyphicon glyphicon-play"/>&#160;{$jid}&#160;{if ( $jcorresp ) then ( concat( "(", $jcorresp, ")" ) ) else ()}</a>
                                    </li>
                            }
                        </ul>
                        </div>
                    </div>
        }
    </div>     