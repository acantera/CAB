xquery version "3.1";

let $word   := request:get-parameter( 'word', '' )
let $param  := request:get-parameter( 'param', '' )

return
    <div>
        {if ( contains( $param, '1' ) ) then (
        <div>
            <span id="dron" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Dron
                    </h4>
            </div>
            <div> {
                let $dron_val := for $i in collection( "/db/apps/cab_db/cab_statics/Static_Dron" )//div[@id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($dron_val)}</b></div>                  
                    {
                    for $i at $pos in $dron_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}
        {if ( contains( $param, '2' ) ) then (
        <div>
            <span id="yasnar" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Yasna Rapithwin
                    </h4>
            </div>
            <div> {
                let $yasnar_val := for $i in collection( "/db/apps/cab_db/cab_statics/Static_YasnaR" )//div[@id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($yasnar_val)}</b></div>                  
                    {
                    for $i at $pos in $yasnar_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}        
        {if ( contains( $param, '3' ) ) then (
        <div>
            <span id="yasna" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Yasna
                    </h4>
            </div>
            <div> {
                let $yasna_val := for $i in collection( "/db/apps/cab_db/cab_statics/Static_Yasna" )//div[@id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($yasna_val)}</b></div>                  
                    {
                    for $i at $pos in $yasna_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}          
        {if ( contains( $param, '4' ) ) then (
        <div>
            <span id="visperad" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Visperad
                    </h4>
            </div>
            <div> {
                let $visperad_val := for $i in collection( "/db/apps/cab_db/cab_statics/Static_Visperad" )//div[@id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($visperad_val)}</b></div>                  
                    {
                    for $i at $pos in $visperad_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}
        {if ( contains( $param, '5' ) ) then (
        <div>
            <span id="videvdad" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Videvdad
                    </h4>
            </div>
            <div> {
                let $videvdad_val := for $i in collection( "/db/apps/cab_db/cab_statics/Static_Videvdad" )//div[@id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($videvdad_val)}</b></div>                  
                    {
                    for $i at $pos in $videvdad_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}    
        {if ( contains( $param, '6' ) ) then (
        <div>
            <span id="vishtasp" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Vishtasp Yasht
                    </h4>
            </div>
            <div> {
                let $vishtasp_val := for $i in collection( "/db/apps/cab_db/cab_statics/Static_Vishtasp" )//div[@id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($vishtasp_val)}</b></div>                  
                    {
                    for $i at $pos in $vishtasp_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}      
        {if ( contains( $param, '7' ) ) then (
        <div>
            <span id="khordeh" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Khordeh Avesta
                    </h4>
            </div>
            <div> {
                let $khordeh_val := for $i in collection( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/" )//div[@xml:id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@xml:id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                        
                (:let $khordeh_val_add := for $i in collection( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/" )//div[@xml:id]
                    for $j in $i//include
                        for $k in collection ( data( $j/@href ) )//div[@xml:id eq $j/@xpointer]//ab[contains( ., $word )]
                        return
                        <div>
                            <ide>{$j/@xpointer}</ide>
                            <position>{$k/@xml:id}</position>
                            <text>{$k}</text>
                        </div>
                        
                        
let $k_val := for $i in collection( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/" )//div[@xml:id]
                for $j in $i//include
                return
                <div>
                    <d>{data($j/@xpointer)}</d>
                    <e>{data($j/@href)}</e>
                </div>

for $i in $k_val
 for $j in collection ( data( $i/e ) )//div[contains(@xml:id,data($i/d))]//ab[contains(., "maz")]
    return
        $j
                        :)
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($khordeh_val)}</b></div>                  
                    {
                    for $i at $pos in $khordeh_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@xml:id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                    
                  
                                        
                </div>
            } </div>   
        </div>
        ) else ()}          
        {if ( contains( $param, '8' ) ) then (
        <div>
            <span id="blocks" />
            <br/>
            <div class="tab_header tab_header_search">
                    <h4>
                        Blocks and other fragments
                    </h4>
            </div>
            <div> {
                let $blocks_val := for $i in collection( "/db/apps/cab_db/cab_rituals/blocks" )//div[@xml:id]
                    for $j in $i//ab[contains( ., $word )]
                    return                
                        <div>
                            <ide>{$i/@xml:id}</ide>
                            <position>{$j/@xml:id}</position>
                            <text>{$j}</text>
                        </div>
                
                return
                <div>
                    <div class="search_result"><b>Number of Results: {count($blocks_val)}</b></div>                  
                    {
                    for $i at $pos in $blocks_val
                    return
                        <div class="{if ( $pos mod 2 = 0 ) then ( "search_even" ) 
                                                           else ( "search_odd" )}">
                            <div>
                                <b style="color: #c94c2d">{data($pos)}</b> in <b style="font-size:16px">{data($i/ide/@xml:id)} ({data($i/position/@xml:id)}): </b>{$i/text}
                            </div>
                        </div>
                    }
                </div>
            } </div>   
        </div>
        ) else ()}              
    </div>