xquery version "3.1";

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
            case "10" return "/db/apps/cab_db/cab_grammar/paragna_stanzas/"
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
    <div id="display-viewer-stanza" style="margin-bottom:28px !important">
    
        <span id="morphology" class="" name="myanchor">
                        <div id="morphology{$stanza_id}" class="entry_apparatus apparatus_entry{$stanza_id}">
                            <div class="tab_header tab_header_second">
                                <h4 style="display:inline-block;"><b>Morphological Glossing</b></h4>
                                <div class="tab_links tab_links_second" style="display:inline-block;float:right">
                                    <div>
                                        <button id="morpho_button_expand" class="tablinks expander" data-toggle="collapse" data-target="#glossing_entry" role="button" aria-expanded="true" aria-controls="glossing_entry">Expand ∇</button>
                                        <button class="tablinks" onclick="window.open('stanza_focus.html?stanza_id={$stanza_id}&amp;stanza_location={$get_ritual}&amp;element=morphology','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>
                            <div id="glossing_entry" class="collapse actual_entry">
                                Loading Gloss <i class="fa fa-circle-o-notch fa-spin"/>
                            </div>
                            <div class="tab_second_footer"/>
                        </div>      
        </span> 
        <span id="pahlavi" class="" name="myanchor">
                    {if ( $translation_pahlavi ) then (
                        <div id="pahlavi{data($stanza_id)}" class="entry_pahlavi entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_second">
                                <h4 style="display:inline-block;"><b>Pahlavi Version</b></h4>
                                <!-- <h5 style="display:inline-block;"><b><a class="blank_link" href="apparatus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}{data($get_ritual)}&amp;stanza_type={data($stanza_type)}" target="_blank">[ See the Textual Communities (TC) Apparatus <span class="glyphicon glyphicon-new-window"/> ]</a></b></h5> -->
                                <div class="tab_links tab_links_second" style="display:inline-block;float:right">
                                    <div>
                                        <button id="pahlavi_button_expand" class="tablinks expander" data-toggle="collapse" data-target="#pahlavi_entry" role="button" aria-expanded="true" aria-controls="pahlavi_entry">Expand ∇</button>
                                        <button class="tablinks" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=pahlavi','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>

                            <div id="pahlavi_entry" class="collapse actual_entry">

                                {if ( $translation_pahlavi ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Pahlavi Transcription (P{data($translation_pahlavi/@xml:id)}, {data($pahlavi_manuscript)}): </h5> 
                                            <div class="paragraph_prev_edition">{$translation_pahlavi}</div>
                                        </div>
                                ) else ()}
                              
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>  
                    
                    ) else ()}
                    </span>
                    
                    <span id="preved" class="" name="myanchor">
                        <div id="preved{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_second">
                                <h4 style="display:inline-block;"><b>Previous Editions</b></h4>
                                <div class="tab_links tab_links_second" style="display:inline-block;float:right">
                                    <div>
                                        <button id="preved_button_expand" class="tablinks expander" data-toggle="collapse" data-target="#preved_entry" role="button" aria-expanded="true" aria-controls="glossing_entry">Expand ∇</button>
                                        <button class="tablinks" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=preved','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>

                            <div id="preved_entry" class="collapse actual_entry">
                            
                                {if ( ( $edition_geldner ) ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Geldner (#{data($edition_geldner/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_geldner}</div>
                                        </div>
                                ) else if ( ( $edition_geldner_yasna ) and ( $edition_geldner_yasna != "None" ) ) then (                                      
                                        <div style="padding-left:20px"><h5 class="subtitle">Geldner (#{data($edition_geldner_yasna/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_geldner_yasna}</div>
                                        </div>
                                    
                                    
                                ) else () }
                                
                                {if ( $edition_westergaard ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Westergaard (#{data($edition_westergaard/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_westergaard}</div>
                                        </div>
                                ) else if ( ( $edition_westergaard_yasna ) and ( $edition_westergaard_yasna != "None" ) ) then (                                                                                <div style="padding-left:20px"><h5 class="subtitle">Westergaard (#{data($edition_westergaard_yasna/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_westergaard_yasna}</div>
                                        </div>
                                    
                                ) else ()}
                                
                                {if ( $edition_spiegel ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Spiegel (#{data($edition_spiegel/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_spiegel}</div>
                                        </div>
                                ) else if ( ( $edition_spiegel_yasna ) and ( $edition_spiegel_yasna != "None" ) ) then (
                                        <div style="padding-left:20px"><h5 class="subtitle">Spiegel (#{data($edition_spiegel_yasna/@corresp)}): </h5> 
                                            <div class="paragraph_prev_edition">{$edition_spiegel_yasna}</div>
                                        </div>                                    
                                    
                                ) else ()}
                                    
                                {if ( contains( $stanza_id, "ext" ) or contains( $stanza_id, "Ext" ) ) then (
                                    <p> Not available</p>
                                ) else if ( not( data($edition_geldner) ) and not( data($edition_westergaard) ) and not( data($edition_spiegel) ) and not( data($edition_geldner_yasna) ) and not( data($edition_westergaard_yasna) ) and not( data($edition_spiegel_yasna) ) ) then (
                                    <p> Work in progress</p>
                                ) else ()}
                                    
                            </div>         
                                                    
                            <div class="tab_second_footer">
                            </div>
                        </div>      
                    </span>                     
                    
                    
                    <div id="display-viewer-stanza">

                    <span id="speaker" class="anchor" name="myanchor" />

                    {if ( data($SpeakerInfo) or data($SpeakerCommentary) ) then (
                    
                        <div id="speaker{data($stanza_id)}" class="entry_speaker entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_third">
                                <h4 style="display:inline-block;"><b>Speaker</b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks expander" data-toggle="collapse" data-target="#speaker_entry" role="button" aria-expanded="true" aria-controls="speaker_entry">Expand ∇</button>
                                        <button class="tablinks" target="_blank" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=speaker','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>

                            <div id="speaker_entry" class="collapse actual_entry">
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


                    <span id="apparatus_tc" class="anchor" name="myanchor" />
                        <div id="apparatus_tc{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_third">
                                <h4 style="display:inline-block;"><b>Apparatus: </b></h4>
                                <h5 style="display:inline-block;"><b><a class="blank_link" href="apparatus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;stanza_type={data($stanza_type)}" target="_blank"> See dynamic Textual Communities (TC) apparatus <span class="glyphicon glyphicon-file"/></a></b></h5>
                                
                            </div>
                        </div>

                    <span id="critical" class="anchor" name="myanchor" />
                        <div id="critical{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_third">
                                <h4 style="display:inline-block;"><b>Critical Commentaries </b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks expander" data-toggle="collapse" data-target="#apparatus_entry" role="button" aria-expanded="true" aria-controls="apparatus_entry">Expand ∇</button>
                                        <button class="tablinks" target="_blank" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=apparatus','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>
                            <div id="apparatus_entry" class="collapse actual_entry">
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
                            <div class="tab_second_footer">
                            </div>
                        </div>                

                    <span id="parallels" class="anchor" name="myanchor" />
                    {if ( data($paral) ) then (
                        <div id="paral{data($stanza_id)}" class="entry_parallels entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_third">
                                <h4 style="display:inline-block;"><b>Parallels</b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks expander" data-toggle="collapse" data-target="#parallels_entry" role="button" aria-expanded="true" aria-controls="parallels_entry">Expand ∇</button>
                                        <button class="tablinks" target="_blank" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=parallels','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>
                            <div id="parallels_entry" class="collapse actual_entry">
                                <p  style="padding-left:20px">    
                                  {$paral}
                                </p>
                            </div>
                            <div class="tab_second_footer">
                            </div>
                        </div>
                    ) else ()}
                    
                    <span id="ritual" class="anchor" name="myanchor" />
                    {if ( data(normalize-space($ritual)) ) then (
                        <div id="ritual{data($stanza_id)}" class="entry_ritual entry_apparatus apparatus_entry{data($stanza_id)}">
                                <div class="tab_header tab_header_third">
                                    <h4 style="display:inline-block;"><b>Ritual Information</b></h4>
                                    <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                        <div>
                                            <button class="tablinks expander" data-toggle="collapse" data-target="#ritualinfo_entry" role="button" aria-expanded="true" aria-controls="glossing_entry">Expand ∇</button>
                                            <button class="tablinks" target="_blank" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=ritual_information','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                        </div>
                                    </div>
                                </div>
                            <div id="ritualinfo_entry" class="collapse actual_entry">
                                {if ( (data($ritual)) ) then (
                                    for $ii at $pos in $ritual/*
                                    return
                                        if ( data($ii/@id) eq "ritualQuotations" ) then (
                                        <div style="padding-left:20px">
                                            <h5 class="subtitle">Quotations</h5>
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
                    
                    <span id="translation" class="anchor" name="myanchor" />
                    <div id="translation{data($stanza_id)}" class="entry_apparatus apparatus_entry{data($stanza_id)}">
                            <div class="tab_header tab_header_third">
                                <h4 style="display:inline-block;"><b>Translations</b></h4>
                                <div class="tab_links tab_links_third" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks expander" data-toggle="collapse" data-target="#translation_entry" role="button" aria-expanded="true" aria-controls="translation_entry">Expand ∇</button>
                                        <button class="tablinks" target="_blank" onclick="window.open('stanza_focus.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)}&amp;element=translations','_blank')">Open in New Tab <span class="glyphicon glyphicon-new-window"></span></button>
                                    </div>
                                </div>
                            </div>
                        {if ( ( $translation_cab ) or ( $translation_wolf) ) then (
                            <div id="translation_entry" class="collapse actual_entry">

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
                        ) else ( <div id="translation_entry" class="collapse actual_entry"><p>No translation available for this stanza</p></div>)}
                        <div class="tab_second_footer">
                        </div>
                    </div>                
                    
                    <span id="citation" class="anchor" name="myanchor" />
                    <div id="citation{data($stanza_id)}" class="entry_apparatus entry_citation apparatus_entry{data($stanza_id)}">
                            <div class="tab_header">
                                <h4 style="display:inline-block;"><b>Cite this entry</b></h4>
                                <div class="tab_links" style="display:inline-block;float:right">
                                    <div>
                                        <button class="tablinks" onclick="CopyToClipboard('cite')">Copy to Clipboard <span class="glyphicon glyphicon-file"></span></button>
                                    </div>
                                </div>
                            </div>
                            <div id="cite_entry" class="collapse in actual_entry">
                                <p style="padding-left:20px; padding-bottom:5px;font-size:16px">{data($authors_display)}, <i>Corpus Avesticum Berolinense</i> (CAB) {data($stanza_id)}, available at https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/stanza.html?stanza_id={data($stanza_id)}&amp;stanza_location={data($get_ritual)} (created on {data($stanza_created)})
                                </p>
                                {if ( $stanza_updated ) then ( <p style="padding-left:20px;"><b>Updated: </b> {data($stanza_updated)}</p> ) else ()}
                                <p style="padding-left:20px;"><b>Collaborator(s): </b> {data($authors_display)}</p> 
                            </div>
                            <div class="tab_second_footer">
                            </div>
                        </div>
                    </div>    
    </div>