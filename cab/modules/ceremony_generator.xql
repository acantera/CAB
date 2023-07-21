xquery version "3.1";


declare variable $get_ritual := request:get-parameter( 'ceremony'  , '2' );
(: dron - 0; y rapithwin - 1; y - 2; vsp - 3; v - 4; vish - 5 :)
declare variable $ritual_paral := request:get-parameter( 'paral', '0' );
(: 0 for main, 1 for paral :)

declare variable $dedicatory := request:get-parameter( 'dedicatory', '0' );
declare variable $gah_u := request:get-parameter( 'gah'  , '0' ); 
(: hawan - 0; rapithwin - 1; uzerin - 2; aiwisruthrem - 3; ushahin -4 :)

declare variable $roz_no := request:get-parameter( 'roz', '0' );
declare variable $mah_no := request:get-parameter( 'mah', '0' );

(: Get from files :)
declare variable $ritual := 
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
                default return 0;
                                
declare variable $header_ritual : = 
        switch ($get_ritual) 
            case "0" return "/db/apps/cab_db/cab_rituals/cerem_header/dron_header"
            case "1" return "/db/apps/cab_db/cab_rituals/cerem_header/yasnar_header" 
            case "2" return "/db/apps/cab_db/cab_rituals/cerem_header/yasna_header"
            case "3" return "/db/apps/cab_db/cab_rituals/cerem_header/visperad_header"
            case "4" return "/db/apps/cab_db/cab_rituals/cerem_header/videvdad_header"
            case "5" return "/db/apps/cab_db/cab_rituals/cerem_header/vishtasp_header"
            case "9" return "/db/apps/cab_db/cab_rituals/cerem_header/homastparagna_header/"
            case "10" return "/db/apps/cab_db/cab_rituals/cerem_header/paragna_header/"
            case "11" return "/db/apps/cab_db/cab_rituals/cerem_header/visperad_dh_header"
                default return 0;                       

declare variable $ritual_title : = 
        switch ($get_ritual) 
            case "0" return "Dron Yasht"
            case "1" return "Yasna Rapithwin"
            case "2" return "Yasna"
            case "3" return "Visperad"
            case "4" return "Videvdad"
            case "5" return "Vishtasp Yasht"
            case "9" return "Homast Paragna"
            case "10" return "Paragna"
            case "11" return "Visperad Do-Homast"
                default return 0;       
                   
declare variable $moveable_shnuman :=
        switch ($get_ritual)
            case "10" return 1
                default return 0;

(: Fixed sequences :)
declare variable $offset        := fn:number( $gah_u ) * 3 - 1;
declare variable $offset_simple := fn:number( $gah_u ) + 2;

declare variable $shnumanfixed :=
    switch ( $get_ritual )    
        case "9" return "65"
        case "10" return "64"
            default return "";

let $gahanbar_ded := if ( $dedicatory = ('40', '42' ) )  then (
                        1
                    ) else (    
                        0    
                    )

let $gahanbar := if ( $mah_no eq '2' and $roz_no >= '11' and $roz_no <= '15' ) then (
                        1      (: Maidyozarem :)
                    ) else if ( $mah_no eq '4' and $roz_no >= '11' and $roz_no <= '15' ) then (
                        2      (: Maidyoshahem :)
                    ) else if ( $mah_no eq '6' and $roz_no >= '26' and $roz_no <= '30' ) then (
                        3      (: Paitishahem :)
                    ) else if ( $mah_no eq '7' and $roz_no >= '26' and $roz_no <= '30' ) then (
                        4      (: Ayathrem :)
                    ) else if ( $mah_no eq '10' and $roz_no >= '16' and $roz_no <= '20' ) then (
                        5      (: Maidyarem Gahanbar :)
                    ) else if ( ( $mah_no eq '12' and $roz_no >= '26' ) or ( $mah_no eq '0' and $roz_no >= '31') )then (
                        6      (: Hamaspathmaidyem / Frauuardigan :)
                    ) else (
                        0       (: Not a Gahanbar Date :)  
                    )
                    
let $gahanbar_nomonth := if ( $roz_no > '30' )  then (
                            1
                        ) else (
                            0    
                        )
                        

(: 26 - 30 of the last month :)
let $frawar_days := if ( ( $dedicatory eq '21' ) and ( $roz_no > '25' ) and  ( $mah_no eq '12' ) ) then (
                        1
                    ) else (
                        0    
                    )

(: gatha days NOT in the gahanbar - therefore only with a dedicatory to gatha :)
let $gatha_days  := if ( ( $dedicatory eq '40' ) and $gahanbar_nomonth ) then (
                        1
                    ) else (
                        0    
                    )


let $roz_gen_final := concat( "RozGen" , $roz_no )
let $roz_acc_final := concat( "RozAcc", $roz_no )
let $mah_gen_final := concat( "MahGen" , $mah_no )
let $mah_acc_final := concat( "MahAcc" , $mah_no )

let $gahanbar_acc_final := concat( "GahanbarAcc", $gahanbar)
let $gahanbar_gen_final := concat( "GahanbarGen", $gahanbar)

let $numericgah := fn:number( $gah_u )

(: Create Shnuman :)

let $shacc := if ( not( $shnumanfixed ) ) then (
                concat( "ShnumanAcc", fn:number($dedicatory) )
              ) else (
                concat( "ShnumanAcc", fn:number($shnumanfixed) )
              )
let $shgen := if ( not( $shnumanfixed ) ) then (
                concat( "ShnumanGen", fn:number($dedicatory) )
              ) else (
                concat( "ShnumanGen", fn:number($shnumanfixed) )
              )

