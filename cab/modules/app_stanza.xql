xquery version "3.1";

module namespace app_stanza="https://ada.geschkult.fu-berlin.de/cab//templates_stanza";

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="https://ada.geschkult.fu-berlin.de/cab//config" at "config.xqm";
import module namespace functx="http://www.functx.com" at "app_functions.xqm";

declare function local:getGlossary( $arg_stanza as xs:string, $arg_id2 as xs:string, $arg_n as xs:string, $arg_word as xs:string ) as xs:string {
    let $stanza := $arg_stanza
    let $n := $arg_n
    let $word := $arg_word
    let $second_id := $arg_id2

    let $word_for_search   := substring( data($word), 0, string-length(data($word)) )
    let $stanza_for_search := concat( $stanza, '.', $n , ';')
    let $second_for_search := concat( $second_id, '.', $n , ';')

    let $exact_value := for $x in collection("/db/apps/cab_db/cab_words")//entry[word eq $word_for_search]
                            for $y in $x//pair[contains(id,$stanza_for_search) or contains(id,$second_for_search)]
                            return
                                $x

    let $value := if ( $exact_value ) then ( $exact_value ) else (
                    for $x in collection("/db/apps/cab_db/cab_words")//entry[word eq $word_for_search]
                    return $x)


    let $result := if ($value)  then (
                    let $pair: = for $i in $value//pair[contains(id,$stanza_for_search)]
                    return
                        $i
                    
                    return
                        if ( $pair ) then (
                            $pair    
                        ) else (
                            (for $i in $value//pair
                            return 
                                $i)[1]
                        )
                ) else ()
                
    let $value_gloss1 := for $x in collection("/db/apps/cab_db/cab_glossary")//entry[@CABlemma eq $value/CABlemma1]
        return
            $x
        
    let $value_gloss2 := for $x in collection("/db/apps/cab_db/cab_glossary")//entry[@CABlemma eq $value/CABlemma2]
        return
            $x        
        
    let $verb_gloss_stem := for $x in $value_gloss1//stem[data(form/orth)[1] eq data($value/word)]
        return
            $x
        
    let $verb_gloss_stem_2 := if ( data($value[1]/realForm) ) then (
                            for $x in $value_gloss1//stem[form/orth eq data($value/realForm)]
                            return
                            $x
                        ) else ()
        
    return
    <div>
       {
        if ( ( $verb_gloss_stem ) and not(contains(data($value/morph/pair/tmesis_id), $stanza_for_search)) ) then  (      (: check for verb :)
            <div>      
                <p>{data($value_gloss1/@CABlemma)}&#160;{for $x in $value_gloss1/lemma[data(stem/form/orth)[1] eq data($value/word)]
                                 return
                                     data($x/@subLemma)
                                 }&#160;{data($verb_gloss_stem/@vbStem)}&#160;{$value/morph/pair/morph1}&#160;: {data($verb_gloss_stem/meaning)}</p>
                
            </div>
        ) else if ( data($value/CABlemma2)[1] ) then (
            <div>      
                <p> 
                    {data($value_gloss1/@CABlemma)}&#160;{if ( $result/morph1/@has_tmesis ) then (<p>{data($result/morph1/@comp_form)} (tmesis)</p>
                ) else ()}&#160;{if ( data($value/subLemma) and  data($value_gloss1/lemma/stem/@vbStem) ) then (
                        <p>{data($value/subLemma)}&#160;{data($value_gloss1/lemma/stem/@vbStem)}</p>
                ) else ()}&#160;{data($result/morph1)}&#160;: {if ( data($value_gloss1/lemma/stem/meaning)[1] ) then ( data($value_gloss1/lemma/stem/meaning) ) 
                                else if ( data($value_gloss1/meaning) ) then ( data($value_gloss1/meaning) ) else ()}
                    
                </p>
                {if ( data($value/CABlemma2) ) then (
                    <p>
                        {data($value_gloss2/@CABlemma)}&#160;{$result/morph2}&#160;: {data($value_gloss2/meaning)}
                    </p>
                ) else() }
            </div>            

        ) else if ( contains(data($value/morph/pair/tmesis_id), $stanza_for_search) ) then ( (: for those that have a tmesis without a second lemma:)
            <div>      
                <p>{data($value_gloss1/@CABlemma)}&#160;{if ( $result/morph1/@has_tmesis ) then (
                    <p>{data($result/morph1/@comp_form)} (tmesis)</p>
                ) else if ( data($value/realForm ) ) then (
                    <p>{data($value/realForm)}(tmesis)</p>
                ) else ()}&#160;
                {if ( $value/subLemma and $value_gloss1/lemma/stem/@vbStem ) then (
                        <p>{data($value/subLemma)}&#160;
                        {if ( data($verb_gloss_stem_2/@vbStem) ) then (
                            data($verb_gloss_stem_2/@vbStem)
                        ) else if ( data($verb_gloss_stem/@vbStem) ) then (
                            data($verb_gloss_stem/@vbStem)
                        ) else ()}
                        </p>
                ) else ()}
                &#160;{$result/morph1}</p>&#160;: {if ( data($verb_gloss_stem_2/@vbStem) ) then (
                    <p>{data($verb_gloss_stem_2/meaning)}</p>
                ) else if ( data($verb_gloss_stem/@vbStem) ) then (
                    <p>{data($verb_gloss_stem/meaning)}</p>
                ) else if (  data($value_gloss1/meaning) ) then (
                    <p>{data($value_gloss1/meaning)}</p>
                ) else if ( data($value_gloss1/lemma/stem/meaning )[1] ) then (
                    <p>{data($value_gloss1/lemma/stem/meaning)}</p>
                ) else () }
            </div>
        
        ) else if ( data($value/CABlemma1)[1] ) then  (
            <div>    
                <p>{data($value_gloss1/@CABlemma)}&#160;
                
                {if ( not( $value/realForm ) or
                            ( ( $value/realForm ) and not( data($value/CABlemma2) ) )
                          ) then (
                    <p>{$result/morph1}&#160;: {data($value_gloss1/meaning)}</p>
                
                ) else if ( $value/realForm )  then (
                    <p>{for $x in $value_gloss1/lemma/stem[form/orth eq data($value/realForm)]
                        return
                            <p>{data($value/subLemma)}&#160;{data($x/@vbStem)}&#160;: {data($x/meaning)}</p>
                        }
                    </p>
                ) else (
                    <p>
                        {$result/morph1}&#160;: {data($value_gloss1/meaning)}
                    </p>
                ) }
                </p>
            </div>             
        ) else (
            <div>
                <p>N/A</p>
            </div>
        )
        }

    </div>
 } ;
 

