xquery version "3.1";

declare variable $stanza := request:get-parameter( 'stanza'  , '' );
declare variable $n := request:get-parameter( 'n'  , '' );
declare variable $word := request:get-parameter( 'word'  , '' );

let $word_for_search   := substring( data($word), 0, string-length(data($word)) )
let $stanza_for_search := concat( $stanza, '.', $n , ';')

let $exact_value := for $x in collection("/db/apps/cab_db/cab_words")/wordlist/entry[word eq $word_for_search]
                for $y in $x/morph/pair[contains(id,$stanza_for_search)]
                    return
                        $x

let $value := if ( $exact_value ) then ( $exact_value ) else (
                for $x in collection("/db/apps/cab_db/cab_words")/wordlist/entry[word eq $word_for_search]
                return
                $x)
        
let $result := if ($value)  then (
                    let $pair: = for $i in $value/morph/pair[contains(id,$stanza_for_search)]
                    return
                        $i
                    
                    return
                        if ( $pair ) then (
                            $pair    
                        ) else (
                            (for $i in $value/morph/pair
                            return 
                                $i)[1]
                        )
                ) else ()
                
let $value_gloss1 := for $x in collection("/db/apps/cab_db/cab_glossary")/text/entry[@CABlemma eq $value/CABlemma1]
    return
        $x
        
let $value_gloss2 := for $x in collection("/db/apps/cab_db/cab_glossary")/text/entry[@CABlemma eq $value/CABlemma2]
    return
        $x        
        
let $verb_gloss_stem := for $x in $value_gloss1/lemma/stem[data(form/orth)[1] eq $value/word]
    return
        $x
        
let $verb_gloss_stem_2 := if ( data($value/realForm) ) then (
                            for $x in $value_gloss1/lemma/stem[data(form/orth)[1] eq $value/realForm]
                            return
                            $x
                        ) else ()
        
