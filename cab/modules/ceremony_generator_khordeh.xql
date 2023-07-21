xquery version "3.1";

declare namespace functx = "http://www.functx.com";
declare function functx:containsall
  ( $arg as xs:string? ,
    $searchStrings as xs:string* )  as xs:boolean {

   some $searchString in $searchStrings
   satisfies contains($arg,$searchString)
 } ;

declare variable $ceremony  := request:get-parameter( 'ceremony', '0' );
declare variable $type      := request:get-parameter( 'type', '0' );

declare variable $ceremony_type := 
        switch ($ceremony) 
            case "0" return "Yasht"
            case "1" return "Niyayesh"
            case "5" return "NKB"
                default return 0;
                
declare variable $ceremony_version :=
        switch ($type)
            case "1" return "Iranian"
            case "2" return "Indian"
                default return 0;

declare variable $gah_u := request:get-parameter( 'gah'  , '0' );                
(:   :declare variable $cerem_nr := request:get-parameter( 'dedicatory'  , '0' ); :)
(:  :declare variable $dedicatory := request:get-parameter( 'shnuman', '0' ); :)
 
declare variable $ceremony_location := 
        switch ($ceremony)      
            case "0" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Prayers/",  $ceremony_version, "/AV" )
            case "1" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Prayers/",  $ceremony_version, "/YAV" )         
            case "2" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Baj/",       $ceremony_version, "/BajGomK" )
            case "3" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Baj/",       $ceremony_version, "/BajNanX" )
            case "4" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Baj/",       $ceremony_version, "/BajNanXpriests" )
            case "5" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/",   $ceremony_version, "/NerKB"  )
            case "6" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",    $ceremony_version, "/SrB" )
            case "7" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Niyayesh/", $ceremony_version, "/NyXwar"  )
            case "8" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Niyayesh/", $ceremony_version, "/NyMihr"  )
            case "9" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Niyayesh/", $ceremony_version, "/NyMah" )
            case "10" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Niyayesh/", $ceremony_version, "/NyAtash" )                                   case "11" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/",    $ceremony_version, "/YtOhr" )
            case "12" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/",    $ceremony_version, "/YtArW" )
            case "13" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/",    $ceremony_version, "/YtSrH" )
            case "14" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/",    $ceremony_version, "/YtSr" )
            case "15" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Gah/",      $ceremony_version, "/GUsh" )
            case "16" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Gah/",      $ceremony_version, "/GHaw" )
            case "17" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Gah/",      $ceremony_version, "/GRap" )
            case "18" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Gah/",      $ceremony_version, "/GUz" )
            case "19" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Gah/",      $ceremony_version, "/GEbsr" )
            
            case "20" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",   $ceremony_version, "/NamStPz" )
            case "21" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/NamSt", "/", $ceremony_version )
            case "22" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",   $ceremony_version, "/NamStPh" )
            
           (: case "23" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",     $ceremony_version, "/PI" ) :)
            case "24" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",     $ceremony_version, "/HB" )
            case "25" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",     $ceremony_version, "/NCN" )
            case "26" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/",     $ceremony_version, "/VH" )
            case "27" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/",     $ceremony_version, "/YtHom" )
            case "28" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/",     $ceremony_version, "/YtWan" )    
            
            (: Non- Farziyat:)
            case "100" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/", $ceremony_version, "/NerNaxC" )
            case "101" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/", $ceremony_version, "/NerSB" )
            case "102" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/", $ceremony_version, "/NerAtseKPz" )
            case "103" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/", $ceremony_version, "/NerAtseKPa" )
            
            case "104" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Niyayesh/", $ceremony_version, "/MayaYt"  )
            (: see 150 below :)
            
            
            case "105" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/AD"  )
            case "106" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/AGahambar"  )
            case "107" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/AGatha"  )
            case "108" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/ARap"  )
            case "109" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/ANogNavar"  )
            case "110" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/AfrinRap"  ) (: missing :)
            case "111" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/CiBuPz"  )
            case "112" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Afrin/", $ceremony_version, "/CiBuPa"  )
            
            (: Yasht TODO :)
            case "113" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/", $ceremony_version, "/YtWahr" )
            case "114" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/", $ceremony_version, "/YtAmSp" )
            case "115" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Yasht/", $ceremony_version, "/YtHor" )
            
            case "115" return concat ( "", $ceremony_version, "" )
            case "116" return concat ( "", $ceremony_version, "" )
            
            
            case "117" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/SpAoiPz" )
            case "118" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/SpAoiPa" )
            case "119" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/PaNamDadarUrmazdPz" )
            case "120" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/PaNamDadarUrmazdPa" )
            case "121" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/NamXPz" )
            case "122" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/NamXPa" )
            case "123" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/NamUrmazdPz" )
            case "124" return concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Spasdarih/",     $ceremony_version, "/NamUrmazdPa" )
            case "125" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/", $ceremony_version, "/DoaZiyanMardoman")
            case "126" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/", $ceremony_version, "/KardeSrosh")
            case "127" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Other/", $ceremony_version, "/KardeSroshRawan")            
            (: See a few added above :)
            case "150" return  concat( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Niyayesh/",     $ceremony_version, "/NyAban" )
            
            (: Misc :)
            case "200" return "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/Misc/NerBarsomCidan"
            case "201" return "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/Misc/NerJamDuxtan"
            case "202" return "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/Misc/NerZurGereftan"
            case "203" return "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/Misc/NerWaras"
            
            case "300" return concat ( "/db/apps/cab_db/cab_rituals/blueprint/Khordeh_rituals/Nerang/", $ceremony_version, "/NerYtArWIr_Parsi/")
            
                default return 0;

declare variable $shnumanfixed :=
    switch ( $ceremony )
        case "0" return "0"
        case "1" return "0"
        case "2" return "0"
        case "3" return "0"
        case "4" return "X1"
        case "5" return "0"
        case "6" return "XA19"
        case "7" return "XA11"
        case "8" return "XA16"
        case "9" return "XA12"
        case "10" return "???"
        case "11" return "XA1"
        case "12" return "XA3"
        case "13" return "19"
        case "14" return "19"
        case "15" return "XA70"
        case "16" return "XA16"
        case "17" return "XA68"
        case "18" return "XA33"
        case "19" return "XA69"
        case "20" return "0"
        case "21" return "0"
        case "22" return "0"
        case "23" return "0"
        case "24" return "0"
        case "25" return "0"
        case "26" return "0"
        case "27" return "XA34"
        case "28" return "XA36"
        (: non-f :)
        case "100" return "XA19"
        case "101" return "0"
        case "102" return "0"
        case "103" return "0"
        case "104" return "XA66"
        case "105" return "XA60"
        case "106" return "XA42"
        case "107" return "XA40"
        case "108" return "XA39"
        case "109" return "XA1"
        case "110" return "0"
        case "111" return "0"
        case "112" return "0"
        case "113" return "XA22"
        case "114" return "XA71"
        case "115" return "XA22"
        case "116" return "0"
        case "117" return "0"
        case "118" return "0"
        case "119" return "0"
        case "120" return "0"
        case "121" return "0"
        case "122" return "0"
        case "123" return "0"
        case "124" return "0"
        case "125" return "XA71"
        case "126" return "XA19"
        case "127" return "XA19"
        (: misc :)
        case "150" return "XA10"
        (: added later:)
        case "200" return "0"
        case "201" return "0"
        case "202" return "0"
        case "203" return "0"
            default return "0";
                
let $shgen := concat( "ShnumanGen", data($shnumanfixed) )
let $shacc := concat( "ShnumanAcc", data($shnumanfixed) )

let $numericgah := fn:number( $gah_u )

let $shnumangen := for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/div[data(@xml:id) eq $shgen]/*
                    return 
                        if ( contains($i/@xpointer, "RatuShnumanGen" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                            {
                            let $no := fn:number( fn:replace( data($i/@xpointer),"RatuShnumanGen","") ) + $numericgah 
                            let $ratu_shnuman_gen := fn:concat("RatuShnumanGen", $no mod 6 + fn:floor( $no div 6 ) )
                            
                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")/div/ab[data(@xml:id) eq $ratu_shnuman_gen]
                            return
                                $x
                            }
                            </p>
                        ) else if ( contains($i/@xpointer, "RatuPaitiShort" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                            {    
                            let $no := fn:number( fn:replace( data($i/@xpointer),"RatuPaitiShort","") ) + $numericgah 
                            let $ratu_paiti_short := fn:concat("RatuPaitiShort", $no mod 6 + fn:floor( $no div 6 ) )
                            
                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")/div/ab[data(@xml:id) eq $ratu_paiti_short]
                            return
                                $x
                            }
                            </p>
                        ) else if ( contains($i/@xpointer, "GahanbarGen" ) ) then (
                            <p>
                                <span class="note red">{"[Gāhānbar] "}</span>
                            {
                            let $no := fn:number( fn:replace( data($i/@xpointer),"GahanbarGen","") ) + $numericgah 
                            let $ratu_paiti_short := fn:concat("GahanbarGen", $no mod 6 + fn:floor( $no div 6 ) )
                            
                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")/div/ab[data(@xml:id) eq $ratu_paiti_short]
                            return
                                $x
                            }
                            </p>
                        ) else (
                            $i    
                        )
                        
let $shnumanacc := for $i in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanAcc")//div/div[data(@xml:id) eq $shacc]/*
                    return 
                        if ( contains($i/@xpointer, "RatuShnumanAcc" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                            {
                            let $no := fn:number( fn:replace( data($i/@xpointer),"RatuShnumanAcc","") ) + $numericgah 
                            let $ratu_shnuman_acc := fn:concat("RatuShnumanAcc", $no mod 6 + fn:floor( $no div 6 ) )
                            
                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanAcc")/div/ab[data(@xml:id) eq $ratu_shnuman_acc]
                            return
                                $x
                            }
                            </p>
                        ) else if ( contains($i/@xpointer, "RatuPaitiShort" ) ) then (
                            <p>
                                <span class="note red">{"[Gāh] "}</span>
                            {                            
                            let $no := fn:number( fn:replace( data($i/@xpointer),"RatuPaitiShort","") ) + $numericgah 
                            let $ratu_paiti_short := fn:concat("RatuPaitiShort", $no mod 6 + fn:floor( $no div 6 ) )
                            
                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")/div/ab[data(@xml:id) eq $ratu_paiti_short]
                            return
                                $x
                            }
                            </p>
                                
                        ) else if ( contains($i/@xpointer, "GahanbarAcc" ) ) then (
                            <p>
                                <span class="note red">{"[Gāhānbar] "}</span>
                            {                            
                            let $no := fn:number( fn:replace( data($i/@xpointer),"GahanbarAcc","") ) + $numericgah 
                            let $ratu_paiti_short := fn:concat("GahanbarAcc", $no mod 6 + fn:floor( $no div 6 ) )
                            
                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarAcc")/div/ab[data(@xml:id) eq $ratu_paiti_short]
                            return
                                $x
                            }
                            </p>
                                
                        ) else (
                            $i    
                        )                        

let $ritual :=  <TEI text="{data($ceremony_location)}">
                <text> 
                {        
                    for $i in collection( $ceremony_location )//div/div/div
                    return
                        <div id="{data($i/@xml:id)}" class="div_gen tabcontent">
                            <h4 style="display:inline-block;font-weight:bold;">{data($i/@xml:id)}</h4>
                
                            {if ( data($i/@corresp) ) then (
                                <h5 style="display:inline-block">({data($i/@corresp)})</h5>
                            ) else ()}
            
                            {if ( data($i/@quote) ) then (
                                <h5 style="display:inline-block">[{data($i/@quote)}]</h5>
                            ) else ()}

                            <div>
                                <span>
                                    <button class="btn btn-success option_button" style="display:none"
                                        onclick="GetStanzaInfo('{data($i/@xml:id)}','{data($i/@corresp)}')">
                                        <span class="glyphicon  btn-secondary glyphicon-th"></span>
                                    </button>
                                    <button class="btn btn-tertiary option_button_second" type="button"
                                        onclick="GotoADAKhordeh('{data($i/@corresp)}')">
                                        <span class="glyphicon glyphicon-file"></span>
                                    </button>
                                </span>
                            </div>                                    

                            {
                                for $j in $i/*
                                return
                                    if ( contains( $j/@href, "Frauuarane_BP" ) ) then (
                                        <div type="Frauuarane" xml:id="{data($j/@xpointer)}">
                                            <span class="frauuarane note red">{"[Frauuarāne] "}</span>
                                            <p class="stanza_width">
                                            {
                                                let $args := for $z in collection( data($j/@href) )//div/div[data(@xml:id) eq $j/@xpointer]/*
                                                                return
                                                                    $z
                                            
                                                
                                                for $z in $args
                                                return
                                                    if ( data($z/@type) eq "block" ) then (
                                                        <p >
                                                            {for $zy in collection( data($z/@href) )//div/ab[data(@xml:id) eq $z/@xpointer]
                                                            return
                                                                $zy}
                                                        </p>    
                                                    
                                                    ) else if ( data($z/@type) eq "block_ratu" ) then (
                                                        <p>
                                                        <span class="note red">{"[Gāh] "}</span>
                                                        {
                                                            let $no := fn:number( fn:replace( data($z/@xpointer),"RatuFra","") ) + $numericgah 
                                                            let $ratu_fra := fn:concat("RatuFra", $no mod 6 + fn:floor( $no div 6 ) ) 
                                                            
                                                            for $zy in collection( data($z/@href) )//div[data(@xml:id) eq $ratu_fra]
                                                            return
                                                                $zy
                                                        }   
                                                        </p>                                            
            
                                                    ) else if ( data($z/@type) eq "block_nerang" ) then (
                                                            <p class="nerang_red">
                                                            {for $ii in collection ( data($z/@href) )//div/ab1[data(@xml:id) eq $z/@xpointer]
                                                            return
                                                               $ii}
                                                            </p> 
                                                    ) else if ( data($z/@type) eq "block_shnumangen" ) then (
                                                    
                                                        <p>
                                                            <span class="note red">{"[Šnūman] "}</span>
                                                            {$shnumangen}
                                                        </p>

                                                    ) else if ( data($z/@type) eq "block_shnumanacc" ) then (

                                                        <p>
                                                            <span class="note red">{"[Šnūman] "}</span>
                                                            {$shnumanacc}
                                                        </p>
                                                    
                                                    ) else (
                                                        <p class="stanza_width">                                                         
                                                            {$z}
                                                        </p>
                                                    ) 
                                            }
                                            </p>
                                        </div>
                                        
                                    ) else if ( contains( (data($j/@href)), "nerang") ) then (    
                                        for $ii in collection ( data($j/@href) )//div/ab1[data(@xml:id) eq $j/@xpointer]
                                            return
                                            <p class="nerang_red">     
                                               {$ii}
                                            </p>
                                    
                                    ) else if ( contains($j/@xpointer,'ShnumanAcc') ) then (
                                        if ( not( $shnumanfixed eq "0" ) and 
                                             ( contains( $j/@xpointer, $shnumanfixed ) )
                                        ) then ( (: for the rare cases where this is not inside a frauuarane :)
                                            <p>
                                                <span class="note red">{"[Šnūman] "}</span>
                                                    {$shnumanacc}
                                            </p>
                                        
                                        
                                        ) else if ( functx:containsall( 
                                                    fn:substring( $j/@xpointer, fn:string-length( $j/@xpointer ), 1 ), 
                                                                 ( '0', '1','2','3','4','5','6','7','8','9' ) ) ) then (
                                            <p>
                                                <span class="note red">{"[Šnūman] "}</span>
                                                {
                                                    for $zy in collection( data($j/@href) )//div[data(@xml:id) eq $j/@xpointer]
                                                        return
                                                            $zy  
                                                }
                                            </p>                                        
                                        ) else (
                                            <p>
                                                <span class="note red">{"[Šnūman] "}</span>
                                                {
                                                    for $zy in collection( data($j/@href) )//ab[data(@xml:id) eq $j/@xpointer]
                                                        return
                                                            $zy  
                                                }
                                            </p>                                             
                                        )     
                                      
                                    ) else if ( contains($j/@xpointer,'ShnumanGen') ) then ( 
                                        if ( not( $shnumanfixed eq "0" ) and 
                                             ( contains( $j/@xpointer, $shnumanfixed ) )
                                        ) then ( (: for the rare cases where this is not inside a frauuarane :)
                                            <p>
                                                <span class="note red">{"[Šnūman] "}</span>
                                                    {$shnumangen}
                                            </p>
                                        
                                        
                                        ) else if ( functx:containsall( 
                                                    fn:substring( $j/@xpointer, fn:string-length( $j/@xpointer ), 1 ), 
                                                                 ( '0', '1','2','3','4','5','6','7','8','9' ) ) ) then (
                                            <p>
                                                <span class="note red">{"[Šnūman] "}</span>
                                                {
                                                    for $zy in collection( data($j/@href) )//div[data(@xml:id) eq $j/@xpointer]
                                                        return
                                                            $zy  
                                                }
                                            </p>                                        
                                        ) else (
                                            <p>
                                                <span class="note red">{"[Šnūman] "}</span>
                                                {
                                                    for $zy in collection( data($j/@href) )//ab[data(@xml:id) eq $j/@xpointer]
                                                        return
                                                            $zy  
                                                }
                                            </p>                                             
                                        )                                        
                                        
                                    ) else if ( data($j/@type) eq "block_ratu" ) then (
                                        <p>
                                            <span class="note red">{"[Gāh] "}</span>
                                            {
                                                let $no := fn:number( fn:replace( data($j/@xpointer),"RatuFra","") ) + $numericgah 
                                                let $ratu_fra := fn:concat("RatuFra", $no mod 6 + fn:floor( $no div 6 ) )                                        
                                                for $zy in collection( data($j/@href) )//div[data(@xml:id) eq $ratu_fra]
                                                    return
                                                        $zy
                                            }   
                                        </p>                                            
            
                                    ) else if ( contains($j/@href,'prayer') ) then (
                                        <p>
                                            <p>
                                            {(for $z in collection( data($j/@href) )/div/ab[data(@xml:id) eq $j/@xpointer]
                                            return 
                                                $z)} 
                                                {if (data($j/@times)) then ( <note class="times">[ {data($j/@times)}x ]</note>) else (
                                                    <note class="prayer_space" />
                                                )}
                                            </p>
                                        </p>
                            
                                        
                                    ) else if ( $j/@href ) then (
                                        for $ii in collection ( data($j/@href) )//div/ab[data(@xml:id) eq $j/@xpointer]
                                            return
                                            <p class="stanza_width">       
                                               {$ii}
                                            </p>
                                    ) else if ( $j/@gah_dep ) then (
                                        
                                        if ( ( data($j/@gah_dep) eq "1" ) and ( $gah_u eq "0") ) then (
                                            <p class="stanza_width">   
                                                {$j}
                                            </p> 
                                        ) else if ( ( data($j/@gah_dep) eq "2" ) and ( $gah_u eq "1") ) then (
                                            <p class="stanza_width">   
                                                {$j}
                                            </p>     
                                        ) else if ( ( data($j/@gah_dep) eq "3" ) and ( $gah_u eq "2") ) then (
                                            <p class="stanza_width">   
                                                {$j}
                                            </p> 
                                        ) else ()
                                            
                                    ) else (
                                        <p class="stanza_width">   
                                            {$j}
                                        </p>
                                    )
                                    
                                    
                            }
                        
                        </div>
                }
                </text>
                </TEI>
            
                    
return
    $ritual