declare function app_stanza:get_stanza($node as node(), $model as map(*)) {
    let $stanza_id   := data(request:get-parameter( 'stanza_id'  , '0' ))
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
            case "10" return "/db/apps/cab_db/cabnew_rituals/blueprint/Cluster_rituals/Paragna_dynamic/"
            case "11" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_DH_dynamic/"
                default return 0                
     
    let $ritual_location := 
        switch ($get_ritual) 
            case "0" return "/db/apps/cab_db/cab_grammar/dron_stanzas/"
            case "1" return "/db/apps/cab_db/cab_grammar/yasnaR_stanzas/"
            case "2" return "/db/apps/cab_db/cab_grammar/yasna_stanzas/"
            case "3" return "/db/apps/cab_db/cab_grammar/visperad_stanzas/"
            case "4" return "/db/apps/cab_db/cab_grammar/videvdad_stanzas/"
            case "5" return "/db/apps/cab_db/cab_grammar/vishtasp_stanzas/"
                default return "/db/apps/cab_db/cab_grammar/"
    

    let $fr_remove := 	( '\d+', '[.][a-z]' )
    let $to_remove := 	( '', '' )

    let $fr :=	( 'zōt ud rāspīg', 'zōt', 'rāspīg' )
    let $to := 	( '', '', '' )

    (: generate stanza content:)
    let $stanza :=  
        <div id="stanza_full" style="padding-left:20px">
                    { 
                        for $i in collection( $ritual_location )//text/id($stanza_id)/div/include
                        let $xpointer := data($i/@xpointer)
                        let $online := data($i/@on_line) 
                        let $ihref := data($i/@href)
                        let $laststring := fn:substring( $xpointer, fn:string-length( $xpointer ), 1 )
                        return
                             if ( contains( $xpointer, "ShnumanGen" ) ) then (
                                    
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/id($xpointer)/*
                                    return
                                        
                                        if ( contains($xpointer, "RatuShnumanGen" ) ) then (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        
                                        ) else if ( contains($xpointer, "RatuPaitiShort" ) ) then (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            
                                            { if ( $online eq "in1lineblock" ) then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else if ( contains($xpointer, "GahanbarGen" ) ) then (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( data($xpointer), $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                            }
                                            </ab>
                                        )
                                    
                             ) else if ( contains( $xpointer, "ShnumanAcc" ) ) then (
                
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanAcc")//div/id($xpointer)/*
                                    return
                                        
                                        if ( contains(data($x/@xpointer), "RatuShnumanAcc" ) ) then (
                                            <ab class="ab_special">
                                            <b><xmlid>{data($x/@xpointer)} :</xmlid></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanAcc")//ab/id(data($x/@xpointer))
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else if ( contains(data($x/@xpointer), "RatuAcc" ) ) then (
                                            <ab class="ab_special">
                                            <b><xmlid>{data($x/@xpointer)} :</xmlid></b>
                                            {

                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuAcc")//ab/id(data($x/@xpointer))
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else if ( contains(data($x/@xpointer), "GahanbarAcc" ) ) then (
                                            <ab class="ab_special">
                                            <b><xmlid>{data($x/@xpointer)} :</xmlid></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarAcc")//ab/id(data($x/@xpointer))
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else (
                                            <ab class="ab_special">
                                            <b><xmlid>{data($x/@xml:id)} :</xmlid></b>
                                            {
                                                <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                            }
                                            </ab>
                                        )
                                    
                                ) else if ( functx:containsall( $xpointer, ( 'MahGen', 'MahAcc', 'RozGen', 'RozAcc', 'RatuGen', 'RatuPaitiRatu', 'GahanbarGen' ) )                                
                                        ) then (
                                        <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {for $j in collection ( $ihref )//ab/id($xpointer)
                                            return
                                                <wordlist id="{$j/@xml:id}">{$j}</wordlist>
                                            }
                                        </ab>
                                
                                ) else if ( contains( $xpointer, 'WazGr' ) ) then (
                                        <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            <b><xmlid>{functx:replace-multi( $xpointer, $fr_remove, $to_remove )} :</xmlid></b>
                                            {for $j in collection ( $ihref )//ab/id($xpointer)
                                            return
                                                <wordlist id="{$j/@xml:id}">{$j}</wordlist>
                                            }
                                        </ab>                                        
                               ) else if ( $xpointer = ( "AV", "YAV", "YeH" ,"AV1", "YAV1", "YeH1", "AV2", "YAV2", "YeH2", "AV3", "YAV3", "YeH3" ) 
                                    ) then (
                                     
                                            for $j in collection( $ihref )//ab/id($xpointer)/ab
                                            return
                                                <ab class="ab_special">
                                                    <b><xmlid>
                                                        {
                                                        if ( $xpointer = ( "AV1", "AV2", "AV3" ) ) then ( "AV" )
                                                        else if ( $xpointer = ( "YAV1", "YAV2", "YAV3" ) ) then ( "YAV" )
                                                        else if ( $xpointer = ( "YeH1", "YeH2", "YeH3" ) ) then ( "YeH" )
                                                    
                                                         else (
                                                            $xpointer
                                                        )
                                                        }{ replace( $j/@xml:id, $xpointer,"") } :
                                                    </xmlid></b>
                                                    <wordlist id="{ $j/@xml:id }">{$j}</wordlist>
                                                </ab>
                                        
                                ) else if ( contains( $xpointer, "RatuLetAccAY" ) or contains( $xpointer, "RatuLetAccY" ) or
                                            contains( $xpointer, "RatuLetDat" ) or contains( $xpointer, "RatuPaitiShort" ) or
                                            contains( $xpointer, "RatuVoc" ) or contains( $xpointer, "RatuCer" ) or
                                            contains( $xpointer, "WazGr" ) or
                                            contains( $xpointer, "GahanbarAcc" ) or contains( $xpointer, "SupplyY" ) 
                                        ) then (
                                
                                    <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                        { if (data($online) eq "in1lineblock") then ( 
                                        <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                        
                                        <b><xml_id>[{data($xpointer)}]</xml_id></b>
                                        {for $j in collection ( $ihref )//ab/id($i/@xpointer)
                                        return 
                                            <wordlist id="{data($j/@xml:id)}">{$j}</wordlist>}
                                    </ab>
    
                                ) else if ( contains($xpointer,'Nerang')  ) then (                  
                                        (: ignore nerang :)
                                        
                                ) else if ( contains($xpointer,'Fragard') ) then (          
                                    <ab class="ab_special">
                                        <b><xmlid>{$xpointer} :</xmlid></b>
                                        {let $fragard := (for $z in collection( $ihref )//div/id($xpointer)
                                                        return 
                                                            $z)[1]
                                         
                                        return
                                            
                                                for $i in $fragard/*
                                                return 
                                                   if ( data($i/@type) eq 'prayer') then (
                                                       for $ii in collection ( $ihref )//ab/id($xpointer)
                                                       return
                                                           <wordlist id="{$ii/@xml:id}">{$ii}</wordlist>
                                                   ) else (
                                                        <wordlist id="{$i/@xml:id}">{$i}</wordlist>     
                                                   )
                                        }    
                                    </ab>
                                    
                                ) else if ( contains($xpointer,'Frauuarane_')  ) then (
                                    let $args := for $x in collection( $ihref )//div/id($xpointer)/*
                                                 return
                                                    $x
                                    return
                                            <ab class="ab_special" >
                                                <span class="frauuarane red"><b><xmlid>[Frauuarāne]</xmlid></b> </span>
                                                    
                                                {for $z in $args 
                                                return
                                                    if ( $z/@type = ( "block", "block_ratu" ) ) then (
                                                        <ab class="ab_special_frauuarane">
                                                            <b><xml_id>[{functx:replace-multi( $z/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                            {for $zy in collection( $z/@href )//ab/id($z/@xpointer)
                                                            return
                                                                <wordlist id="{$zy/@xml:id}">{$zy}</wordlist>}
                                                        </ab> 
                                                
                                                    ) else if ( $z/@type eq "block_shnumangen" ) then (
                                                    
                                                        for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/id($z/@xpointer)/*
                                                        return
                                                
                                                            if ( contains( $x/@xpointer, "RatuShnumanGen" ) ) then (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab/id($x/@xpointer)
                                                                    return
                                                                         <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($x/@xpointer, "RatuPaitiShort" ) ) then (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab/id($x/@pointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($i/@xpointer, "GahanbarGen" ) ) then (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab/id($x/@pointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xml:id, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                                                }
                                                                </ab>
                                                            )

                                                    ) else (
                                                        
                                                        <ab class="ab_special_inline">
                                                            <wordlist id="{$z/@xml:id}">{$z}</wordlist>  
                                                        </ab>
                                                    )
                                                }
                                            </ab>
                                        
                                ) else (
                                    
                                        
                                       if ( $laststring = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                        
                                                for $z in collection( $i/@href )//div/id($i/@xpointer)/*
                                                return
                                                    <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                        <b><xmlid>
                                                            {  
                                                              fn:concat( data($stanza_id), fn:substring( data($z/@xml:id), fn:string-length( data($z/@xml:id) ), 1 ) )
                                                             } :
                                                        </xmlid></b>
                                                        <wordlist id="{data($z/@xml:id)}">{$z}</wordlist>
                                                    </ab>
                                        ) else (
                                             <ab class="{if ( $online ) then (  concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                { if ( ( $online eq "in1lineblock") or (not($online eq "in1line")) ) then ( 
                                                    <b><xmlid>{$stanza_id}x :</xmlid></b> ) else () }
                                                        {for $z in collection( $i/@href )//ab/id($i/@xpointer)
                                                        return 
                                                            <wordlist id="{$z/@xml:id}">{$z}</wordlist>}
                                            </ab>                                            

                                        )
                                        
                                )
                    }
        </div>

    return
        <div>

            {if ( $stanza ) then (
                <div>
                    <div class="tab_float">
                        <div class="tab_header_top">
                            <button id="navLeft" class="tablinks" style="float:left;"><h5> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> </h5></button>
                                <h3 id="stanza_id"   style="font-weight:bold;display:contents">{$stanza_id}</h3>
                            <button id="navRight" class="tablinks" style="float:right;"><h5> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> </h5></button>

                        </div>         
                        
                        <div class="tab_links" >
                            <button class="tablinks always_visible"  role="button" onclick="window.open('manuscript_passages_viewer.html?passage={$stanza_id}', '_blank')">Transliterations <span class="glyphicon glyphicon-file"/></button>
                            <button class="tablinks always_visible"  data-toggle="collapse" data-target="#glossing_entry" role="button" aria-expanded="true" aria-controls="glossing_entry" onclick="window.location.href='#morphology'" style="display:none">Morphological Glossing</button>
                            <button id="pahlavi_button" class="tablinks"  data-toggle="collapse" data-target="#pahlavi_entry" role="button" aria-expanded="true" aria-controls="pahlavi_entry" onclick="window.location.href='#pahlavi'" style="display:none">Pahlavi Version</button>
                            <button class="tablinks always_visible"  data-toggle="collapse" data-target="#preved_entry" role="button" aria-expanded="true" aria-controls="preved_entry" onclick="window.location.href='#preved'" style="display:none">Previous Editions</button>
                            <button id="speaker_button" class="tablinks"  data-toggle="collapse" data-target="#speaker_entry" role="button" aria-expanded="true" aria-controls="speaker_entry" onclick="window.location.href='#speaker'" style="display:none">Speaker</button>
                            
                            <button class="tablinks always_visible"  data-target="#apparatus_tc_entry" role="button" aria-expanded="true" aria-controls="apparatus_tc_entry" onclick="window.location.href='#apparatus_tc'" style="display:none">Apparatus</button>
                            <button class="tablinks always_visible"  data-toggle="collapse" data-target="#apparatus_entry" role="button" aria-expanded="true" aria-controls="apparatus_entry" onclick="window.location.href='#critical'" style="display:none">Critical Commentaries</button>

                            <button id="parallels_button" class="tablinks"  data-toggle="collapse" data-target="#parallels_entry" role="button" aria-expanded="true" aria-controls="parallels_entry" onclick="window.location.href='#parallels'" style="display:none">Parallels</button>

                            <button id="ritual_button" class="tablinks"  data-toggle="collapse" data-target="#ritualinfo_entry" role="button" aria-expanded="true" aria-controls="glossing_entry" onclick="window.location.href='#ritual'" style="display:none">Ritual</button>
                            
                            <button class="tablinks always_visible"  data-toggle="collapse" data-target="#translation_entry" role="button" aria-expanded="true" aria-controls="translation_entry" onclick="window.location.href='#translation'" style="display:none">Translations</button>
                            <button class="tablinks always_visible"  style="float:right" onclick="window.location.href='#citation'" >Cite this entry</button>
                        </div> 

                        <div id="stanza_text">         
                            {if ( $stanza ) then (
                                <p><h4 id="stanza_text_header"><b>Stanza: </b></h4>
                                    {$stanza}
                                </p>
                            ) else ()}
                        </div>
                        
                        <div class="tab_footer">
                            <div class="tab_bottom tab tab_links">
                                        <button class="tablinks tab_button_bottom" onclick="StanzaToClipboard()"><h5>Copy stanza to Clipboard <span class="glyphicon glyphicon-file"/></h5></button>
                                        <button class="tablinks tab_button_bottom" id="avestan_char" val="1" onclick="AvestanChar()" ><h5> See Avestan Text <span class="glyphicon glyphicon-certificate"/></h5></button>
                            </div>
                                        
                        </div>
                    </div>
               
                    <div id="display-viewer-stanza" style="margin-bottom:28px !important">
                    <span id="morphology" class="" name="myanchor">
                        <div id="morphology{$stanza_id}" class="entry_apparatus apparatus_entry{$stanza_id}">
                            <div class="tab_header tab_header_second">
                                <h4 style="display:inline-block;"><b>Morphological Glossing</b></h4>
                                <div class="tab_links tab_links_second" style="display:inline-block;float:right">
                                    <div>
                                        <button id="morpho_button_expand" class="tablinks expander" data-toggle="collapse" data-target="#glossing_entry" role="button" aria-expanded="true" aria-controls="glossing_entry">Expand ∇</button>
                                        <button class="tablinks" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=morphology','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>

                            <div id="glossing_entry" class="collapse actual_entry">
                         
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>      
                    </span>    
                    
                    </div>
                    
                    <div id="display-viewer-stanza">

                    </div>    
                </div>
                
            ) else (
                <div class="tab_header">
                    <h4>No information available for stanza {data($stanza_id)} yet </h4>
                </div>
            )}
        </div>         
};

declare function app_stanza:get_stanza_focus($node as node(), $model as map(*)) {
    let $stanza_id   := request:get-parameter( 'stanza_id'  , '0' )
    let $ritual_id := request:get-parameter( 'stanza_location'  , '-1' )
    
    let $stanza_type := request:get-parameter( 'stanza_type'  , '' )
    let $element     := request:get-parameter( 'element'  , '' )
    
    let $focus_title : = 
        switch ($element) 
            case "morphology" return "Morphological Glossing" 
            case "pahlavi" return "Pahlavi Version"
            case "preved" return "Previous Editions"
            case "speaker" return "Speaker"
            case "apparatus" return "Critical Commentaries"
            case "parallels" return "Parallels"
            case "ritual_information" return "Ritual Information"
            case "translations" return "Translations"
                default return 0
                
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
                case "10" return "/db/apps/cab_db/cabnew_rituals/blueprint/Cluster_rituals/Paragna_dynamic/"
                case "11" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_DH_dynamic/"
                    default return 0                
         
    let $stanza_type := for $i in collection( $blueprint_location )//div/id($stanza_id)
                            return
                                data($i/@corresp)
        
    
    let $ritual_location := 
            switch ($get_ritual) 
                case "0" return "/db/apps/cab_db/cab_grammar/dron_stanzas/"
                case "1" return "/db/apps/cab_db/cab_grammar/yasnaR_stanzas/"
                case "2" return "/db/apps/cab_db/cab_grammar/yasna_stanzas/"
                case "3" return "/db/apps/cab_db/cab_grammar/visperad_stanzas/"
                case "4" return "/db/apps/cab_db/cab_grammar/videvdad_stanzas/"
                case "5" return "/db/apps/cab_db/cab_grammar/vishtasp_stanzas/"
                    default return "/db/apps/cab_db/cab_grammar/"
        
             
    let $fr_remove := 	( '\d+', '[.][a-z]' )
    let $to_remove := 	( '', '' )
    
    let $otherSource := for $x in collection( $ritual_location )//text/id($stanza_id) return $x/div/@sourceIs     
    let $otherValue :=  for $x in collection("/db/apps/cab_db/cab_grammar/yasna_stanzas")//text/id($otherSource) return $x          
         
    let $value := for $x in collection( $ritual_location )//text[@xml:id eq $stanza_id] return $x
                            
    let $header := for $i in $value/header return $i
            let $stanza_created := for $i in $header/created return $i
            let $stanza_updated := for $i in $header/updated return $i
            let $stanza_creator := for $i in $header/creators return $i
            
            let $stanza_authors := for $i in $stanza_creator/creator
                                    for $j in collection( '/db/apps/cab_db/cab_collaborators' )//collaborator[@xml:id eq data($i)]
                                    return
                                        data($j)
                                        
            let $authors_display := string-join( $stanza_authors, " &amp; " )
                            
    let $paral :=  if ( data($otherSource) ) then (
                                for $i in $otherValue/Parallels return $i
                        ) else (
                                for $i in $value/Parallels return $i
                        )
            
    let $speaker := for $i in $value/Speaker return $i
            let $SpeakerInfo := for $i in $speaker/SpeakerInfo return $i
            let $SpeakerCommentary := for $i in $speaker/Commentary return $i
            
    let $critical := for $i in $value/Apparatus return $i
            let $Apparatus := for $i in $critical/Critical return $i
            let $Orthographical := for $i in $critical/Orthographical return $i
            let $RecitationInstructions := for $i in $critical/RecitationInstruction return $i
            let $Commentary := for $i in $critical/Commentary return $i
            
            let $Commentary_with_bibl := for $i in $Commentary return replace( $i/Commentary/ab, 'bibl', <test>test</test>)
    
    let $ritual := for $i in $value/Ritual return $i
            let $ritualQuotations     := for $i in $ritual/Quotations return $i
            let $ritualNerangs        := for $i in $ritual/Nerangs return $i
            let $ritualModernPractice := for $i in $ritual/ModernPractice return $i
            let $ritualCommentary     := for $i in $ritual/Commentary return $i 
            
    let $translationInFile := for $i in $value/translation return $i
    
            let $translation :=  if ( $translationInFile) then (
                                    $translationInFile
                                ) else (
                                    for $i in $otherValue/translation return $i
                                )            
                    
            let $translation_cab_id := for $i in $translation/include[@type eq "CAB"] return $i
            let $translation_wolf_id := for $i in $translation/include[@type eq "W"] return $i                
            let $translation_darmesteter_id := for $i in $translation/include[@type eq "D"] return $i            
            let $translation_kellens_id := for $i in $translation/include[@type eq "K"] return $i              
    
            let $translation_cab :=  for $i in collection("/db/apps/cab_db/cab_translations/CAB")//ab/id($translation_cab_id/@corresp) return $i
            let $translation_wolf := for $i in collection("/db/apps/cab_db/cab_translations/Wolf")//ab/id($translation_wolf_id/@corresp) return $i
            let $translation_darmesteter := for $i in collection("/db/apps/cab_db/cab_translations/Darmesteter")//ab/id($translation_darmesteter_id/@corresp) return $i
            let $translation_kellens := for $i in collection("/db/apps/cab_db/cab_translations/Kellens")//ab/id($translation_kellens_id/@corresp) return $i
            
    let $pahlavi_manuscript := 
            switch ($get_ritual) 
                case "0" return "DRON"
                case "1" return "YASNA R"
                case "2" return "based on manuscript 0400, but see also manuscript 0510"
                case "3" return "Visperad"
                case "4" return "Videvdad"
                case "5" return "Vishtasp"
                    default return ""
            
            
    let $translation_pahlavi :=  for $i in collection("/db/apps/cab_db/cab_pahlavitranslations/")//div/id($stanza_id)
                                     return
                                        <div>
                                        {
                                            for $j in $i//ab
                                            return
                                                <ab>
                                                    { if ( data($j/@xml:id) ) then ( 
                                                    <b><xmlid>{replace( data($j/@xml:id), 'Translation.', '' )}</xmlid> :</b>
                                                    ) else () }
                                                    <wordlist>{data($j)}</wordlist>
                                                </ab>
                                        }
                                        </div>
                                        
    let $paral_yasna := for $i in collection( "/db/apps/cab_db/cab_parals" )/parals/pair
                            where ( contains($i, data($stanza_id)) and (string-length($i) eq string-length(data($stanza_id))) )
                            return $i/Y (: used only for non-yasna ids :)
                                        
    let $edition_geldner :=  for $i in collection("/db/apps/cab_db/cab_prev_editions/geldner")//div[(@xml:id eq $stanza_id)]
                                     return
                                        $i 
                                        
    let $edition_geldner_yasna := if ( data($paral_yasna) ) then ( for $i in collection("/db/apps/cab_db/cab_prev_editions/geldner")//div[@xml:id eq data($paral_yasna)[1]]
                                     return 
                                        $i ) else ( "None" )                              
            
    let $edition_spiegel :=  for $i in collection("/db/apps/cab_db/cab_prev_editions/spiegel")//div[@xml:id eq $stanza_id]
                                     return
                                        $i 
                                        
    let $edition_spiegel_yasna :=  if ( data($paral_yasna) ) then ( for $i in collection("/db/apps/cab_db/cab_prev_editions/spiegel")//div[@xml:id eq data($paral_yasna)[1]]
                                     return
                                        $i ) else ( "None" )                          
    
    let $edition_westergaard :=  for $i in collection("/db/apps/cab_db/cab_prev_editions/westergaard")//div[@xml:id eq $stanza_id]
                                     return
                                        $i    
                                
    let $edition_westergaard_yasna := if ( data($paral_yasna) ) then ( for $i in collection("/db/apps/cab_db/cab_prev_editions/westergaard")//div[@xml:id eq data($paral_yasna)[1]]
                                     return
                                        $i ) else ( "None" )                                    
            
            
    let $fr :=	( 'zōt ud rāspīg', 'zōt', 'rāspīg' )
    let $to := 	( '', '', '' )                
                

    return
        <div>

            {if ( $stanza_id ) then (
                <div>
                    <div class="tab_float">
                        <div class="tab_header_top">
                            <h3 id="stanza_id"   style="font-weight:bold;display:contents">{data($stanza_id)}</h3>

                        </div>         
                    </div>
                    <div class="tab_header">
                        <h4 style="display:inline-block;"><b>{$focus_title}</b></h4>  
                
                                <div class="tab_links" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks" onclick="CopyToClipboard('{data($element)}')">Copy to Clipboard <span class="glyphicon glyphicon-file"></span></button>
                                    </div>
                                </div>

                    </div>
                    <div id="display-viewer-stanza">
                    
                    
                    {if ( $element eq "morphology" ) then (
                    <div>
                        <span id="morphology" class="anchor" name="myanchor" />    
                        <div id="morphology{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div id="glossing_entry" class="actual_entry">
                            
                            {let $stanza_morpho :=   
                                    <div id="stanza_full" style="padding-left:20px">
                                        { 
                                            for $i in collection( $ritual_location )//text/id($stanza_id)/div/include
                                            let $xpointer := data($i/@xpointer)
                                            let $online := data($i/@on_line) 
                                            let $ihref := data($i/@href)
                                            let $laststring := fn:substring( $xpointer, fn:string-length( $xpointer ), 1 )
                                            return
                                                 if ( contains( $xpointer, "ShnumanGen" ) ) then (
                                                        
                                                        for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/id($xpointer)/*
                                                        return
                                                            
                                                            if ( contains($xpointer, "RatuShnumanGen" ) ) then (
                                                                <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                { if ( $online eq "in1lineblock") then (
                                                                <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                                                
                                                                <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab/id($xpointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            
                                                            ) else if ( contains($xpointer, "RatuPaitiShort" ) ) then (
                                                                <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                
                                                                { if ( $online eq "in1lineblock" ) then (
                                                                <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                                                
                                                                <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab/id($xpointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($xpointer, "GahanbarGen" ) ) then (
                                                                <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                
                                                                { if ( $online eq "in1lineblock") then (
                                                                <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                                                
                                                                <b><xml_id>[{functx:replace-multi( data($xpointer), $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab/id($xpointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else (
                                                                <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                { if ( $online eq "in1lineblock") then (
                                                                <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                                                
                                                                <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                                                }
                                                                </ab>
                                                            )
                                                        
                                                 ) else if ( contains( $xpointer, "ShnumanAcc" ) ) then (
                                    
                                                        for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanAcc")//div/id($xpointer)/*
                                                        return
                                                            
                                                            if ( contains($xpointer, "RatuShnumanAcc" ) ) then (
                                                                <ab class="ab_special">
                                                                <b><xmlid>{$xpointer} :</xmlid></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanAcc")//ab/id($xpointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($xpointer, "RatuAcc" ) ) then (
                                                                <ab class="ab_special">
                                                                <b><xmlid>{$xpointer} :</xmlid></b>
                                                                {
                    
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuAcc")//ab/id($xpointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($xpointer, "GahanbarAcc" ) ) then (
                                                                <ab class="ab_special">
                                                                <b><xmlid>{data($xpointer)} :</xmlid></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarAcc")//ab/id($xpointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else (
                                                                <ab class="ab_special">
                                                                <b><xmlid>{$x/@xml:id} :</xmlid></b>
                                                                {
                                                                    <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                                                }
                                                                </ab>
                                                            )
                                                        
                                                    ) else if ( functx:containsall( $xpointer, ( 'MahGen', 'MahAcc', 'RozGen', 'RozAcc', 'RatuGen', 'RatuPaitiRatu', 'GahanbarGen' ) )                                
                                                            ) then (
                                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                { if ( $online eq "in1lineblock") then (
                                                                <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                                                
                                                                <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {for $j in collection ( $ihref )//ab/id($xpointer)
                                                                return
                                                                    <wordlist id="{$j/@xml:id}">{$j}</wordlist>
                                                                }
                                                            </ab>
                                                    
                                                    ) else if ( contains( $xpointer, 'WazGr' ) ) then (
                                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                <b><xmlid>{functx:replace-multi( $xpointer, $fr_remove, $to_remove )} :</xmlid></b>
                                                                {for $j in collection ( $ihref )//ab/id($xpointer)
                                                                return
                                                                    <wordlist id="{$j/@xml:id}">{$j}</wordlist>
                                                                }
                                                            </ab>                                        
                                                   ) else if ( $xpointer = ( "AV", "YAV", "YeH" ,"AV1", "YAV1", "YeH1", "AV2", "YAV2", "YeH2", "AV3", "YAV3", "YeH3" ) 
                                                        ) then (
                                                         
                                                                for $j in collection( $ihref )//ab/id($xpointer)/ab
                                                                return
                                                                    <ab class="ab_special">
                                                                        <b><xmlid>
                                                                            {
                                                                            if ( $xpointer = ( "AV1", "AV2", "AV3" ) ) then ( "AV" )
                                                                            else if ( $xpointer = ( "YAV1", "YAV2", "YAV3" ) ) then ( "YAV" )
                                                                            else if ( $xpointer = ( "YeH1", "YeH2", "YeH3" ) ) then ( "YeH" )
                                                                        
                                                                             else (
                                                                                $xpointer
                                                                            )
                                                                            }{ replace( $j/@xml:id, $xpointer,"") } :
                                                                        </xmlid></b>
                                                                        <wordlist id="{ $j/@xml:id }">{$j}</wordlist>
                                                                    </ab>
                                                            
                                                    ) else if ( contains( $xpointer, "RatuLetAccAY" ) or contains( $xpointer, "RatuLetAccY" ) or
                                                                contains( $xpointer, "RatuLetDat" ) or contains( $xpointer, "RatuPaitiShort" ) or
                                                                contains( $xpointer, "RatuVoc" ) or contains( $xpointer, "RatuCer" ) or
                                                                contains( $xpointer, "WazGr" ) or
                                                                contains( $xpointer, "GahanbarAcc" ) or contains( $xpointer, "SupplyY" ) 
                                                            ) then (
                                                    
                                                        <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                            { if (data($online) eq "in1lineblock") then ( 
                                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                                            
                                                            <b><xml_id>[{data($xpointer)}]</xml_id></b>
                                                            {for $j in collection ( $ihref )//ab/id($i/@xpointer)
                                                            return 
                                                                <wordlist id="{data($j/@xml:id)}">{$j}</wordlist>}
                                                        </ab>
                        
                                                    ) else if ( contains($xpointer,'Nerang')  ) then (                  
                                                            (: ignore nerang :)
                                                            
                                                    ) else if ( contains($xpointer,'Fragard') ) then (          
                                                        <ab class="ab_special">
                                                            <b><xmlid>{$xpointer} :</xmlid></b>
                                                            {let $fragard := (for $z in collection( $ihref )//div/id($xpointer)
                                                                            return 
                                                                                $z)[1]
                                                             
                                                            return
                                                                
                                                                    for $i in $fragard/*
                                                                    return 
                                                                       if ( data($i/@type) eq 'prayer') then (
                                                                           for $ii in collection ( $ihref )//ab/id($xpointer)
                                                                           return
                                                                               <wordlist id="{$ii/@xml:id}">{$ii}</wordlist>
                                                                       ) else (
                                                                            <wordlist id="{$i/@xml:id}">{$i}</wordlist>     
                                                                       )
                                                            }    
                                                        </ab>
                                                        
                                                    ) else if ( contains($xpointer,'Frauuarane_')  ) then (
                                                        let $args := for $x in collection( $ihref )//div/id($xpointer)/*
                                                                     return
                                                                        $x
                                                        return
                                                                <ab class="ab_special" >
                                                                    <span class="frauuarane red"><b><xmlid>[Frauuarāne]</xmlid></b> </span>
                                                                        
                                                                    {for $z in $args 
                                                                    return
                                                                        if ( $z/@type = ( "block", "block_ratu" ) ) then (
                                                                            <ab class="ab_special_frauuarane">
                                                                                <b><xml_id>[{functx:replace-multi( $z/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                                {for $zy in collection( $z/@href )//ab/id($z/@xpointer)
                                                                                return
                                                                                    <wordlist id="{$zy/@xml:id}">{$zy}</wordlist>}
                                                                            </ab> 
                                                                    
                                                                        ) else if ( $z/@type eq "block_shnumangen" ) then (
                                                                        
                                                                            for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/id($z/@xpointer)/*
                                                                            return
                                                                    
                                                                                if ( contains( $x/@xpointer, "RatuShnumanGen" ) ) then (
                                                                                    <ab class="ab_special_frauuarane">
                                                                                    <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                                    {
                                                                                        for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab/id($x/@xpointer)
                                                                                        return
                                                                                             <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                                    }
                                                                                    </ab>
                                                                                ) else if ( contains($x/@xpointer, "RatuPaitiShort" ) ) then (
                                                                                    <ab class="ab_special_frauuarane">
                                                                                    <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                                    {
                                                                                        for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab/id($x/@pointer)
                                                                                        return
                                                                                            <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                                    }
                                                                                    </ab>
                                                                                ) else if ( contains($i/@xpointer, "GahanbarGen" ) ) then (
                                                                                    <ab class="ab_special_frauuarane">
                                                                                    <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                                    {
                                                                                        for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab/id($x/@pointer)
                                                                                        return
                                                                                            <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                                    }
                                                                                    </ab>
                                                                                ) else (
                                                                                    <ab class="ab_special_frauuarane">
                                                                                    <b><xml_id>[{functx:replace-multi( $x/@xml:id, $fr_remove, $to_remove )}]</xml_id></b>
                                                                                    {
                                                                                        <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                                                                    }
                                                                                    </ab>
                                                                                )
                    
                                                                        ) else (
                                                                            
                                                                            <ab class="ab_special_inline">
                                                                                <wordlist id="{$z/@xml:id}">{$z}</wordlist>  
                                                                            </ab>
                                                                        )
                                                                    }
                                                                </ab>
                                                            
                                                    ) else (
                                                        
                                                            
                                                           if ( $laststring = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                                            
                                                                    for $z in collection( $i/@href )//div/id($i/@xpointer)/*
                                                                    return
                                                                        <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                            <b><xmlid>
                                                                                {  
                                                                                  fn:concat( data($stanza_id), fn:substring( data($z/@xml:id), fn:string-length( data($z/@xml:id) ), 1 ) )
                                                                                 } :
                                                                            </xmlid></b>
                                                                            <wordlist id="{data($z/@xml:id)}">{$z}</wordlist>
                                                                        </ab>
                                                            ) else (
                                                                 <ab class="{if ( $online ) then (  concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                                    { if ( ( $online eq "in1lineblock") or (not($online eq "in1line")) ) then ( 
                                                                        <b><xmlid>{$stanza_id}x :</xmlid></b> ) else () }
                                                                            {for $z in collection( $i/@href )//ab/id($i/@xpointer)
                                                                            return 
                                                                                <wordlist id="{$z/@xml:id}">{$z}</wordlist>}
                                                                </ab>                                            
                    
                                                            )
                                                            
                                                    )
                                        }
                            </div>
                                
                                
                            let $xy := functx:remove-elements-deep( $stanza_morpho, ( 'note', 'span' ) )
                            
                            for $x at $posx  in $xy//wordlist[string-length(.) > 0 ]
                            
                            return
                                   <div class="morph_table_entry" >
                                    <br/>
                                    <table>
                                        <tr height="90">
                                            <td><b style="color:#c94c2d" class="table_numeric">{$posx}</b></td>
                                            {
                                            for $y at $posy in tokenize( $x )
                                            return
                                                <td width="110"><b>{$y}</b>
                                                    <br/>
                                                    <div id="morph_table">
                                                    {
                                                        try {
                                                                local:getGlossary(
                                                                        concat( $stanza_id, codepoints-to-string(  96 + fn:number( $posy ) ) ), 
                                                                        "$alternate_id",
                                                                        string($posy),
                                                                        $y )
                                                            } catch * {
                                                                "Error"
                                                            }    
                                                    }                                                    
                                                    </div>
                                                </td>                
                                            }
                                        </tr>
                                    </table>
                                    </div>
                                
                            }                                
                            </div>    
                        </div>
                    </div>
                    ) else if ( $element eq "speaker" ) then (
                    <div>
                        <span id="speaker" class="anchor" name="myanchor" />
                        {if ( data($SpeakerInfo) or data($SpeakerCommentary) ) then (
                        
                            <div id="speaker{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
    
                                <div id="speaker_entry" class="collapse in actual_entry">
                                    {if ( data($SpeakerInfo) ) then (
                                        <p>                            
                                            <div style="padding-left:20px">
                                                {$SpeakerInfo}
                                            </div>
                                        </p>
                                    ) else ()}                      
                                    
    
                                    
                                    {if ( data($SpeakerCommentary) ) then (
                                        <p>
                                            <h5 class="subtitle">Commentary:</h5>                            
                                            <div style="padding-left:20px">
                                                {$SpeakerCommentary}
                                            </div>
                                        </p>
                                    ) else ()}
                                </div>         
                                                        
                                <div class="tab_second_footer">
                                </div>
                            </div>                
                        ) else () }
                    </div>
                    ) else if ( $element eq "apparatus" ) then (
                        <div id="apparatus_entry" class="entry_apparatus">
                                {if ( data($Apparatus) ) then (
                                    <p>
                                        <!-- <div id="stanza_full" style="padding-left:20px">
                                        {(:for $i in $Apparatus/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg[ ( not(@type) or (@type != 'subreading') )and (@varSeq != '1')]
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        :)}
                                        </div> -->
                                        <h5 class="subtitle">Critical apparatus:</h5>
                                        <div style="padding-left:20px">
                                        {for $i in $Apparatus/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        }
                                        </div>
                                    </p>
                                ) else ()}
                                
                                {if ( data( $Orthographical ) ) then (
                                    <p>
                                        <h5 class="subtitle">Ortographical Apparatus:</h5>                           
                                        <div style="padding-left:20px">
                                        {for $i in $Orthographical/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        }
                                        </div>
                                    </p>
                                ) else ()} 
                                
                                {if ( data($RecitationInstructions) ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Recitation Instructions:</h5>                            
                                        <div style="padding-left:20px">
                                            {$RecitationInstructions}
                                        </div>
                                    </div>
                                ) else ()}
                                
                                {if ( data($Commentary) ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Commentary:</h5>                            
                                        <div style="padding-left:20px">
                                            {$Commentary}
                                        </div>
                                    </div>
                                ) else ()}
                                
                                {if ( not(data($Apparatus)) and not(data($Commentary)) and not(data($Orthographical)) and not(data($RecitationInstructions)) ) then ( "[Work in Progress]" ) else ()}
                                
                                
                            </div> 
                        
                        
                    ) else if ( $element eq "morphology" ) then (

                    ) else if ( $element eq "pahlavi" ) then (
                    <div>
                    <span id="pahlavi" class="" name="myanchor"/>
                        <div id="pahlavi{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">

                            <div id="pahlavi_entry">

                                {if ( $translation_pahlavi ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Pahlavi Transcription (PY7.1 from ms. 400): </h5> 
                                            <div class="paragraph_prev_edition">{$translation_pahlavi}</div>
                                        </div>
                                ) else ()}
                              
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>  
                    </div>
                    ) else if ( $element eq "preved" ) then (
                    <div>
                     <span id="preved" class="anchor" name="myanchor"/>
                        <div id="preved{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
              
                            <div id="preved_entry" >
                            
                                {if ( ( $edition_geldner ) )then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Geldner (#{data($edition_geldner/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_geldner}</div>
                                        </div>
                                ) else ()}
                                
                                {if ( $edition_westergaard ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Westergaard (#{data($edition_westergaard/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_westergaard}</div>
                                        </div>
                                    ) else ()}
                                
                                {if ( $edition_spiegel ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Spiegel (#{data($edition_spiegel/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_spiegel}</div>
                                        </div>
                                    ) else ()}       
                                    
                                                                    
                                {if ( functx:containsall( $stanza_id, ("ext", "Ext") ) ) then (
                                    <p> Not available</p>
                                ) else ()}    
                                    
                                    
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>      
                    </div>                       
                    ) else if ( $element eq "apparatus" ) then (
                    <div>
                        <span id="apparatus" class="anchor" name="myanchor" />
                        {if ( data($Apparatus) or data($Commentary) or data($Orthographical) or data($RecitationInstructions) ) then (
                        <div id="critical{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">

                            <div id="apparatus_entry" class="collapse in actual_entry">
                                {if ( data($Apparatus) ) then (
                                    <p>
                                        <!-- <div id="stanza_full" style="padding-left:20px">
                                        {(:for $i in $Apparatus/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg[ ( not(@type) or (@type != 'subreading') )and (@varSeq != '1')]
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        :)}
                                        </div> -->
                                        <h5 class="subtitle">Critical apparatus:</h5>
                                        <div style="padding-left:20px">
                                        {for $i in $Apparatus/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        }
                                        </div>
                                    </p>
                                ) else ()}
                                
                                {if ( data( $Orthographical ) ) then (
                                    <p>
                                        <h5 class="subtitle">Ortographical Apparatus:</h5>                           
                                        <div style="padding-left:20px">
                                        {for $i in $Orthographical/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        }
                                        </div>
                                    </p>
                                ) else ()} 
                                
                                {if ( data($RecitationInstructions) ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Recitation Instructions:</h5>                            
                                        <div style="padding-left:20px">
                                            {$RecitationInstructions}
                                        </div>
                                    </div>
                                ) else ()}
                                
                                {if ( data($Commentary) ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Commentary:</h5>                            
                                        <div style="padding-left:20px">
                                            {$Commentary}
                                        </div>
                                    </div>
                                ) else ()}
                            </div>               
                            <div class="tab_second_footer">
                            </div>
                        </div>                
                    ) else () }                           
                    </div>
                    ) else if ( $element eq "parallels" ) then (
                    <div>
                        <span id="parallels" class="anchor" name="myanchor" />
                        {if ( data($paral) ) then (
                        <div id="paral{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div id="parallels_entry" class="collapse in actual_entry">
                                <p  style="padding-left:20px">    
                                  {$paral}
                                </p>
                            </div>
                            <div class="tab_second_footer">
                            </div>
                        </div>
                    ) else ()}
                    </div>
                    ) else if ( $element eq "ritual_information" ) then (
                    <div>
                        <span id="ritual" class="anchor" name="myanchor" />
                        <div id="ritual{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div id="ritualinfo_entry" class="collapse in actual_entry">
                             {if ( (data($ritual)) ) then (
                                for $ii at $pos in $ritual/*
                                return
                                    if ( data($ii/@id) eq "ritualQuotations" ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Ritual Quotations</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>  
                                    ) else if ( data($ii/@id) eq "textualQuotations" ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Textual Quotations</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>     
                                    ) else if ( data($ii/@id) eq "ritualNerangs" ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Nerangs</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>                                    
                                    ) else if ( data($ii/@id) eq "ritualModernPractice" ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Indian Ritual Practice</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>    
                                    ) else if ( data($ii/@id) eq "ritualCommentary" ) then (
                                    <div style="padding-left:20px">
                                        <h5 class="subtitle">Commentary</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>                                        
                                    
                                    ) else (
                                        $ii
                                    )
                            ) else (
                                <p>No ritual information available for this stanza</p>     
                            )}
                            </div>
                            <div class="tab_second_footer">
                            </div>
                        </div>                        
                    </div>    
                    ) else if ( $element eq "translations" ) then (
                    <div>
                        <span id="translation" class="anchor" name="myanchor" />
                        <div id="translation{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
    
                            {if ( ( $translation_cab ) or ( $translation_wolf) ) then (
                                <div id="translation_entry" class="collapse in actual_entry">
    
                                    {if ( ( $translation_cab ) and ( 1 eq 0 ) )then (
                                            <div style="padding-left:20px"><h5 class="subtitle">CAB: </h5> 
                                                <div style="padding-left:20px">{$translation_cab}</div>
                                            </div>
                                    ) else ()}
                                    
                                    {if ( $translation_wolf ) then (
                                            <div style="padding-left:20px"><h5 class="subtitle">Wolf: </h5> 
                                                <div style="padding-left:20px">{$translation_wolf}</div>
                                            </div>
                                        ) else ()}
                                    
                                    {if ( $translation_darmesteter ) then (
                                            <div style="padding-left:20px"><h5 class="subtitle">Darmesteter: </h5> 
                                                <div style="padding-left:20px">{$translation_darmesteter}</div>
                                            </div>
                                        ) else ()}       
                                        
                                    {if ( $translation_kellens ) then (
                                            <div style="padding-left:20px"><h5 class="subtitle">Kellens: </h5> 
                                               <div style="padding-left:20px">{$translation_kellens}</div>
                                            </div>
                                        ) else ()}                                
                                </div>
                            ) else ( <p>No translation available for this stanza</p>)}
                            <div class="tab_second_footer">
                            </div>
                        </div>                     
                    </div>
                    ) else ()}

                        <span id="citation" class="anchor" name="myanchor" />
                        <div id="citation{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header">
                                <h4 style="display:inline-block;"><b>Cite this entry</b></h4>
                                <div class="tab_links" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks" onclick="CopyToClipboard('cite')">Copy to Clipboard <span class="glyphicon glyphicon-file"></span></button>
                                    </div>
                                </div>
                            </div>
                            <div id="cite_entry" class="collapse in actual_entry">
                                <p style="padding-left:20px; padding-bottom:5px">{data($authors_display)}, <i>Corpus Avesticum Berolinense</i> (CAB) {data($stanza_id)}: {$focus_title}, available at https://ada.geschkult.fu-berlin.de/exist/apps/cab/stanza.html?stanza_id={data($stanza_id)} (created on {data($stanza_created)})
                                </p>
                                {if ( $stanza_updated ) then ( <p style="padding-left:20px;"><b>Updated: </b> {data($stanza_updated)}</p> ) else ()}
                                <p style="padding-left:20px;"><b>Collaborator(s): </b> {data($authors_display)}</p> 
                            </div>
                            <div class="tab_second_footer">
                            </div>
                        </div>
                    </div>    
                </div>
            ) else (
                <div class="tab_header">
                    <h4>No information available for stanza {data($stanza_id)} yet </h4>
                </div>
            )}
        </div>        
};

declare function app_stanza:get_stanza_pub($node as node(), $model as map(*)) {
    let $stanza_id   := data(request:get-parameter( 'stanza_id'  , '' ))
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
                case "10" return "/db/apps/cab_db/cabnew_rituals/blueprint/Cluster_rituals/Paragna_dynamic/"
                case "11" return "/db/apps/cab_db/cab_rituals/blueprint/Visperad_DH_dynamic/"
                    default return 0                
         
    let $stanza_type := for $i in collection( $blueprint_location )//div/id($stanza_id)
                            return
                                data($i/@corresp)
        
    
    let $ritual_location := 
            switch ($get_ritual) 
                case "0" return "/db/apps/cab_db/cab_grammar/dron_stanzas/"
                case "1" return "/db/apps/cab_db/cab_grammar/yasnaR_stanzas/"
                case "2" return "/db/apps/cab_db/cab_grammar/yasna_stanzas/"
                case "3" return "/db/apps/cab_db/cab_grammar/visperad_stanzas/"
                case "4" return "/db/apps/cab_db/cab_grammar/videvdad_stanzas/"
                case "5" return "/db/apps/cab_db/cab_grammar/vishtasp_stanzas/"
                    default return "/db/apps/cab_db/cab_grammar/"
        
             
    let $fr_remove := 	( '\d+', '[.][a-z]' )
    let $to_remove := 	( '', '' )
    
    let $otherSource := for $x in collection( $ritual_location )//text/id($stanza_id) return $x/div/@sourceIs     
    let $otherValue :=  for $x in collection("/db/apps/cab_db/cab_grammar/yasna_stanzas")//text/id($otherSource) return $x          
         
    let $value := for $x in collection( $ritual_location )//text[@xml:id eq $stanza_id] return $x
                            
    let $header := for $i in $value/header return $i
            let $stanza_created := for $i in $header/created return $i
            let $stanza_updated := for $i in $header/updated return $i
            let $stanza_creator := for $i in $header/creators return $i
            
            let $stanza_authors := for $i in $stanza_creator/creator
                                    for $j in collection( '/db/apps/cab_db/cab_collaborators' )//collaborator[@xml:id eq data($i)]
                                    return
                                        data($j)
                                        
            let $authors_display := string-join( $stanza_authors, " &amp; " )
                            
    let $paral :=  if ( data($otherSource) ) then (
                                for $i in $otherValue/Parallels return $i
                        ) else (
                                for $i in $value/Parallels return $i
                        )
            
    let $speaker := for $i in $value/Speaker return $i
            let $SpeakerInfo := for $i in $speaker/SpeakerInfo return $i
            let $SpeakerCommentary := for $i in $speaker/Commentary return $i
            
    let $critical := for $i in $value/Apparatus return $i
            let $Apparatus := for $i in $critical/Critical return $i
            let $Orthographical := for $i in $critical/Orthographical return $i
            let $RecitationInstructions := for $i in $critical/RecitationInstruction return $i
            let $Commentary := for $i in $critical/Commentary return $i
            
            let $Commentary_with_bibl := for $i in $Commentary return replace( $i/Commentary/ab, 'bibl', <test>test</test>)
    
    let $ritual := for $i in $value/Ritual return $i
            let $ritualQuotations     := for $i in $ritual/Quotations return $i
            let $ritualNerangs        := for $i in $ritual/Nerangs return $i
            let $ritualModernPractice := for $i in $ritual/ModernPractice return $i
            let $ritualCommentary     := for $i in $ritual/Commentary return $i 
            
    let $translationInFile := for $i in $value/translation return $i
    
            let $translation :=  if ( $translationInFile) then (
                                    $translationInFile
                                ) else (
                                    for $i in $otherValue/translation return $i
                                )            
                    
            let $translation_cab_id := for $i in $translation/include[@type eq "CAB"] return $i
            let $translation_wolf_id := for $i in $translation/include[@type eq "W"] return $i                
            let $translation_darmesteter_id := for $i in $translation/include[@type eq "D"] return $i            
            let $translation_kellens_id := for $i in $translation/include[@type eq "K"] return $i              
    
            let $translation_cab :=  for $i in collection("/db/apps/cab_db/cab_translations/CAB")//ab/id($translation_cab_id/@corresp) return $i
            let $translation_wolf := for $i in collection("/db/apps/cab_db/cab_translations/Wolf")//ab/id($translation_wolf_id/@corresp) return $i
            let $translation_darmesteter := for $i in collection("/db/apps/cab_db/cab_translations/Darmesteter")//ab/id($translation_darmesteter_id/@corresp) return $i
            let $translation_kellens := for $i in collection("/db/apps/cab_db/cab_translations/Kellens")//ab/id($translation_kellens_id/@corresp) return $i
            
    let $pahlavi_manuscript := 
            switch ($get_ritual) 
                case "0" return "DRON"
                case "1" return "YASNA R"
                case "2" return "based on manuscript 0400, but see also manuscript 0510"
                case "3" return "Visperad"
                case "4" return "Videvdad"
                case "5" return "Vishtasp"
                    default return ""
            
            
    let $translation_pahlavi :=  for $i in collection("/db/apps/cab_db/cab_pahlavitranslations/")//div/id($stanza_id)
                                     return
                                        <div>
                                        {
                                            for $j in $i//ab
                                            return
                                                <ab>
                                                    { if ( data($j/@xml:id) ) then ( 
                                                    <b><xmlid>{replace( data($j/@xml:id), 'Translation.', '' )}</xmlid> :</b>
                                                    ) else () }
                                                    <wordlist>{data($j)}</wordlist>
                                                </ab>
                                        }
                                        </div>
                                        
    let $paral_yasna := for $i in collection( "/db/apps/cab_db/cab_parals" )/parals/pair
                            where ( contains($i, data($stanza_id)) and (string-length($i) eq string-length(data($stanza_id))) )
                            return $i/Y (: used only for non-yasna ids :)
                                        
    let $edition_geldner :=  for $i in collection("/db/apps/cab_db/cab_prev_editions/geldner")//div[(@xml:id eq $stanza_id)]
                                     return
                                        $i 
                                        
    let $edition_geldner_yasna := if ( data($paral_yasna) ) then ( for $i in collection("/db/apps/cab_db/cab_prev_editions/geldner")//div[@xml:id eq data($paral_yasna)[1]]
                                     return 
                                        $i ) else ( "None" )                              
            
    let $edition_spiegel :=  for $i in collection("/db/apps/cab_db/cab_prev_editions/spiegel")//div[@xml:id eq $stanza_id]
                                     return
                                        $i 
                                        
    let $edition_spiegel_yasna :=  if ( data($paral_yasna) ) then ( for $i in collection("/db/apps/cab_db/cab_prev_editions/spiegel")//div[@xml:id eq data($paral_yasna)[1]]
                                     return
                                        $i ) else ( "None" )                          
    
    let $edition_westergaard :=  for $i in collection("/db/apps/cab_db/cab_prev_editions/westergaard")//div[@xml:id eq $stanza_id]
                                     return
                                        $i    
                                
    let $edition_westergaard_yasna := if ( data($paral_yasna) ) then ( for $i in collection("/db/apps/cab_db/cab_prev_editions/westergaard")//div[@xml:id eq data($paral_yasna)[1]]
                                     return
                                        $i ) else ( "None" )                                    
            
    let $fr :=	( 'zōt ud rāspīg', 'zōt', 'rāspīg' )
    let $to := 	( '', '', '' )

    let $stanza := for $i in $value/div return $i
    (: generate stanza content:)
    (: generate stanza content:)
    let $stanza_content :=  
        <div id="stanza_full" style="padding-left:20px">
                    { 
                        for $i in collection( $ritual_location )//text/id($stanza_id)/div/include
                        let $xpointer := data($i/@xpointer)
                        let $online := data($i/@on_line) 
                        let $ihref := data($i/@href)
                        let $laststring := fn:substring( $xpointer, fn:string-length( $xpointer ), 1 )
                        return
                             if ( contains( $xpointer, "ShnumanGen" ) ) then (
                                    
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/id($xpointer)/*
                                    return
                                        
                                        if ( contains($xpointer, "RatuShnumanGen" ) ) then (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        
                                        ) else if ( contains($xpointer, "RatuPaitiShort" ) ) then (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            
                                            { if ( $online eq "in1lineblock" ) then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else if ( contains($xpointer, "GahanbarGen" ) ) then (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( data($xpointer), $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else (
                                            <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {
                                                <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                            }
                                            </ab>
                                        )
                                    
                             ) else if ( contains( $xpointer, "ShnumanAcc" ) ) then (
                
                                    for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanAcc")//div/id($xpointer)/*
                                    return
                                        
                                        if ( contains($xpointer, "RatuShnumanAcc" ) ) then (
                                            <ab class="ab_special">
                                            <b><xmlid>{$xpointer} :</xmlid></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanAcc")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else if ( contains($xpointer, "RatuAcc" ) ) then (
                                            <ab class="ab_special">
                                            <b><xmlid>{$xpointer} :</xmlid></b>
                                            {

                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuAcc")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else if ( contains($xpointer, "GahanbarAcc" ) ) then (
                                            <ab class="ab_special">
                                            <b><xmlid>{data($xpointer)} :</xmlid></b>
                                            {
                                                for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarAcc")//ab/id($xpointer)
                                                return
                                                    <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                            }
                                            </ab>
                                        ) else (
                                            <ab class="ab_special">
                                            <b><xmlid>{$x/@xml:id} :</xmlid></b>
                                            {
                                                <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                            }
                                            </ab>
                                        )
                                    
                                ) else if ( functx:containsall( $xpointer, ( 'MahGen', 'MahAcc', 'RozGen', 'RozAcc', 'RatuGen', 'RatuPaitiRatu', 'GahanbarGen' ) )                                
                                        ) then (
                                        <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            { if ( $online eq "in1lineblock") then (
                                            <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                            
                                            <b><xml_id>[{functx:replace-multi( $xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                            {for $j in collection ( $ihref )//ab/id($xpointer)
                                            return
                                                <wordlist id="{$j/@xml:id}">{$j}</wordlist>
                                            }
                                        </ab>
                                
                                ) else if ( contains( $xpointer, 'WazGr' ) ) then (
                                        <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                            <b><xmlid>{functx:replace-multi( $xpointer, $fr_remove, $to_remove )} :</xmlid></b>
                                            {for $j in collection ( $ihref )//ab/id($xpointer)
                                            return
                                                <wordlist id="{$j/@xml:id}">{$j}</wordlist>
                                            }
                                        </ab>                                        
                               ) else if ( $xpointer = ( "AV", "YAV", "YeH" ,"AV1", "YAV1", "YeH1", "AV2", "YAV2", "YeH2", "AV3", "YAV3", "YeH3" ) 
                                    ) then (
                                     
                                            for $j in collection( $ihref )//ab/id($xpointer)/ab
                                            return
                                                <ab class="ab_special">
                                                    <b><xmlid>
                                                        {
                                                        if ( $xpointer = ( "AV1", "AV2", "AV3" ) ) then ( "AV" )
                                                        else if ( $xpointer = ( "YAV1", "YAV2", "YAV3" ) ) then ( "YAV" )
                                                        else if ( $xpointer = ( "YeH1", "YeH2", "YeH3" ) ) then ( "YeH" )
                                                    
                                                         else (
                                                            $xpointer
                                                        )
                                                        }{ replace( $j/@xml:id, $xpointer,"") } :
                                                    </xmlid></b>
                                                    <wordlist id="{ $j/@xml:id }">{$j}</wordlist>
                                                </ab>
                                        
                                ) else if ( contains( $xpointer, "RatuLetAccAY" ) or contains( $xpointer, "RatuLetAccY" ) or
                                            contains( $xpointer, "RatuLetDat" ) or contains( $xpointer, "RatuPaitiShort" ) or
                                            contains( $xpointer, "RatuVoc" ) or contains( $xpointer, "RatuCer" ) or
                                            contains( $xpointer, "WazGr" ) or
                                            contains( $xpointer, "GahanbarAcc" ) or contains( $xpointer, "SupplyY" ) 
                                        ) then (
                                
                                    <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                        { if (data($online) eq "in1lineblock") then ( 
                                        <b><xmlid>{$stanza_id}x :</xmlid></b> ) else ()}
                                        
                                        <b><xml_id>[{data($xpointer)}]</xml_id></b>
                                        {for $j in collection ( $ihref )//ab/id($i/@xpointer)
                                        return 
                                            <wordlist id="{data($j/@xml:id)}">{$j}</wordlist>}
                                    </ab>
    
                                ) else if ( contains($xpointer,'Nerang')  ) then (                  
                                        (: ignore nerang :)
                                        
                                ) else if ( contains($xpointer,'Fragard') ) then (          
                                    <ab class="ab_special">
                                        <b><xmlid>{$xpointer} :</xmlid></b>
                                        {let $fragard := (for $z in collection( $ihref )//div/id($xpointer)
                                                        return 
                                                            $z)[1]
                                         
                                        return
                                            
                                                for $i in $fragard/*
                                                return 
                                                   if ( data($i/@type) eq 'prayer') then (
                                                       for $ii in collection ( $ihref )//ab/id($xpointer)
                                                       return
                                                           <wordlist id="{$ii/@xml:id}">{$ii}</wordlist>
                                                   ) else (
                                                        <wordlist id="{$i/@xml:id}">{$i}</wordlist>     
                                                   )
                                        }    
                                    </ab>
                                    
                                ) else if ( contains($xpointer,'Frauuarane_')  ) then (
                                    let $args := for $x in collection( $ihref )//div/id($xpointer)/*
                                                 return
                                                    $x
                                    return
                                            <ab class="ab_special" >
                                                <span class="frauuarane red"><b><xmlid>[Frauuarāne]</xmlid></b> </span>
                                                    
                                                {for $z in $args 
                                                return
                                                    if ( $z/@type = ( "block", "block_ratu" ) ) then (
                                                        <ab class="ab_special_frauuarane">
                                                            <b><xml_id>[{functx:replace-multi( $z/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                            {for $zy in collection( $z/@href )//ab/id($z/@xpointer)
                                                            return
                                                                <wordlist id="{$zy/@xml:id}">{$zy}</wordlist>}
                                                        </ab> 
                                                
                                                    ) else if ( $z/@type eq "block_shnumangen" ) then (
                                                    
                                                        for $x in collection("/db/apps/cab_db/cab_rituals/blocks/ShnumanGen")//div/id($z/@xpointer)/*
                                                        return
                                                
                                                            if ( contains( $x/@xpointer, "RatuShnumanGen" ) ) then (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuShnumanGen")//ab/id($x/@xpointer)
                                                                    return
                                                                         <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($x/@xpointer, "RatuPaitiShort" ) ) then (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/RatuPaitiShort")//ab/id($x/@pointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else if ( contains($i/@xpointer, "GahanbarGen" ) ) then (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xpointer, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    for $y in collection("/db/apps/cab_db/cab_rituals/blocks/GahanbarGen")//ab/id($x/@pointer)
                                                                    return
                                                                        <wordlist id="{$y/@xml:id}">{$y}</wordlist>
                                                                }
                                                                </ab>
                                                            ) else (
                                                                <ab class="ab_special_frauuarane">
                                                                <b><xml_id>[{functx:replace-multi( $x/@xml:id, $fr_remove, $to_remove )}]</xml_id></b>
                                                                {
                                                                    <wordlist id="{$x/@xml:id}">{$x}</wordlist>
                                                                }
                                                                </ab>
                                                            )

                                                    ) else (
                                                        
                                                        <ab class="ab_special_inline">
                                                            <wordlist id="{$z/@xml:id}">{$z}</wordlist>  
                                                        </ab>
                                                    )
                                                }
                                            </ab>
                                        
                                ) else (
                                    
                                        
                                       if ( $laststring = ( '0', '1','2','3','4','5','6','7','8','9' ) ) then (
                                        
                                                for $z in collection( $i/@href )//div/id($i/@xpointer)/*
                                                return
                                                    <ab class="{if ( $online ) then ( concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                        <b><xmlid>
                                                            {  
                                                              fn:concat( data($stanza_id), fn:substring( data($z/@xml:id), fn:string-length( data($z/@xml:id) ), 1 ) )
                                                             } :
                                                        </xmlid></b>
                                                        <wordlist id="{data($z/@xml:id)}">{$z}</wordlist>
                                                    </ab>
                                        ) else (
                                             <ab class="{if ( $online ) then (  concat( $online, "_stanza" ) ) else ( "ab_special" )}">
                                                { if ( ( $online eq "in1lineblock") or (not($online eq "in1line")) ) then ( 
                                                    <b><xmlid>{$stanza_id}x :</xmlid></b> ) else () }
                                                        {for $z in collection( $i/@href )//ab/id($i/@xpointer)
                                                        return 
                                                            <wordlist id="{$z/@xml:id}">{$z}</wordlist>}
                                            </ab>                                            

                                        )
                                        
                                )
                    }
        </div>

    return
        <div>

            {if ( $stanza ) then (
                <div>
                    <div>
                        <div>
                            <h3 id="stanza_id"   style="font-weight:bold;display:contents">{data($stanza_id)}</h3>
                        </div>         
                        <div>         
                            {if ( $stanza_content ) then (
                                <p><h4><b>Stanza: </b></h4>
                                    {$stanza_content}
                                </p>
                            ) else ()}
                        </div>
                        
                    </div>
               
                    <div id="display-viewer-stanza" style="margin-bottom:28px !important">
  
                    <span id="pahlavi" class="" name="myanchor">
                    {if ( $translation_pahlavi ) then (
                        <div >
                            <div >
                                <h4 style="display:inline-block;"><b>Pahlavi Version</b></h4>
                            </div>

                            <div id="pahlavi_entry" >

                                {if ( $translation_pahlavi ) then (
                                        <div style="padding-left:20px"><h5>Pahlavi Transcription (P{data($translation_pahlavi/@xml:id)}, {data($pahlavi_manuscript)}): </h5> 
                                            <div class="paragraph_prev_edition">{$translation_pahlavi}</div>
                                        </div>
                                ) else ()}
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>  
                    ) else ()}
                    </span>
                    </div>
                    
                    <div id="display-viewer-stanza">
                    <span id="speaker" class="anchor" name="myanchor" />
                    {if ( data($SpeakerInfo) or data($SpeakerCommentary) ) then (
                        <div>
                            <div >
                                <h4 style="display:inline-block;"><b>Speaker</b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                </div>
                            </div>
                            <div>
                                {if ( data($SpeakerInfo) ) then (
                                    <p>                            
                                        <div style="padding-left:20px">
                                            {$SpeakerInfo}
                                        </div>
                                    </p>
                                ) else ()}                      
                                
                                {if ( data($SpeakerCommentary) ) then (
                                    <p>
                                        <h5>Commentary:</h5>                            
                                        <div style="padding-left:20px">
                                            {$SpeakerCommentary}
                                        </div>
                                    </p>
                                ) else ()}
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>                
                    ) else () }

                    <span id="critical" class="anchor" name="myanchor" />
                        <div >
                            <div>
                                <h4 style="display:inline-block;"><b>Critical Commentaries </b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                </div>
                            </div>
                            <div>
                                {if ( data($Apparatus) ) then (
                                    <p>
                                        <!-- <div id="stanza_full" style="padding-left:20px">
                                        {(:for $i in $Apparatus/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg[ ( not(@type) or (@type != 'subreading') )and (@varSeq != '1')]
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        :)}
                                        </div> -->
                                        <h5 >Critical apparatus:</h5>
                                        <div style="padding-left:20px">
                                        {for $i in $Apparatus/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        }
                                        </div>
                                    </p>
                                ) else ()}
                                
                                {if ( data( $Orthographical ) ) then (
                                    <p>
                                        <h5>Ortographical Apparatus:</h5>                           
                                        <div style="padding-left:20px">
                                        {for $i in $Orthographical/app
                                                return
                                                    <div>
                                                        <b>{data($i/@n)}: </b> 
                                                        <em>{data($i/lem)}</em>
                                                        {if ( $i/lem/@wit ) then (
                                                            data($i/lem/@wit)    
                                                        ) else ()} ]
                                                        
                                                        {for $x in $i/rdg
                                                            return 
                                                            <c>
                                                                <em>{$x}</em> 
                                                                <d>{data($x/@wit)}; </d>
                                                            </c>
                                                        }
                                                    </div>
                                        }
                                        </div>
                                    </p>
                                ) else ()} 
                                
                                {if ( data($RecitationInstructions) ) then (
                                    <div style="padding-left:20px">
                                        <h5>Recitation Instructions:</h5>                            
                                        <div style="padding-left:20px">
                                            {$RecitationInstructions}
                                        </div>
                                    </div>
                                ) else ()}
                                
                                {if ( data($Commentary) ) then (
                                    <div style="padding-left:20px">
                                        <h5>Commentary:</h5>                            
                                        <div style="padding-left:20px">
                                            {$Commentary}
                                        </div>
                                    </div>
                                ) else ()}
                                
                                {if ( not(data($Apparatus)) and not(data($Commentary)) and not(data($Orthographical)) and not(data($RecitationInstructions)) ) then ( "[Work in Progress]" ) else ()}
                                
                            </div>               
                            <div class="tab_second_footer">
                            </div>
                        </div>                

                    <span id="parallels" class="anchor" name="myanchor" />
                    {if ( data($paral) ) then (
                        <div >
                            <div >
                                <h4 style="display:inline-block;"><b>Parallels</b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                </div>
                            </div>
                            <div >
                                <p  style="padding-left:20px">    
                                  {$paral}
                                </p>
                            </div>
                            <div class="tab_second_footer">
                            </div>
                        </div>
                    ) else ()}
                    
                    <span id="ritual" class="anchor" name="myanchor" />
                    {if ( data(normalize-space($ritual) ) ) then (
                    <div  >
                            <div >
                                <h4 style="display:inline-block;"><b>Ritual Information</b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                    
                                </div>
                            </div>
                        <div >
                            {if ( (data($ritual)) ) then (
                                for $ii at $pos in $ritual/*
                                return
                                    if ( data($ii/@id) eq "ritualQuotations" ) then (
                                    <div style="padding-left:20px">
                                        <h5>Quotations</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>  
                                    ) else if ( data($ii/@id) eq "ritualNerangs" ) then (
                                    <div style="padding-left:20px">
                                        <h5>Nerangs</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>                                    
                                    ) else if ( data($ii/@id) eq "ritualModernPractice" ) then (
                                    <div style="padding-left:20px">
                                        <h5>Indian Ritual Practice</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>    
                                    ) else if ( data($ii/@id) eq "ritualCommentary" ) then (
                                    <div style="padding-left:20px">
                                        <h5 >Commentary</h5>
                                        <p style="padding-left:20px">{$ii}</p>
                                    </div>                                        
                                    
                                    ) else (
                                        $ii
                                    )
                            ) else (
                                <p>No ritual information available for this stanza</p>     
                            )}
                        </div>
                        <div class="tab_second_footer">
                        </div>
                    </div>
                    ) else ()}
                    
                    <span id="translation_pahlavi" class="anchor" name="myanchor"  style="display:none"/>
                    <div id="translationpahlavi{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}" style="display:none">
                            <div class="tab_header tab_header_third">
                                <h4 style="display:inline-block;"><b>Pahlavi Translation</b></h4>
                                <div class="tab_links" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks expander" data-toggle="collapse" data-target="#translationpahlavi_entry" role="button" aria-expanded="true" aria-controls="translationpahlavi_entry">Expand ∇</button>
                                        <button class="tablinks" onclick="CopyToClipboard('translationpahlavi')">Copy to Clipboard <span class="glyphicon glyphicon-file"></span></button>
                                        <button class="tablinks" target="_blank" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=translationpahlavi','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>
                        
                            <div id="translationpahlavi_entry" class="collapse actual_entry">
                                {if ( $translation_pahlavi ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Pahlavi transcription: </h5> 
                                            <div class="paragraph_prev_edition">{$translation_pahlavi}</div>
                                        </div>
                                ) else ()}

                            </div>
                        
                        <div class="tab_second_footer">
                        </div>
                    </div>                       
                    
                    </div>    
                </div>
            ) else (
                <div class="tab_header">
                    <h4>No information available for stanza {data($stanza_id)} yet </h4>
                </div>
            )}
        </div>         
};