let $shnumanacc :=  for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanAcc")//div[@xml:id eq $shacc]/*
                    let $ixpointer := data( $i/@xpointer )
                    return 
                        if ( starts-with($ixpointer, "RatuShnumanAcc" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                                {
                                    let $no := fn:number( fn:replace( $ixpointer,"RatuShnumanAcc","") ) + $numericgah 
                                    let $ratu_shnuman_acc := fn:concat("RatuShnumanAcc", $no mod 6 + fn:floor( $no div 6 ) )
                                    
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanAcc")//ab[@xml:id eq $ratu_shnuman_acc]
                                    return
                                        $x
                                }   
                            </p>    
                                
                        ) else if ( starts-with($ixpointer, "RatuAcc" ) ) then (
                            
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                                {
                                    let $no := fn:number( fn:replace( $ixpointer,"RatuAcc","") ) + $numericgah 
                                    let $ratu_acc := fn:concat("RatuAcc", $no mod 6 + fn:floor( $no div 6 ) )
                                    
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuAcc")//ab[@xml:id eq $ratu_acc]
                                    return
                                        $x
                                }   
                            </p>                                
                            
                        ) else if ( starts-with($ixpointer, "GahanbarAcc" ) ) then (
                            
                            <p>
                                <span class="note red">{"[Gāhānbār] "}</span>
                                {
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarAcc")//ab[@xml:id eq $gahanbar_acc_final]
                                    return
                                        $x 
                                }   
                            </p>                                
                            
     
                        ) else (
                            $i    
                        )

let $shnumangen := for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div[@xml:id eq $shgen]/*
                    let $ixpointer := data( $i/@xpointer )
                    return 
                        if ( starts-with($ixpointer, "RatuShnumanGen" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                                {
                                let $no := fn:number( fn:replace( $ixpointer,"RatuShnumanGen","") ) + $numericgah 
                                let $ratu_shnuman_gen := fn:concat("RatuShnumanGen", $no mod 6 + fn:floor( $no div 6 ) )
                                
                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab[@xml:id eq $ratu_shnuman_gen]
                                return
                                    $x
                                }   
                            </p>                               

                        ) else if ( starts-with($ixpointer, "RatuPaitiShort" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                                {
                                    let $no := fn:number( fn:replace( $ixpointer,"RatuPaitiShort","") ) + $numericgah 
                                    let $ratu_paiti_short := fn:concat("RatuPaitiShort", $no mod 6 + fn:floor( $no div 6 ) )
                                    
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab[@xml:id eq $ratu_paiti_short]
                                    return
                                        $x
                                }   
                            </p>                               
                            
                        ) else if ( starts-with($ixpointer, "GahanbarGen" ) ) then (
                            <p>
                                <span class="note red">{"[Gāhānbār] "}</span>
                                {
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab[@xml:id eq $gahanbar_gen_final]
                                    return         
                                        $x  
                                }   
                            </p>                               
    
                        ) else (
                            $i    
                        )

let $shnuman19 := for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")/div/div[@xml:id eq "ShnumanGen19"]/*
                    return
                        $i


let $ceremony_bp := for $i in collection($ritual)//div[@xml:id]
                    let $ixmlid := data( $i/@xml:id )
                    return
                    (: those dependent on frawardigan, gahambar or gatha days:)
                    if ( data($i/@gahfra) eq '1' ) then (
                        if ( ( $frawar_days eq 1 ) or ( $gatha_days eq 1 ) ) then (
                            <div xml:id="{$ixmlid}" corresp="{data($i/@corresp)}" 
                                paral="{                                    
                                    if ( $get_ritual eq '0' )	then (
                                   	 	for $x in collection("/db/apps/cab_db/cab_parals")//pair[DrYt eq $ixmlid]
                    					return
                						   normalize-space( concat( concat( '=', ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )                    				
                					) else if ( $get_ritual eq '1' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[YR eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '2' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Y eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual = ( '3', '11' ) ) 	then (
                                        for $x in collection("/db/apps/cab_db/cab_parals")//pair[VrS eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/YR, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '4' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[VS eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ',$x/YR, ' ', $x/VrS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '5' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Vyt eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox ) )
                						   )
                					) else ()
                                 }"
                                 quote="{data($i/@quote)}" xheader="{data($i/@headerPointer)}" attest="{data($i/@attest)}">
                                {
                                for $x in $i/include
                                let $xxpointer := data( $x/@xpointer )
                                let $xxpointer_last := fn:substring( $xxpointer, fn:string-length( $xxpointer ), 1 )
                                let $xhref := data( $x/@href )
                                return
                                    if ( $xxpointer eq "AV" ) then (
                                        <include type="prayer" href="/db/apps/cab_db/cab_rituals/blocks/prayers/AV" xpointer="{$xxpointer}" times="{data($x/@times)}"/>
                                    
                                    ) else if ( starts-with($xxpointer,'SupplY') ) then (
                                        <include type="block" href="{$xhref}" xpointer="{$xxpointer}"/>
                                    
                                    ) else if ( starts-with($xxpointer,'Frauuarane_') ) then (
                                    
                                        if ( $frawar_days eq 1 ) then (
                                            <include type="frauuarane" href="{$xhref}" xpointer="{concat($xxpointer, 'Frawardigan')}"/>             
                                        ) else if ( $gatha_days eq 1 ) then (
                                            <include type="frauuarane" href="{$xhref}" xpointer="{concat($xxpointer, 'Gahan')}"/>    
                                        ) else ()
                                    
                                    ) else if ( starts-with($xxpointer,'ShnumanAcc') 
                                            and ( $gatha_days and ( data( $x/@dep ) eq "gath" ) ) or
                                                ( $frawar_days and ( data( $x/@dep ) eq "fraw" ) )  ) then ( 
                                        <include type="block_shnumanacc" />    
                                    
                                    ) else ()
                            }
                            </div>
                        ) else ()
                    (: includes dependent on shnuman:)
                    ) else if ( data( $i/@shnumandep ) > '0' ) then (
                        
                        let $group := if ( data( $i/@shnumandep ) eq '1' )  then (
                                        ('15', '17', '18', '21', '25', '35', '39', '40', '41', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '54', '56', '57', '58')
                                      
                                      ) else if ( data( $i/@shnumandep ) eq '2' ) then (
                                        ( '15', '17', '18', '21', '25' )
                                      ) else if ( data( $i/@shnumandep ) eq '3' ) then (
                                        ( '21' )
                                      ) else ( )
                        
                        return
                            if ( $group = $dedicatory  ) then (
                                <div xml:id="{data($i/@xml:id)}" corresp="{data($i/@corresp)}" quote="{data($i/@quote)}" attest="{data($i/@attest)}"
                                    paral="{                                    
                                        if ( $get_ritual eq '0' )	then (
                                       	 	for $x in collection("/db/apps/cab_db/cab_parals")//pair[DrYt eq $ixmlid]
                        					return
                    						   normalize-space( concat( concat( '=', ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                    						                            concat( '≈', ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                    						   )                    				
                    					) else if ( $get_ritual eq '1' )	then (
                    	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[YR eq $ixmlid]
                    						return
                    						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                    						                            concat( '≈', ' ', $x/DrYt_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                    						   )
                    					) else if ( $get_ritual eq '2' )	then (
                    	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Y eq $ixmlid]
                    						return
                    						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                    						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                    						   )
                    					) else if ( $get_ritual = ( '3', '11' ) )		then (
                                            for $x in collection("/db/apps/cab_db/cab_parals")//pair[VrS eq $ixmlid]
                    						return
                    						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/YR, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                    						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                    						   )
                    					) else if ( $get_ritual eq '4' )	then (
                    	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[VS eq $ixmlid]
                    						return
                    						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ',$x/YR, ' ', $x/VrS, ' ', $x/Vyt ), ' ', 
                    						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/Vyt_aprox ) )
                    						   )
                    					) else if ( $get_ritual eq '5' )	then (
                    	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Vyt eq $ixmlid]
                    						return
                    						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS ), ' ', 
                    						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox ) )
                    						   )
                    					) else ()
                                 }">
                                {
                                    
                                    for $x in $i/include
                                    let $xxpointer := data( $x/@xpointer )
                                    let $xxpointer_last := fn:substring( $xxpointer, fn:string-length( $xxpointer ), 1 )
                                    let $xhref := data( $x/@href )
                                    return
                                        if ( $xxpointer eq "YeH" ) then (
                                            <include type="prayer" href="/db/apps/cab_db/cab_rituals/blocks/prayers/YeH" xpointer="YeH"/>
                                        ) else (
                                        
                                            if ( $xxpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                                <include type="proto" href="{$xhref}" xpointer="{$xxpointer}" />
                                        
                                            ) else (
                                                <include type="proto_deep" href="{$xhref}" xpointer="{$xxpointer}" />
                                            )
                                        )    
                                           
                                }
                                </div>
                            ) else ( )
                    
                    ) else if ( ( $i/@sroshonly > '0' ) ) then (
                        if ( not ( $dedicatory eq '19' ) ) then (
                            <div xml:id="{$i/@xml:id}" corresp="{$i/@corresp}" quote="{$i/@quote}"  attest="{$i/@attest}"
                                paral="{                                    
                                    if ( $get_ritual eq '0' )	then (
                                   	 	for $x in collection("/db/apps/cab_db/cab_parals")//pair[DrYt eq $ixmlid]
                    					return
                						   normalize-space( concat( concat( '=', ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )                    				
                					) else if ( $get_ritual eq '1' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[YR eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '2' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Y eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual = ( '3', '11' ) )		then (
                                        for $x in collection("/db/apps/cab_db/cab_parals")//pair[VrS eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/YR, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '4' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[VS eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ',$x/YR, ' ', $x/VrS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '5' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Vyt eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox ) )
                						   )
                					) else ()
                            }">
                                <include type="block_shnuman19" />
                            </div>
                        ) else ()
                    (: normal includes start here:)    
                    ) else (
                        <div xml:id="{$i/@xml:id}" 
                             paral="{                                    
                                    if ( $get_ritual eq '0' )	then (
                                   	 	for $x in collection("/db/apps/cab_db/cab_parals")//pair[DrYt eq $ixmlid]
                    					return
                						   normalize-space( concat( concat( '=', ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )                    				
                					) else if ( $get_ritual eq '1' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[YR eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '2' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Y eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual = ('3', '11' ) )		then (
                                        for $x in collection("/db/apps/cab_db/cab_parals")//pair[VrS eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ' ,$x/Y, ' ', $x/YR, ' ', $x/VS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '4' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[VS eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ',$x/YR, ' ', $x/VrS, ' ', $x/Vyt ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/Vyt_aprox ) )
                						   )
                					) else if ( $get_ritual eq '5' )	then (
                	                    for $x in collection("/db/apps/cab_db/cab_parals")//pair[Vyt eq $ixmlid]
                						return
                						   normalize-space( concat( concat( '=', ' ', $x/DrYt, ' ', $x/Y, ' ' ,$x/YR, ' ', $x/VrS, ' ', $x/VS ), ' ', 
                						                            concat( '≈', ' ', $x/DrYt_aprox, ' ' ,$x/YR_aprox, ' ', $x/VrS_aprox, ' ', $x/VS_aprox ) )
                						   )
                					) else ()
                             }"
                             corresp="{$i/@corresp}" quote="{$i/@quote}" xheader="{$i/@headerPointer}" attest="{$i/@attest}">
                            {
                            for $x in $i/include
                            let $xxpointer := data( $x/@xpointer )
                            let $xxpointer_last := fn:substring( $xxpointer, fn:string-length( $xxpointer ), 1 )
                            let $xhref := data( $x/@href )
                            let $xonline := data( $x/@on_line )
                            return
                                (: prayers :)
                                if ( $xxpointer = ( "AV", "AV1", "AV2", "AV3" ) ) then (
                                         
                                        if ( ( ( $x/@gahamonly eq "1" ) and ( $gahanbar > 0 ) ) or ( ( $x/@gahamremove eq "1" ) and ( $gahanbar eq 0 ) ) or ( not( $x/@gahamonly ) and not( $x/@gahamremove ) ) ) then (
                                            <include type="prayer" href="/db/apps/cab_db/cab_rituals/blocks/prayers/AV" xpointer="{$xxpointer}" times="{$x/@times}"/> 
                                        ) else ()
                                        
                                ) else if ( $xxpointer = ( "YAV", "YAV1", "YAV2", "YAV3" ) )  then (
                                                
                                        if ( ( ( $x/@gahamonly eq "1" ) and ( $gahanbar > 0 ) ) or ( ( $x/@gahamremove eq "1" ) and ( $gahanbar eq 0 ) ) or ( not( $x/@gahamonly ) and not( $x/@gahamremove ) ) ) then (
                                            <include type="prayer" href="/db/apps/cab_db/cab_rituals/blocks/prayers/YAV" xpointer="{$xxpointer}" times="{data($x/@times)}"/>
                                        ) else ()                                               

                                ) else if ( $xxpointer = ( "YeH", "YeH1", "YeH2", "YeH3" ) ) then (
                                    <include type="prayer" href="/db/apps/cab_db/cab_rituals/blocks/prayers/YeH" xpointer="{$xxpointer}" times="{data($x/@times)}"/>

                                (: Ratus :)
                                    (: Simple Ratus :)
                                )  else if ( starts-with($xxpointer,'RatuGen') ) then (
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuGen" xpointer="{
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuGen","") ) + $numericgah
                                                                                                      
                                                return
                                                    concat( 'RatuGen', $no mod 6 + fn:floor( $no div 6 ) )
                                    }" on_line="{$xonline}" />
                                
                                )  else if ( starts-with($xxpointer,'RatuPaitiRatu') ) then (
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuPaitiRatu" xpointer="{ 
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuPaitiRatu","") ) + $numericgah
                                                                                                      
                                                return
                                                    concat( 'RatuPaitiRatu', $no mod 6 + fn:floor( $no div 6 ) )
                                    }" on_line="{$xonline}" />   
                                
                                )  else if ( starts-with($xxpointer,'RatuPaitiShort') ) then (
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort" xpointer="{ 
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuPaitiShort","") ) + $numericgah
                                                                                                      
                                                return
                                                    concat( 'RatuPaitiShort', $no mod 6 + fn:floor( $no div 6 ) )
                                    }"/>   
                                
                                    (: Complex Ratus :)
                                )  else if ( starts-with($xxpointer,'RatuLetAccAY') ) then (
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuLetAccAY" xpointer="{
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuLetAccAY","") ) + $numericgah
                                                                                                      
                                                return
                                                    concat( 'RatuLetAccAY', round-half-to-even( ($no mod 6), 1 ) + fn:floor( $no div 6 ) )
                                    }" on_line="{$xonline}" />
                                
                                )  else if ( starts-with($xxpointer,'RatuLetAccY') ) then (
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuLetAccY" xpointer="{
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuLetAccY","") ) + $numericgah
                                                                                                       
                                                return
                                                    concat( 'RatuLetAccY', round-half-to-even( ($no mod 6), 1 ) + fn:floor( $no div 6 ) )
                                    }" on_line="{$xonline}" />
                                
                                ) else if ( starts-with($xxpointer,'RatuLetDat') ) then (
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuLetDat" xpointer="{
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuLetDat","") ) + $numericgah
                                                                                                      
                                                return
                                                    concat( 'RatuLetDat', round-half-to-even( ($no mod 6), 1 ) + fn:floor( $no div 6 ) )
                                    }" on_line="{$xonline}" />
                                     
                                (: Ratu Voc :)     
                                     
                                )  else if ( starts-with($xxpointer,'RatuVoc') ) then (  
                                    <include type="block_let" href="/db/apps/cab_db/cab_rituals/blocks/RatuVoc" xpointer="{
                                        if ( starts-with($xxpointer,'RatuVoc3Short') ) then (
                                                "RatuVoc3Short"
                                        ) else (
                                                let $no := fn:number( fn:replace( $xxpointer,"RatuVoc","") ) + $numericgah
                                                                                                      
                                                return
                                                    concat( 'RatuVoc', $no mod 6 + fn:floor( $no div 6 ) )
                                        )
                                    }"/>  
                                     
                                (: Ceremonial Ratus :)
                                
                                ) else if ( starts-with($xxpointer, "RatuCer" ) ) then (
                                    <include type="block" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}" />
                                
                                (: FRAUUARANE and Shnumans :)
                               
                                ) else if ( starts-with($xxpointer, "Frauuarane_BP" ) ) then (
                                    <include type="frauuarane" href="/db/apps/cab_db/cab_rituals/blocks/Frauuarane_BP" xpointer="{if ( ( $gahanbar_ded eq 1 ) and ( $x/@xpointer_gahanbar ) ) then ( $x/@xpointer_gahanbar ) else ( $x/@xpointer )}"/> 
                                    
                                ) else if ( starts-with($xxpointer,'ShnumanAcc')  ) then (                                                                                                     <include type="block_shnumanacc" xpointer="{$xxpointer}" />
                                    
                                ) else if ( starts-with($xxpointer,'ShnumanGen')  ) then (   
                                    if ( ( $x/@shnuman_only ) and ( $x/@shnuman_only eq $dedicatory  ) ) then (
                                        
                                    ) else if ( $x/@shnuman_only ) then (  (: always Srosh :)
                                        <include type="block_shnuman19" on_line="{$xonline}" />  
                                    ) else (
                                        <include type="block_shnumangen" on_line="{$xonline}" xpointer="{$xxpointer}" />                                     
                                    )    
                                (: day, month, waz, gahanbars :)    
                                ) else if ( starts-with($xxpointer, "WazGr" ) ) then (
                                    <include type="block" href="/db/apps/cab_db/cab_rituals/blocks/WazGir" xpointer="{$xxpointer}" form="waz"/>
                                
                                ) else if ( starts-with($xxpointer,'MahGen')  ) then (                                                                                                         
                                    <include type="block" href="/db/apps/cab_db/cab_rituals/blocks/MahGen" xpointer="{$mah_gen_final}" form="mah" on_line="{$xonline}" />                                                 
                                    
                                ) else if ( starts-with($xxpointer,'MahAcc')  ) then ( 
                                    <include type="block" href="/db/apps/cab_db/cab_rituals/blocks/MahAcc" xpointer="{$mah_acc_final}" form="mah" on_line="{$xonline}" />                                          
                                                                              
                                ) else if ( starts-with($xxpointer,'RozGen')  ) then (
                                    <include type="block" href="/db/apps/cab_db/cab_rituals/blocks/RozGen" xpointer="{$roz_gen_final}" form="roz" on_line="{$xonline}" /> 
                                
                                ) else if ( starts-with($xxpointer,'RozAcc')  ) then (
                                    <include type="block" href="/db/apps/cab_db/cab_rituals/blocks/RozAcc" xpointer="{$roz_acc_final}" form="roz" on_line="{$xonline}" />
                                    
                                ) else if ( starts-with($xxpointer,'GahanbarAcc')  ) then (                                                                                                        
                                    if ( ( ( $x/@gahamonly eq "1" ) and ( $gahanbar > 0 ) ) or not( $x/@gahamonly ) ) then (
                                        <include type="block" href="{$xhref}" xpointer="{$gahanbar_acc_final}" form="gahanbar"/>
                                    ) else ()                                  
                                    
                                ) else if ( starts-with($xxpointer,'GahanbarGen')  ) then (        
                                    if ( $x/@has_alt > '0' ) then (
                                        if ( ( $gahanbar > 0 ) and ( $dedicatory eq '42') ) then (
                                            <include type="block" href="{$xhref}" xpointer="{$gahanbar_gen_final}" form="gahanbar" on_line="{$xonline}" />
                                        ) else (                        
                                            <include type="block" href="{$x/@alt_href}" xpointer="{
                                                let $no := fn:number( fn:replace( data($x/@alt_xpointer),"RatuGen","") ) + $numericgah
                                                return
                                                    concat( 'RatuGen',  $no mod 6 + fn:floor( $no div 6 ) )
                                            }" on_line="{$xonline}" />
                                        )
                                        
                                    ) else (
                                        <include type="block" href="{$xhref}" xpointer="{$gahanbar_gen_final}" form="gahanbar"/>
                                    )
                                ) else if ( starts-with($xxpointer,'SupplY' ) ) then (                                                                                                         
                                    <include type="block" href="{$xhref}" xpointer="{$xxpointer}"/>
                                
                                (: Fragards - Videvdad and Vishtasp Yasht only :)
                                ) else if ( starts-with($xhref,'Fragard')  ) then ( 
                                    if ( $xxpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                                if ( $x/@shnumandep eq '1' ) then (
                                                    if (  ('15', '17', '18', '21', '25', '35', '39', '40', '41', '43', '44', '45', '46', '47', '48', '49', '50', '52', '54', '56', '59', '58') = $dedicatory ) then (
                                                         <include type="fragard" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}"/>    
                                                    ) else ()   
                                                ) else (
                                                        <include type="fragard" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}"/>   
                                                )
                                                                         
                                    ) else (
                                                if ( $x/@shnumandep eq '1' ) then (
                                                    if (  ('15', '17', '18', '21', '25', '35', '39', '40', '41', '43', '44', '45', '46', '47', '48', '49', '50', '52', '54', '56', '59', '58') = $dedicatory ) then (
                                                         <include type="fragard_deep" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}"/>    
                                                    ) else ()   
                                                ) else (
                                                        <include type="fragard_deep" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}"/>   
                                                )
                                    )
                                    
                        
                                (: Nerangs :)
                                ) else if ( contains($xxpointer,'Nerang')  ) then (                                                                   
                                    <include type="nerang" href="{$xhref}" xpointer="{$xxpointer}"/>
                                
                                (: Headers :)
                                ) else if ( starts-with($xxpointer,'Head') ) then (
                                    <include type="header" href="{$xhref}" xpointer="{$xxpointer}"/>    
                                    
                                ) else if ( starts-with($xhref,'blueprint') ) then (    
                                    if ( $xxpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                        <include type="from_blueprint" href="{$xhref}" xpointer="{$xxpointer}"/>
                                    ) else (
                                        <include type="from_blueprint_deep" href="{$xhref}" xpointer="{$xxpointer}"/>                                     
                                    )
                                (: Static Ceremonies :)
                                
                                ) else (
                                    
                                    if ( $xxpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                            if ( $x/@shnumandep eq '1' ) then (
                                            
                                                if (  ('15', '17', '18', '21', '25', '35', '39', '40', '41', '43', '44', '45', '46', '47', '48', '49', '50', '52', '54', '56', '59', '58') = $dedicatory ) then (
                                                     <include type="proto" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}"  />    
                                                ) else ()    
                                               
                                            ) else (
                                                <include type="proto" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}"  />
                                            )
                                            
                                    ) else (
                                        if ( ( ( $x/@gahamonly eq "1" ) and ( $gahanbar > 0 ) ) or ( ( $x/@gahamonly eq "-1" ) and ( $gahanbar eq 0  ) ) or not( $x/@gahamonly ) ) then (
                                           if ( $x/@gah_dep ) then (
                                               if ( ( $dedicatory eq "54" ) or ( $dedicatory eq "51" ) ) then (
                                                        <include type="proto_deep" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}" />
                                               ) else if (
                                                   ( ( $x/@gah_dep eq "1" ) and ( ( $gah_u eq "4") or ( $gah_u eq "0" ) ) ) or
                                                   ( ( $x/@gah_dep eq "2" ) and ( $gah_u eq "1") ) or
                                                   ( ( $x/@gah_dep eq "3" ) and ( $gah_u eq "2") ) 
                                                  ) then (
                                                        <include type="proto_deep" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}" />
                                               ) else ()
                                           ) else (
                                               
                                                if ( $x/@shnumandep eq '1' ) then (
                                            
                                                    if (  ('15', '17', '18', '21', '25', '35', '39', '40', '41', '43', '44', '45', '46', '47', '48', '49', '50', '52', '54', '56', '59', '58') = $dedicatory ) then (
                                                        <include type="proto_deep" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}" />   
                                                    ) else ()   
                                                ) else (
                                                    <include type="proto_deep" href="{$xhref}" xpointer="{$xxpointer}" on_line="{$xonline}" />
                                                )
 
                                           )
                                        ) else ()

                                    )
                                )
                        }
                        </div>
                    )

(: II. Create ceremony based on blueprint :)
return
    <TEI>
      <text> 
        {
            for $i in $ceremony_bp
            let $ixmlid := data( $i/@xml:id )
                return
            <div id="{$ixmlid}" class="div_gen tabcontent">
                {if ( data($i/@xheader) ) then (
                    <a href="header.html?stanza_id={$ixmlid}&amp;stanza_location={$get_ritual}" target="_blank">
                        <p class="stanza_width header_red">
                            {(for $z in collection( $header_ritual )//ab2[@xml:id eq $i/@xheader]
                                return 
                                    $z)}
                        </p>
                    </a>
                ) else ()}
                
                <h4 style="display:inline-block;font-weight:bold;">{$ixmlid}</h4>
                
                {if ( data($i/@attest) ) then (
                    <h5 style="display:inline-block">{ if ( data($i/@attest) eq "supl" ) then ( "(Suppl.)" ) else if ( data($i/@attest) eq "ext" ) then ( "(Exp.)" ) else () }</h5>
                ) else ()}
                
                {if ( data($i/@corresp) ) then (
                    <h5 style="display:inline-block">({data($i/@corresp)})</h5>
                ) else ()}

                {if ( data($i/@quote) ) then (
                    <h5 style="display:inline-block">[{data($i/@quote)}]</h5>
                ) else ()}

                {if ( string-length(data($i/@paral)) > 3 ) then (
                    <h5 style="display:inline-block"><prl>{
                      if ( string-length( substring-after( $i/@paral, '≈' ) ) < 3 ) then (
                          substring-before( $i/@paral, '≈' )
                      ) else if ( string-length( substring-before( $i/@paral, '≈' ) ) < 3 ) then (
                          substring-after( $i/@paral, '=' )
                      ) else (
                          data($i/@paral)
                      )
                    }</prl></h5>
                ) else ()}

                <div class="btn-stanza-options">
                        <button class="btn btn-tertiary option_button_third" style="text-align:left !important" type="button" title="Avestan Digital Archive"
                            onclick="GotoADA('{$ixmlid}', '{data($i/@corresp)}')">
                            <span class="glyphicon glyphicon-file"></span>
                        </button>
                        <button class="btn btn-success option_button" style="text-align:left !important" title="Stanza Analysis"
                            onclick="GetStanzaInfo('{$ixmlid}', '{data($get_ritual)}', '{data($i/@corresp)}' )">
                            <span class="glyphicon  btn-secondary glyphicon-th"></span>
                        </button>
                </div>                
                
                <div class="stanza_width" >
                {
                    for $y in $i/include
                    let $ytype := data( $y/@type )
                    let $yhref := data( $y/@href )
                    let $yonline := data( $y/@on_line )
                    let $yxpointer := data ( $y/@xpointer )
                    let $yxpointer_last := fn:substring( $yxpointer, fn:string-length( $yxpointer ), 1 )
                    return
                        if ( $ytype eq "proto" ) then (
                                     <p class="{if ($yonline) then ( $yonline ) else ( )}">
                                    {(for $z in collection( $yhref )//div/id($yxpointer)
                                    return 
                                        $z)}
                                    </p>
                              
                            
                        ) else if ( $ytype eq "proto_deep" ) then (
                            
                                    <p class="{$yonline}">
                                    {(for $z in collection( $yhref )//ab/id($yxpointer)
                                        return 
                                            $z)}
                                    </p>        
                            
                        ) else if ( $ytype eq "prayer" ) then (
                            <p>
                                <p>
                                {(for $z in collection( $yhref )//ab[@xml:id eq $yxpointer]
                                return 
                                    $z)} 
                                    {if (data($y/@times)) then ( <note class="times">[ {data($y/@times)}x ]</note>) else ()}
                                </p>
                            </p>
                            
                        ) else if ( $ytype eq "block_let" ) then (
                        
                            <p class="{if ($yonline) then ( $yonline ) else ( )}">
                            <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )}">{"[Gāh] "}</span>
                            {(for $z in collection( $yhref )//ab[@xml:id eq $yxpointer]
                            return 
                                $z)}   
                            </p>

                        ) else if ( $ytype eq "block" ) then ( 

                            <p class="{if ($yonline) then ( $yonline ) else ( )}">
                            {
                                if  ( data($y/@form) eq "roz") then (
                                    <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )}">{"[Rōz] "}</span>
                                
                                ) else if ( ( data($y/@form) eq "mah") and ( $gahanbar_nomonth eq 0 ) ) then (
                                    <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )} month">{"[Māh] "}</span>
                        
                                ) else if  ( data($y/@form) eq "gahanbar") then (
                                    <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )}">{"[Gāhānbār] "}</span>
                
                                ) else ( )                            
                            }
                                
                            {(for $z in collection( $yhref )//ab[@xml:id eq $yxpointer]
                                        return 
                                        $z)[1]}
                            </p>
                            
                        ) else if ( $ytype eq "block_shnumangen" ) then (
                            <p class="{if ($yonline) then ( $yonline ) else ( )}">
        
                            <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )}">{"[Šnūman] "}</span>
                                {if ( $moveable_shnuman eq 0 ) then (
                                    $shnumangen    
                                ) else (
                                    
                                    if ( $yxpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                                                     
                                        for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")/div/div[@xml:id eq $yxpointer]/*
                                        let $ixpointer := $i/@xpointer
                                        return 
                                            if ( starts-with($ixpointer, "RatuShnumanGen" ) ) then (
                                                let $no := fn:number( fn:replace( $ixpointer,"RatuShnumanGen","") ) + $numericgah 
                                                let $ratu_shnuman_gen := fn:concat("RatuShnumanGen", $no mod 6 + fn:floor( $no div 6 ) )
                                                
                                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")/div/ab[@xml:id eq $ratu_shnuman_gen]
                                                return
                                                    $x
                                            ) else if ( starts-with($ixpointer, "RatuPaitiShort" ) ) then (
                                                let $no := fn:number( fn:replace( $ixpointer,"RatuPaitiShort","") ) + $numericgah 
                                                let $ratu_paiti_short := fn:concat("RatuPaitiShort", $no mod 6 + fn:floor( $no div 6 ) )
                                                
                                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")/div/ab[@xml:id eq $ratu_paiti_short]
                                                return
                                                    $x
                                            ) else if ( starts-with($ixpointer, "GahanbarGen" ) ) then (
                                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")/div/ab[@xml:id eq $gahanbar_gen_final]
                                                return         
                                                    $x      
                                            ) else (
                                                $i    
                                            )
                                        ) else (
                                            for $ii in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")/div/div/ab[@xml:id eq $yxpointer]
                                            return
                                                $ii
                                        )
                                    
                                )}
                            </p>                           
                        
                        ) else if ( $ytype eq "block_shnumanacc" ) then (
                            <p>
                            <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )}">{"[Šnūman] "}</span>
                            {if ( $moveable_shnuman eq 0 ) then (
                                $shnumanacc    
                            ) else (
                                if ( $yxpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                            
                                    for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanAcc")//div[@xml:id eq $yxpointer]/*
                                    let $ixpointer := data( $i/@xpointer )
                                    return 
                                        if ( starts-with($ixpointer, "RatuShnumanAcc" ) ) then (
                                            let $no := fn:number( fn:replace( $ixpointer,"RatuShnumanAcc","") ) + $numericgah 
                                            let $ratu_shnuman_acc := fn:concat("RatuShnumanAcc", $no mod 6 + fn:floor( $no div 6 ) )
                                            
                                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanAcc")//ab[@xml:id eq $ratu_shnuman_acc]
                                            return
                                                $x
                                                
                                        ) else if ( starts-with($ixpointer, "RatuAcc" ) ) then (
                                            let $no := fn:number( fn:replace( $ixpointer,"RatuAcc","") ) + $numericgah 
                                            let $ratu_acc := fn:concat("RatuAcc", $no mod 6 + fn:floor( $no div 6 ) )
                                            
                                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuAcc")//ab[@xml:id eq $ratu_acc]
                                            return
                                                $x
                                                
                                        ) else if ( starts-with($ixpointer, "GahanbarAcc" ) ) then (
                                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarAcc")//ab[@xml:id eq $gahanbar_acc_final]
                                            return
                                                $x      
                                        ) else (
                                            $i    
                                        )
                            
                            
                            	) else ()
                            
                            )}
                            </p>   
                            
                        ) else if ( $ytype eq "block_shnuman19" ) then (
                            <p>  
                            <span class="note red">{"[Šnūman] "}</span>
                                {$shnuman19}
                            </p>     
                        ) else if ( $ytype eq "nerang" ) then (
                            <p class="nerang_red">
                            {(for $z in collection( $yhref )//ab1[@xml:id eq $yxpointer]
                            return 
                                $z)}
                            </p>                                
                                
                        ) else if ( $ytype eq "from_blueprint" ) then (        
                            <p>
                            {for $z in collection( $yhref )//div[@xml:id eq $yxpointer]
                            return 
                                $z}
                            </p>    
                            
                        ) else if ( $ytype eq "from_blueprint_deep" ) then (        
                            <p>
                            {for $z in collection( $yhref )//div/ab[@xml:id eq $yxpointer]
                            return 
                                $z}
                            </p>                             
                            
                        ) else if ( $ytype eq "header" ) then (
                            <p class="header_red">
                            {(for $z in collection( $yhref )/div//ab2[@xml:id eq $yxpointer]
                            return 
                                $z)}
                            </p>                                
                                
                                
                        ) else if ( $ytype eq "frauuarane" ) then (
                            let $args := for $z in collection( $yhref )//div[@xml:id eq $yxpointer]/*
                                         return
                                            $z
                                            
                            return
                                <div type="Frauuarane" xml:id="{$yxpointer}">
                                    <span class="frauuarane note red">{"[Frauuarāne] "}</span>
                                    <p >
                                    {
                                        
                                    for $z in $args
                                    let $z_last := fn:substring( data($z/@xpointer), fn:string-length( data($z/@xpointer) ), 1 )
                                    return
                                        if ( data($z/@type) eq "block" ) then (
                                            <p >
                                            {
                                                for $zy in collection( data($z/@href) )//ab/id(data($z/@xpointer))
                                                return
                                                    $zy
                                            }
                                            </p>    
                                        
                                        ) else if ( data($z/@type) eq "block_ratu" ) then (
                                            <p >
                                            <span class="note red">{"[Gāh] "}</span>
                                            {
                                                let $no := fn:number( fn:replace( data($z/@xpointer),"RatuFra","") ) + $numericgah 
                                                let $ratu_fra := fn:concat("RatuFra", $no mod 6 + fn:floor( $no div 6 ) )                                        
                                                for $zy in collection( data($z/@href) )//ab/id($ratu_fra)
                                                return
                                                    $zy
                                            }   
                                            </p>                                            

                                            
                                        ) else if ( data($z/@type) eq "block_shnumangen" ) then (
(: aci :)
                                            <p class="{if ($yonline) then ( $yonline ) else ( )}">
                        
                                            <span class="note {if ($yonline) then ( "red_nofloat" ) else ( "red" )}">{"[Šnūman] "}</span>
                                                {if ( $moveable_shnuman eq 0 ) then (
                                                    $shnumangen    
                                                ) else (
                                                    
                                                    if ( $z_last = ( '0', '1','2','3','4','5','6','7','8','9' ) )  then (
                                                                                     
                                                        for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")/div/div[@xml:id eq $z/@xpointer]/*
                                                        let $ixpointer := data( $i/@xpointer )
                                                        return 
                                                            if ( starts-with($ixpointer, "RatuShnumanGen" ) ) then (
                                                                let $no := fn:number( fn:replace( $ixpointer,"RatuShnumanGen","") ) + $numericgah 
                                                                let $ratu_shnuman_gen := fn:concat("RatuShnumanGen", $no mod 6 + fn:floor( $no div 6 ) )
                                                                
                                                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")/div/ab[@xml:id eq $ratu_shnuman_gen]
                                                                return
                                                                    $x
                                                            ) else if ( starts-with($ixpointer, "RatuPaitiShort" ) ) then (
                                                                let $no := fn:number( fn:replace( $ixpointer,"RatuPaitiShort","") ) + $numericgah 
                                                                let $ratu_paiti_short := fn:concat("RatuPaitiShort", $no mod 6 + fn:floor( $no div 6 ) )
                                                                
                                                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")/div/ab[@xml:id eq $ratu_paiti_short]
                                                                return
                                                                    $x
                                                            ) else if ( starts-with($ixpointer, "GahanbarGen" ) ) then (
                                                                for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")/div/ab[@xml:id eq $gahanbar_gen_final]
                                                                return         
                                                                    $x      
                                                            ) else (
                                                                $i    
                                                            )
                                                        ) else (
                                                            for $ii in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")/div/div/ab[@xml:id eq $z/@xpointer]
                                                            return
                                                                $ii
                                                        )
                                                    
                                                )}
                                            </p>                           


                                        ) else if ( data($z/@type) eq "block_shnumanacc" ) then (
                                            <p >                                  
                                                <span class="note red">{"[Šnūman] "}</span>
                                                {$shnumanacc}
                                            </p>
                                        
                                        ) else (
                                         
                                                $z
                                        ) 
                                    }
                                    </p>
                                </div>    
                 
                        ) else if ( $ytype eq "fragard" ) then (

                                    let $fragard := (for $z in collection( $yhref )/div//div[@xml:id eq $yxpointer]
                                                    return 
                                                        $z)
                                     
                                    return
                                        <p n="{data($fragard/@n)}" xml:id="{data($fragard/@xml:id)}" class="{if ($yonline) then ( $yonline ) else ( )}">
                                        {
                                            for $i in $fragard/*
                                            return 
                                               if ( data($i/@type) eq 'prayer') then (
                                                   for $ii in collection ( data($i/@href) )/div/ab[@xml:id eq $i/@xpointer]
                                                   return
                                                       $ii
                                               ) else (
                                                    $i     
                                               )
                                        }
                                        </p>
                                        
                        ) else if ( $ytype eq "fragard_deep" ) then (

                                    
                                    let $fragard := (for $z in collection( $yhref )//ab[@xml:id eq $yxpointer]
                                                    return 
                                                        $z)
                                     
                                    return
                                        <p n="{data($fragard/@n)}" xml:id="{data($fragard/@xml:id)}" class="{if ($yonline) then ( $yonline ) else ( )}">
                                        {
                                            $fragard
                                        }
                                        </p>
                                        
                        ) else (
                            
                            <p>
                                <p>
                                {(for $z in collection( $yhref )/div/ab[@xml:id eq $yxpointer]
                                return 
                                    $z)} 
                                </p>
                            </p>
                        )
                }    
                </div>
            </div>
        } 
      </text>
    </TEI>