xquery version "3.1";

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
                    <p>{$result/morph1}&#160;: {for $x in $value_gloss1//stem[contains(form/orth, $value/word)]
                                    return
                                        $x/meaning}
                                    {for $x in $value_gloss1[contains(form/orth, $value/word)]
                                    return
                                        $x/meaning}</p>
                
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

let $stanza       := request:get-parameter( 'stanza'  , '' )
let $index        := request:get-parameter( 'indx'  , '0' )
let $stanza_id    := request:get-parameter( 'id'  , '-1' )
let $alternate_id := request:get-parameter( 'ids'  , '-1' )

return
    <div class="morph_table_entry" >
    <br/>
    <table>
        <tr height="90">
            <td><b style="color:#c94c2d" class="table_numeric">{$index}</b></td>
            {
            for $i at $pos in tokenize( $stanza )
            return
                <td width="110"><b>{$i}</b>
                    <br/>
                    <div id="morph_table">
                    {
                        try {
                                local:getGlossary(
                                        concat( $stanza_id, codepoints-to-string(  96 + fn:number( $index ) ) ), 
                                        $alternate_id,
                                        string($pos),
                                        $i )
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