return
    <div>
       {
        if ( ( $verb_gloss_stem ) and not(contains(data($value/morph/pair/tmesis_id), $stanza_for_search)) ) then  (      (: check for verb :)
            <div>      
                <p><b>{data($value/word)}</b> (verb)</p>
                <p><b>{$value/morph/pair/morph1}</b></p>
                <br/>
                
                <p>Lemma: <b>{data($value_gloss1/@CABlemma)}</b></p>
                <br/>

                <p>Sublemma: <b>{for $x in $value_gloss1/lemma[stem/form/orth eq data($value/word)]
                                 return
                                     data($x/@subLemma)
                                 }
                             </b>
                </p>
                <p>Stem: <b>{data($verb_gloss_stem/@vbStem)}</b></p>
                <br/>

                <p>Meaning: <b>{data($verb_gloss_stem/meaning)}</b></p>
                <br/>

                <div>
                    { if ( data( $verb_gloss_stem/notes ) ) then  (
                        <p class="morph_note">Note(s): <b>{$verb_gloss_stem/notes}</b></p>
                    ) else () }
                </div>
                
                <!--{if ( $value_gloss1/lemma ) then (
                    <div>
                        <p>Sublemma: <b>{data($value_gloss1/lemma/@subLemma)}</b></p>
                        <p>Present Stem: <b>{data($value_gloss1/lemma/@presStem)}</b></p>
                        <p>Meaning: <b>{data($value_gloss1/lemma/meaning)}</b></p>
                        <br/>
                        <p>Form(s) <b>{$value_gloss/lemma/form}</b></p>
                        {if ( data( $value_gloss1/lemma/notes ) ) then  (
                        <p class="morph_note"><b>Note(s):</b> {$value_gloss1/lemma/notes}</p>
                        ) else ()}
                    </div>
                ) else ()} -->
                <p>See full reference in <a href="./aiw.html?id={data($value_gloss1/@AIWid)}" target="_blank" class="uilink"><em>Altiranisches Wörterbuch</em></a></p>
            </div>
        ) else if ( data($value/CABlemma2)[1] ) then (
            <div>      
                <p><b>{data($value/word)}</b></p>
                <br/>
                <p><b>Lemma</b></p>
                <p>Lemma: <b>{data($value_gloss1/@CABlemma)}</b></p>
                <p><b>{$result/morph1}</b></p>
                {if ( $result/morph1/@has_tmesis ) then (
                    <div>
                         <br/>
                         <p>Tmesis: <b>{data($result/morph1/@comp_form)}</b></p>
                         <br/>
                    </div>
                ) else ()}
                <!--<p>AIW Lemma: <b>{data($value_gloss1/@AIWlemma)}</b></p>-->
                <!-- FIX HERE-->
               
                {if ( data($value/subLemma) ) then (
                    <div>
                        <br/>
                        <p>Sublemma: <b>{data($value/subLemma)}</b></p>
                        <p>Stem: <b>{for $z in $value_gloss1/lemma[@subLemma eq data($value/subLemma)]
                                    return
                                        data($z/stem/@vbStem)}</b></p>
                        <br/>
                    </div>
                ) else ()}
                <br/>
                
               <!--<p>Meaning: <b>{if ( data($value_gloss1/lemma/stem/meaning) ) then ( data($value_gloss1/lemma/stem/meaning) ) 
                                else if ( data($value_gloss1/meaning) ) then ( data($value_gloss1/meaning) ) else ()}</b></p>-->
                
                <p>Meaning: <b>{for $z in $value_gloss1/lemma[@subLemma eq data($value/subLemma)]
                            return
                                $z/stem/meaning}
                                {$value_gloss1/meaning}</b></p>
                <br/>
                <!-- <p>Form(s) <b>{$value_gloss/form}</b></p> -->
                {if ( data( $value_gloss1/notes ) ) then  (
                    <p class="morph_note"><b>Note(s):</b> {$value_gloss1/notes}</p>
                ) else ()}        
                <p>See full reference in <a href="./aiw.html?id={data($value_gloss1/@AIWid)}" target="_blank" class="uilink"><em>Altiranisches Wörterbuch</em></a></p>
                <br/>

                {if ( data($value/CABlemma2) ) then (
                    <div>
                        <br/>
                        <p><b>Lemma 2</b></p>
                        <p>Lemma: <b>{data($value_gloss2/@CABlemma)}</b></p>
                        <p><b>{$result/morph2}</b></p>
                        <!--<p>AIW Lemma: <b>{data($value_gloss2/@AIWlemma)}</b></p>-->
                        <p>Lemma Meaning: <b>{data($value_gloss2/meaning)}</b></p>
                        <br/>
                        <!-- <p>Form(s) <b>{$value_gloss2/form}</b></p> -->
                        {if ( data( $value_gloss2/notes ) ) then  (
                            <p class="morph_note"><b>Note(s):</b> {$value_gloss2/notes}</p>
                        ) else ()}               
                        <p>See full reference in <a href="./aiw.html?id={data($value_gloss2/@AIWid)}" target="_blank" class="uilink"><em>Altiranisches Wörterbuch</em></a></p>
                     </div>
                ) else ()}                
            </div>     
        ) else if ( contains(data($value/morph/pair/tmesis_id), $stanza_for_search) ) then ( (: for those that have a tmesis without a second lemma:)
            <div>      
                <p><b>{data($value/word)}</b></p>
                <br/>
                <p><b>Lemma </b></p>
                <p>Lemma: <b>{data($value_gloss1/@CABlemma)}</b></p>
                <p><b>{$result/morph1}</b></p>
                {if ( $result/morph1/@has_tmesis ) then (
                    <div>
                         <br/>
                         <p>Tmesis: <b>{data($result/morph1/@comp_form)}</b></p>
                         <br/>
                    </div>
                ) else ()}
                <!--<p>AIW Lemma: <b>{data($value_gloss1/@AIWlemma)}</b></p>-->
                
                {if ( $value/subLemma and $value_gloss1/lemma/stem/@vbStem ) then (
                    <div>
                        <br/>
                        <p>Sublemma: <b>{data($value/subLemma)}</b></p>
                        
                        <p>Stem: <b>{if ( data($verb_gloss_stem_2/@vbStem) ) then (
                            data($verb_gloss_stem_2/@vbStem)
                        ) else if ( data($verb_gloss_stem/@vbStem) ) then (
                            data($verb_gloss_stem/@vbStem)
                        ) else ( 

                                for $z in $value_gloss1/lemma[@subLemma eq data($value/subLemma)]
                                return
                                    data($z/stem/@vbStem)
                            
                        )}</b></p>
                        <p>Full form: <b>{data($value/realForm)}</b></p>
                        <br/>
                    </div>
                ) else ()}

                <p>Meaning: <b>{if ( data($verb_gloss_stem_2/@vbStem) ) then (
                            data($verb_gloss_stem_2/meaning)
                        ) else if ( data($verb_gloss_stem/@vbStem) ) then (
                            data($verb_gloss_stem/meaning)
                        ) else if (  data($value_gloss1/meaning) ) then (
                            data($value_gloss1/meaning)
                        ) else (
                            for $z in $value_gloss1/lemma[@subLemma eq data($value/subLemma)]
                            return
                                $z/stem/meaning
                        )}</b></p>
                <br/>
                <!-- <p>Form(s) <b>{$value_gloss/form}</b></p> -->
                {if ( data( $value_gloss1/notes ) ) then  (
                    <p class="morph_note"><b>Note(s):</b> {$value_gloss1/notes}</p>
                ) else ()}        
                <p>See full reference in <a href="./aiw.html?id={data($value_gloss1/@AIWid)}" target="_blank" class="uilink"><em>Altiranisches Wörterbuch</em></a></p>
                <br/>
            </div>
        
        ) else if ( data($value/CABlemma1)[1] ) then  (
            <div>      
                <p><b>{data($value/word)}</b></p>
                
                <br/>
                <p>Lemma: <b>{data($value_gloss1/@CABlemma)}</b></p>
                <p><b>{$result/morph1}</b></p>
                <!--<p>AIW Lemma: <b>{data($value_gloss1/@AIWlemma)}</b></p>-->
                
                <br/>
                
                {if ( not( $value/realForm ) or
                            ( ( $value/realForm ) and not( data($value/CABlemma2) ) )
                          ) then (
                        <div>
                    <p>Meaning: <b>{for $x in $value_gloss1//stem[contains(form/orth, $value/word)]
                                    return
                                        $x/meaning}
                                    {for $x in $value_gloss1[contains(form/orth, $value/word)]
                                    return
                                        $x/meaning}</b></p>
                    </div>
                
                ) else if ( $value/realForm )  then (
                    <div>
                          <p>{for $x in $value_gloss1/lemma/stem[data(form/orth) eq data($value/realForm)]
                            return
                            <div>
                              <p>Sublemma: <b>{data($value/subLemma)}</b></p>
                              <p>Stem: <b>{data($x/@vbStem)}</b></p>
                              <p>Full form: <b>{data($x/form/orth/@displayForm)}</b></p>
                             <br/>
                              <p>Meaning: <b>{data($x/meaning)}</b></p>
                            </div>}
                         </p>
                    </div>
                ) else () }

                <br/>
                <!-- <p>Form(s) <b>{$value_gloss/form}</b></p> -->
                {if ( data( $value_gloss1/notes ) ) then  (
                    <p class="morph_note"><b>Note(s):</b> {$value_gloss1/notes}</p>
                ) else ()}               
                <p>See full reference in <a href="./aiw.html?id={data($value_gloss1/@AIWid)}" target="_blank" class="uilink"><em>Altiranisches Wörterbuch</em></a></p>
            </div>             
        ) else (
            <div>
                <p>No information available for this word</p>
            </div>
        )
        }

    </div>