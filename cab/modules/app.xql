xquery version "3.1";

module namespace app="https://ada.geschkult.fu-berlin.de/cab//templates";

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="https://ada.geschkult.fu-berlin.de/cab//config" at "config.xqm";
import module namespace functx="http://www.functx.com" at "app_functions.xqm";

declare function app:navig_menu($node as node(), $model as map(*)) {
    <div class="sticky-menu">
            <div class="nav-divider-lower">
                <div class="nav-divider-lower-center">
                    <a class="menu_nav_button" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/index.html">
                        <span class="glyphicon glyphicon-home"/>
                    </a>
                    <div class="dropdown" style="display:inline">
                    <a href="#" class="menu_nav_button dropdown-toggle" type="button" id="dropdownMenuButtonA" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">About</a>
                        <div class="dropdown-menu dropdown-menuA" aria-labelledby="dropdownMenuButtonA">
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/introduction.html#scope">Overall Scope</a>
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/introduction.html#goals">Goals &amp; Objectives</a>
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/introduction.html#numbering">Numbering in CAB</a>
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/sigla.html">Sigla</a>                            
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/workprogress.html">Work Progress</a>
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/team.html">Team</a>
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/acknowledgements.html">Partners</a>
                            <a class="dropdown-item diA" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/contact.html">Contact</a>

                        </div>         
                    </div>
                    <div class="dropdown" style="display:inline">
                        <a href="#" class="menu_nav_button dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tools
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/ceremony_generator.html">CAB 3.0</a>
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/bartholomae.html">Bartholomae's Dictionary</a>
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/manuscript_full_viewer.html">Manuscript Transliteration Viewer</a>
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/manuscript_database.html">Manuscript Database</a>
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/static.html">Static Ceremonies</a>
                            <div class="dropdown-divider" style="height:10px"/>
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://ada.geschkult.fu-berlin.de/">Manuscript Viewer (ADA)</a>
                            <a class="dropdown-item diB" style="display:block;padding:3px;color:#ffffff" href="https://cab.geschkult.fu-berlin.de/crystal/#dashboard?corpname=CAB">Concordances</a>
                        </div>
                    </div>
                    <a class="menu_nav_button" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/publications.html">Publications</a>
                    <a class="menu_nav_button" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/about/useful_links.html">External Links</a>             
                    
                    <!-- <a class="menu_nav_button" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/misc/news.html">News</a> -->
                    <!-- <a class="menu_nav_button" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/misc/citingcab.html">Citing Cab</a> -->
                </div>
            </div>
        </div>
};

declare function app:get_progress($node as node(), $model as map(*)) {
    <table style="text-align:center;width:100%">
     <tr style="background-color:#314757;color:#ffffff;vertical-align:middle;height:100px">
        <th width="70" style="text-align:center">Yasna</th>
        <th width="70" style="text-align:center">Yasna Rapithwin</th>
        <th width="70" style="text-align:center">Visperad</th>
        <th width="70" style="text-align:center">Videvdad</th>
        <th width="70" style="text-align:center">Vishtasp Yasht</th>
        <th width="50"></th>
        <th width="" style="text-align:center">1. Basis Edition</th>
        <th width="30"></th>
        <th width="" style="text-align:center">2. Critical &amp; Grammatical Edition</th>
        <th width="30"></th>
        <th width="" style="text-align:center">3. Apparatus</th>
        <th width="30"></th>
        <th width="" style="text-align:center">4. Automatic Collation</th>
        <th width="30"></th>
        <th width="" style="text-align:center">5. Transliterated Manuscripts</th>
        <th width="30"></th>
        <th width="" style="text-align:center">6. Transliterated w. Nerangs</th>
        <th width="30"></th>
        <th width="" style="text-align:center">7. Transliterated w. Pahlavi tr.</th>
        <th width="30"></th>
     </tr>
    {
    for $i at $pos in collection( "/db/apps/cab_db/cab_progress/cab_workprogress/" )/workprogress/entry
    return
            <tr style="{if ( $pos mod 2 = 0 ) then ( "background-color:#f3f0e3;color:#000000;" ) 
                        else ( "background-color:#E4DDBF;color:#1A1A1A;" )}
                    height:50px;vertical-align:middle">
                <td>{data($i/Y)}</td>
                <td>{data($i/YR)}</td>
                <td>{data($i/VrS)}</td>
                <td>{data($i/VS)}</td>
                <td>{data($i/Vyt)}</td>
                <td></td>
                <td>{if ( data($i/BEd) eq '1' ) then ( <div style="color:#25511E;font-size:30px">✓</div> ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
                <td>{if ( data($i/CGE) eq '1' ) then ( <div style="color:#25511E;font-size:30px">✓</div> ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
                <td>{if ( data($i/App) eq '1' ) then ( <div style="color:#25511E;font-size:30px">✓</div>  ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
                <td>{if ( data($i/AC) eq '1' ) then ( <div style="color:#25511E;font-size:30px">✓</div> ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
                <td>{if ( data($i/Manuscripts) ) then ( <div style="font-size:26px;cursor:pointer" class="tooltips">📄<span style="font-size:18px;width:300px" class="tooltiptext"><b>{data($i/Manuscripts)}</b></span></div> ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
                <td>{if ( data($i/Nerangs) eq '1' ) then ( <div style="color:#25511E;font-size:30px">✓</div> ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
                <td>{if ( data($i/Pahlavi) eq '1' ) then ( <div style="color:#25511E;font-size:30px">✓</div> ) else (<div style="color:#912F3C;font-size:30px">✗</div>)}</td>
                <td></td>
            </tr>

    }
    </table>
};

declare function app:get_publication($node as node(), $model as map(*)) {
        let $cerem   := request:get-parameter( 'ceremony', '0' )
        let $chapter := request:get-parameter( 'chapter' , '0' )
        let $stanza  := request:get-parameter( 'stanza'  , '0' )
        
        let $location : = 
        switch ( $cerem ) 
            case "Y"      return "/db/apps/cab_pub/Yasna"  
            case "YR"     return "/db/apps/cab_pub/YR"
            case "VrS"    return "/db/apps/cab_pub/VrS"
            case "VVrs"   return "/db/apps/cab_pub/VVrs"
            case "VytVrS" return "/db/apps/cab_pub/VytVrS"
                default return "/db/apps/cab_pub" 
                
        let $cerem_begin : = 
        switch ( $cerem ) 
            case "Y"      return "CABC:entity=Y:"  
            case "YR"     return "CABR:entity=YR:"
            case "VrS"    return "CABV:entity=VrS:"
            case "VVrs"   return "CABJ:entity=VVrS:"
            case "VytVrS" return "CABG:entity=VytVrS:"
                default return ""                 
                
        let $chapter_loc := if ( not( $chapter eq '0' ) )  then ( concat( $cerem_begin, "chapter=", $chapter, ":" ) ) else ( '' )
        let $stanza_loc := if ( not( $stanza eq '0' ) )  then ( concat( "stanza=", $stanza, ":" ) ) else ( '' )

        for $x in collection( $location )//ab[contains( @xml:id, concat( $chapter_loc, $stanza_loc ) )]
        order by $x/@xml:id
            return
            <div>
                <h4>{data($x/@xml:id)}</h4>
                {                
                for $i in $x//app
                return
                    <div>
                    {
                        for $j in $i
                        return
                            <div>
                            {
                                let $ao_nr := count($j/rdg[@n eq "ao"])
                                
                                let $ao := for $z at $pos in $j/rdg[@n eq "ao"]
                                    return 
                                        <z>
                                            <i>{functx:remove-elements-deep($z,'wit')}</i> {replace( normalize-space( data($z/wit) ), " ", ", ")}{if ( data($ao_nr ) eq $pos ) then () else (",") }
                                        </z>
                                        
                                return
                                    if ( $ao ) then (
                                        <div>
                                            <i>{data($j/lem)}</i>] {($ao)}  
                                        </div>
                                    ) else ()
                                    
                            }
                            {
                                let $non_ao_nr := count($j/rdg[not(@n eq "ao")])
                                
                                let $non_ao := for $z at $pos in $j/rdg[not(@n eq "ao")]
                                                return
                                                    <z>
                                                        <i>{replace(data($z), data($z/wit), '' )}</i>
                                                        <x>{replace( data($z/@wit), " ", ", " )} {if ( data($non_ao_nr ) eq $pos ) then () else (",") }</x>
                                                    </z>
                                return
                                    if ( $non_ao ) then (
                                        <div>
                                            <i>{data($j/lem)}</i>] {($non_ao)}  
                                        </div>
                                    ) else ()
                            }
                            </div>
                    }
                    </div>
            } </div>
} ;

declare function app:get_collation($node as node(), $model as map(*)) {
    let $stanza_id   := request:get-parameter( 'stanza_id'  , '0' )
    let $stanza_type := data(request:get-parameter( 'stanza_type'  , '' ))
    let $get_ritual  := request:get-parameter( 'stanza_location'  , '' )
    
    let $stanza_id_firstpart := substring-before( $stanza_id, '.' ) 
        let $stanza_id_numeric := string-join( functx:get-matches( $stanza_id_firstpart, '\d+' ) )  
        let $stanza_id_literal := string-join( functx:get-matches( $stanza_id_firstpart, '[A-Z,a-z]' ) )
    let $stanza_id_lastpart  := functx:substring-after-last( $stanza_id, '.')
    
    let $tc_community : = 
        switch ($get_ritual) 
            case "1" return "CABR" 
            case "2" return "CABC"
            case "3" return "CABV"
            case "4" return "CABJ"
            case "5" return "CABG"
            case "22" return "PY"
                default return 0

    let $tc_stanza : = 
        switch ($get_ritual) 
            case "1" return "stanza" 
            case "2" return "stanza"
            case "3" return "stanza"
            case "4" return "stanza"
            case "5" return "stanza"
            case "22" return "stanza"
                default return 0
                
    let $stanza_extra : =
        switch ($get_ritual)
            case "22" return "Translation."
                default return ""

    let $actual_type : =
        switch ($get_ritual)
            case "22" return "Pahlavi Translation"
                default return $stanza_type

    let $tc_link := fn:concat( "https://tc.geschkult.fu-berlin.de/colapp/apparatus.html/?dbUrl=https://tc.geschkult.fu-berlin.de/api/&amp;entity=", $tc_community,":entity=", $stanza_id_literal,
    ":chapter=" , $stanza_id_numeric, ":", $tc_stanza ,"=", $stanza_id_lastpart, ":block=" )
    let $tc_link_end := fn:concat( "&amp;community=", $tc_community, "&amp;user=5fb3b0e0027a3d37310ab670" )
                    
    let $value := for $x in collection( "/db/apps/cab_db/cab_grammar/" )//id($stanza_id) 
                        return $x/div
                        
    let $paral := (for $i in collection( "/db/apps/cab_db/cab_parals/" )//pair[contains(.,$stanza_id)]
                    return
                        $i)[1]
                    
    let $paral_yr  :=  string( $paral//YR )
    let $paral_y   :=  string( $paral//Y )
    let $paral_vrs :=  string( $paral//VrS )
    let $paral_vs  :=  string( $paral//VS )
    let $paral_vyt :=  string( $paral//Vyt )    
                        
    
    return
            <div>
                <div class="tab_float">
                    <div class="tab_header">
                        <div class="tab_float">
                            <div class="tab_header_apparatus">
                                <h3 style="font-weight:bold;display:contents">{data($stanza_id)} {if (data($stanza_type)) then ( <h5>{concat(" (", data($actual_type), ") " )}</h5> ) else ()}</h3>
                            </div>
                        </div>
                    </div>

                    {if ( $paral_yr or $paral_y or $paral_vrs or $paral_yr or $paral_vs or $paral_vyt ) then (
                        <div id="stanza_text" style="height:50px;text-align:center;margin:0;">
                            <div class="row" style="margin:0">
                                <div class="col-sm-1">
                                <p>
                                    Parallel stanzas:
                                </p>
                                </div>
                                {if ( ( $paral_yr ) and not( $paral_yr =  $stanza_id ) ) then (
                                    <div class="col-sm-1">
                                    <a class="btn btn-overwrite btn-apparatus" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/apparatus.html?stanza_id={$paral_yr}&amp;stanza_location=1" role="button" target="_blank">{$paral_yr}</a>
                                    </div>
                                ) else ()}
                                {if ( ( $paral_y ) and not( $paral_y =  $stanza_id ) ) then (
                                    <div class="col-sm-1">
                                    <a class="btn btn-overwrite btn-apparatus" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/apparatus.html?stanza_id={$paral_y}&amp;stanza_location=2" role="button" target="_blank">{$paral_y}</a>
                                    </div>
                                ) else ()}
                                {if ( ( $paral_vrs ) and not( $paral_vrs =  $stanza_id ) ) then (
                                    <div class="col-sm-1">
                                    <a class="btn btn-overwrite btn-apparatus" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/apparatus.html?stanza_id={$paral_vrs}&amp;stanza_location=3" role="button" target="_blank">{$paral_vrs}</a>
                                    </div>
                                ) else ()}
                                {if ( ( $paral_vs ) and not( $paral_vs =  $stanza_id ) ) then (
                                    <div class="col-sm-1">                        
                                    <a class="btn btn-overwrite btn-apparatus" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/apparatus.html?stanza_id={$paral_vs}&amp;stanza_location=4" role="button" target="_blank">{$paral_vs}</a>
                                    </div>
                                ) else ()}
                                {if ( ( $paral_vyt ) and not( $paral_vyt =  $stanza_id ) ) then (
                                    <div class="col-sm-1">                        
                                    <a class="btn btn-overwrite btn-apparatus" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/apparatus.html?stanza_id={$paral_vyt}&amp;stanza_location=5" role="button" target="_blank">{$paral_vyt}</a>
                                    </div>
                                ) else ()}
                            </div>
                        </div>
                    ) else ()}
                    <div id="stanza_text">
                        <p>Press ∇/Δ to expand or retract the apparatus for each of the stanzas below: </p>
                    </div>                    
                </div>
                {
                 for $i at $po in $value/include
                 let $xpointer := data($i/@xpointer)
                 let $xhref    := data($i/@href)
                 let $xpointer_last := fn:substring( $i/@xpointer, fn:string-length( $i/@xpointer ), 1 )
                    return
                        <div class="tab_float">
                            {
                                if ( contains($xpointer,'Nerang')  ) then (                  
                                        (: ignore nerang :)
                                ) else if ( $xpointer_last = ( '0', '1','2','3','4','5','6','7','8','9' )  
                                            and not( functx:containsall( $xpointer, ( 'AV', 'YAV', 'Ratu', 'Fire', 'Frauuarane', 'Waz', 'Gah', 'Roz', 'Mah' ) ) )
                                        ) then (    
                                            for $z at $pos in collection( $xhref )//div/id($xpointer)/*
                                            let $zpointer := data($z/@xml:id)
                                            let $zpointer_last := fn:substring( data($z/@xml:id), fn:string-length( data($z/@xml:id) ), 1 )
                                                return
                                                    <div>
                                                        <div class="tab_header_apparatus tab_links tab_links_apparatus">
                                                            <button class="tablinks expander" data-toggle="collapse" style="color:white" href="#collapseFrame-{data($pos)}-{$zpointer_last}" role="button" aria-expanded="false" aria-controls="collapseExample">
                                                                Expand ∇ 
                                                            </button>

                                                            <h5 style="float:left">{fn:concat( data($stanza_id), $zpointer_last )}</h5>

                                                        </div>  
                                                        <div class="collapse" id="collapseFrame-{data($pos)}-{$zpointer_last}">
                                                            <div style="background-color:#e0e0e0;">                    
                                                                <iframe width="100%" height="600px" scrolling="no" src="{fn:concat( $tc_link, $stanza_extra, $zpointer_last, $tc_link_end)}">
                                                                </iframe>
                                                            </div>
                                                        </div>
                                                    </div> 
                                        ) else if ( not( functx:containsall( fn:base-uri($i), ( 'header', 'Header' ) ) ) ) then (        (: remove the problem with headers :)
                                            <div>
                                                <div class="tab_header_apparatus tab_links tab_links_apparatus">
                                                    <button class="tablinks expander" data-toggle="collapse" style="color:white" href="#collapseFrame-{$po}-{$xpointer_last}" role="button" aria-expanded="false" aria-controls="collapseExample">
                                                        ∇
                                                    </button> 

                                                    <h5 style="float:left">{if ( functx:containsall( $xpointer, ( 'AV', 'YAV' ) ) ) then ( replace( $xpointer, '([1-9])', '' ) ) else if ( functx:containsall( $xpointer, ( 'Ratu', 'Fire', 'Frauuarane', 'Waz', 'Gah', 'Mah', 'Roz' ) ) ) then ($xpointer) else (fn:substring( $xpointer, 2 ) )}</h5>
        
                                                </div>
                                                <div class="collapse" id="collapseFrame-{$po}-{$xpointer_last}">
                                                    <div style="background-color:#e0e0e0;">  
                                                        <iframe width="100%" height="500px" scrolling="no" 
                                                            src="{fn:concat( $tc_link, $stanza_extra, if ( functx:containsall( $xpointer, ( 'AV', 'YAV' ) ) ) then ( replace( $xpointer, '([1-9])', '' ) ) else if ( functx:containsall( $xpointer, ( 'Frauuarane', 'RatuFra', 'RatuCer', 'FireDed', 'Shnuman', 'Waz' ) ) ) then ( $xpointer ) else ( fn:substring( data($xpointer), fn:string-length( data($xpointer) ), 1 ) ), $tc_link_end)}">
                                                        </iframe>
                                                    </div>
                                                </div>
                                            </div>
                                        ) else ()
                            }
                        </div>
                }
            </div>
};

declare function app:transliterate_passages($node as node(), $model as map(*)) {
    <div id="manuscript_box">
        <div id="manuscript_viewer">
            {
                let $get_passage := request:get-parameter( 'passage'  , '0' )
                let $manuscript_location := "/db/apps/ada_manuscripts/manuscripts/"
                let $paral_location      := "/db/apps/cab_db/cab_parals/"
                
                (: get parals :)
                let $paral := 
                    (for $i in collection( $paral_location )//pair[contains(.,$get_passage)]
                    return
                        $i)[1]
                        
                let $paral_dr  :=  string( $paral//DrYt )
                let $paral_dr_aprox  :=  string( $paral//DrYt_aprox )
                let $paral_yr  :=  string( $paral//YR )
	            let $paral_yr_aprox  :=  string( $paral//YR_aprox )
                let $paral_y   :=  string( $paral//Y )
	            let $paral_y_aprox   :=  string( $paral//Y_aprox )
                let $paral_vrs :=  string( $paral//VrS )
	            let $paral_vrs_aprox :=  string( $paral//VrS_aprox )
                let $paral_vs  :=  string( $paral//VS )
	            let $paral_vs_aprox  :=  string( $paral//VS_aprox )
                let $paral_vyt :=  string( $paral//Vyt )
	            let $paral_vyt_aprox :=  string( $paral//Vyt_aprox )
                
                let $to_compare := ( $paral_dr, $paral_dr_aprox, $paral_yr, $paral_yr_aprox,
                                        $paral_y, $paral_y_aprox, $paral_vrs, $paral_vrs_aprox,
                                        $paral_vs, $paral_vs_aprox, $paral_vyt, $paral_vyt_aprox )
                
                let $passages :=
                    for $i in collection( $manuscript_location )//div[@xml:id = $to_compare]
                    order by util:document-name($i)
                    return
                        <div manuscript="{util:document-name($i)}">
                            {$i}
                        </div>
                    
                for $i in $passages
                return 
                    <div>
                        <div type="stanza" style="display:block"> 
                            <b>Manuscript: {substring-before( data($i/@manuscript), ".xml" )}</b><br/>
                            <b> {data($i/div/@xml:id)}: </b> {$i/div/ab}
                        </div>
                        <br/>
                    </div>
                    
            }
        </div>
    </div>
};

declare function app:transliterate_fullmanuscript($node as node(), $model as map(*)) {
    <div id="manuscript_box_translit">
            {
                let $get_manuscript := replace( request:get-parameter( 'manuscript'  , '-1' ), ' ', '' )
                let $manuscript_location := "/db/apps/ada_manuscripts/manuscripts/"
                let $manuscript_full := 
                    if ( fn:doc-available( concat( $manuscript_location, "yasna/", $get_manuscript, '/' , $get_manuscript, '.xml' ) ) ) then (
                        concat( $manuscript_location, "yasna/", $get_manuscript )
                    ) else if ( fn:doc-available( concat( $manuscript_location, "rapithwin/", $get_manuscript, '/' , $get_manuscript, '.xml' ) )  ) then (
                        concat( $manuscript_location, "rapithwin/", $get_manuscript )
                    ) else if ( fn:doc-available( concat( $manuscript_location, "visperad/", $get_manuscript, '/' , $get_manuscript, '.xml' ) )  ) then (
                        concat( $manuscript_location, "visperad/", $get_manuscript )
                    ) else if ( fn:doc-available( concat( $manuscript_location, "videvdad/", $get_manuscript, '/' , $get_manuscript, '.xml' ) )  ) then (
                        concat( $manuscript_location, "videvdad/", $get_manuscript )
                    ) else if ( fn:doc-available( concat( $manuscript_location, "vishtasp/", $get_manuscript, '/' , $get_manuscript, '.xml' ) ) ) then (
                        concat( $manuscript_location, "vishtasp/", $get_manuscript )
                    ) else ( '0' )
            

                    
                    return
                      
                            <div id="manuscript_viewer">
                                {if ( $manuscript_full eq  '0' ) then (
                                   "Manuscript not found"
                                ) else if ( $get_manuscript eq '-1' ) then ( 
                                    "No manuscript selected yet"
                                ) else (

                                <div>
                                    <h3 id="manuscript-title" style="font-size:20px;font-weight:bold">Manuscript {$get_manuscript}</h3> 
                                    <pb n="{data((for $i in collection( $manuscript_full )//pb
                                            return
                                                $i/@n)[1])}"/>
                                    {

                                        for $i in collection( $manuscript_full )/TEI/text/body/div/*
                                            return
                                                <div type="stanza">{if ( $i/@type ) then ( <b>{data($i/@xml:id)}: </b> ) else ()}
                                                {
                                                    for $y in $i/div
                                                        return
                                                            <div type="stanza">{if ( $y/@type ) then ( <b>{data($y/@xml:id)}: </b> ) else ()}{$y}</div>
                                                }   
                                                </div>
                                    }
                                </div>
                                )}
                            </div>
                        
            }
    </div>
};

declare function app:get_word($node as node(), $model as map(*)) {
    let $aiwid := request:get-parameter( 'id'  , '' )
    let $entry := for $i in collection("/db/apps/cab_db/cab_aiw")//aiw/entry[id eq $aiwid]
                  return
                        $i
                        
    return
        <div>
            <div class="tab_header">
                <h4>{$entry/lemma}</h4>
            </div>  
            <div id="word_text">
                {$entry}
            </div>
        </div>
};

declare function app:quote($node as node(), $model as map(*)) {
    
    let $rd := string(util:random(9))
    let $quote := for $i in collection("/db/apps/cab/quote")//quotes/quote[n eq $rd]
                  return
                        $i/div
    
    return
       $quote
};

declare function app:get_static_search($node as node(), $model as map(*)) {
    let $word   := request:get-parameter( 'word', '' )
    let $param  := request:get-parameter( 'param', '' )
    return
    
        <div>
            <div class="tab_header tab_header_first">
                <h4>
                    Search results for <b>{$word}</b>
                </h4>
                <div style="float:right;color:#ffffff">
                </div>
            </div>
            <div class="tab_header tab_header_first">
                <div class="tab_links">
                    {if ( contains( $param, 1 ) ) then (
                        <button class="tablinks" role="button" onclick="window.location.href='#dron'">Dron</button>
                    ) else ()}
                    {if ( contains( $param, 2 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#yasnar'">Yasna Rapithwin</button>
                    ) else ()}
                    {if ( contains( $param, 3 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#yasna'">Yasna</button>
                    ) else ()}
                    {if ( contains( $param, 4 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#visperad'">Visperad</button>
                    ) else ()}
                    {if ( contains( $param, 5 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#videvdad'">Videvdad</button>
                    ) else ()}
                    {if ( contains( $param, 6 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#vishtasp'">Vishtasp Yasht</button>
                    ) else ()}
                    {if ( contains( $param, 7 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#khordeh'">Khordeh Avesta</button>
                    ) else ()}
                    {if ( contains( $param, 8 ) ) then (
                    <button class="tablinks" role="button" onclick="window.location.href='#blocks'">Blocks</button>
                    ) else ()}
                     <button style="float:right" class="tablinks" role="button" onclick="window.location.href='static.html'">Back to Search Page 
                          <span class="glyphicon glyphicon-search"></span>
                     </button>
               
                </div>
            </div>
            <div id="search_result">
                <p style="padding:20px">
                    <i class="fa fa-circle-half-stroke fa-spin"/> Retrieving word location <i class="fa fa-circle-o-notch fa-spin"/>
                </p>
            </div>

        </div>
};

declare function app:short_db($node as node(), $model as map(*)) {
<ul class="list" >
    {
        for $i at $pos in collection( "/db/apps/cab_manuscripts/manuscripts/")//manuscript[not(@hide) or (@hide ne "1")][position() lt 5] 
        order by ( number($i/siglum_new) )
        return 
                <li class="" val="{$pos}">
                    <div class="entry entry_db">
                        <div class="siglum_db">#{$pos} <b> Siglum: </b> <entry class="siglum_val">{$i/siglum_new}</entry></div>
                        <table>
                        <tr>
                        {
                            if ($i/siglum_old) then (
                                <td><div ><b>Old Siglum: </b> {$i/siglum_old}</div></td>
                            ) else ()
                        }
                        {
                            if ($i/type) then (
                                <td><div><b>Type: </b> <entry class="type_val">{$i/type}</entry></div></td>
                            ) else ()                            
                        }
                        {
                            if ($i/location) then (
                                <td><div ><b>Current Location: </b> 
                                <entry class="location_val">{$i/location}</entry></div></td>
                            ) else ()
                        }
                        </tr>
                        <tr>
                        {
                            if ($i/ms_class) then (
                            <td><div ><b>Manuscript Class: </b>{$i/ms_class}
                                <entry class="msclass_val" style="display:none">{$i/ms_class}</entry>
                            </div></td>
                            ) else ()
                        }

                        {
                            if ($i/date) then (
                                <td><div ><b>Date: </b> <entry class="date_val">{$i/date}</entry></div></td>
                            ) else ()                            
                        }
                        </tr>
                        </table>
                        {
                            if ($i/scribes) then (
                                <div ><b>Scribe(s): </b> <entry class="scribes_val">{$i/scribes}</entry></div>
                            ) else ()
                        }
                    
                    
                        <br/>
                        <div class="collapse" id="collapse-{$pos}">
                            <div id="extended-{$i/siglum_new}">
                                            {
                                                if ($i/notes) then (
                                                    <div class2="col_option col-lg-12"><b>Notes: </b> {$i/notes}</div>
                                                ) else ()
                                            }
                                            
                                            <br/>               
                    
                                            {
                                                if ($i/donator_purchase) then (
                                                    <div class2="col_option col-lg-6" ><b>Donator/Purchase: </b> {$i/donator_purchase}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/ms_history) then (
                                                    <div class2="col_option col-lg-6" ><b>Manuscript History: </b> {$i/ms_history}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/copied_from) then (
                                                    <div class2="col_option col-lg-6"><b>Copied from: </b> {$i/copied_from}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/col_copied_from) then (
                                                    <div class2="col_option col-lg-6"><b>Colophon copied from: </b> {$i/col_copied_from}</div>
                                                ) else ()
                                            }
                                        
                                           
                                            {
                                                if ($i/designation) then (
                                                    <div class2="col_option col-lg-12"><b>Designation: </b> {$i/designation}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/information) then (
                                                    <div class2="col_option col-lg-12"><b>Information: </b> {$i/information}</div>
                                                ) else ()
                                            }
                    
                                        
                                            {
                                                if ($i/language_script) then (
                                                    <div class2="col_option col-lg-6"><b>Language and/or Script: </b> {$i/language_script}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/pictures_used_in_edition) then (
                                                    <div class2="col_option col-lg-6"><b>Pictures used in edition: </b> {$i/pictures_used_in_edition}</div>
                                                ) else ()
                                            }
                    
                    
                                        
                                            <br/>
                                            {
                                                if ($i/col_folio) then (
                                                    <div class2="col_option col-lg-4"><b>Colophon folio: </b> {$i/col_folio}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/col_date) then (
                                                    <div class2="col_option col-lg-4"><b>Colophon date: </b> {$i/col_date}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/col_place) then (
                                                    <div class2="col_option col-lg-4"><b>Colophon place: </b> {$i/col_place}</div>
                                                ) else ()
                                            }
                    
                                            
                                            <br/>
                                            {
                                                if ($i/codicology) then (
                                                    <div class2="col_option col-lg-12"><b>Codicology: </b> {$i/codicology}</div>
                                                ) else ()
                                            }
                    
                                            
                                            {
                                                if ($i/replacements) then (
                                                    <div class2="col_option col-lg-2"><b>Replacements: </b> {$i/replacements}</div>    
                                                ) else ()
                                            }
                                            {
                                                if ($i/measurements) then (
                                                    <div class2="col_option col-lg-3"><b>Measurements: </b> {$i/measurements}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/folio_line_no) then (
                                                    <div class2="col_option col-lg-7"><b>Folio line no: </b> {$i/folio_line_no}</div>
                                                ) else ()
                                            }                        
                                            
                                            {
                                                if ($i/calligraphy) then (
                                                    <div class2="col_option col-lg-12"><b>Calligraphy: </b> {$i/calligraphy}</div>
                                                ) else ()
                                            }                        
                                
                                            {
                                                if ($i/text_quality) then (
                                                    <div class2="col_option col-lg-12"><b>Text Quality: </b> {$i/text_quality}</div>
                                                ) else ()
                                            }                        
                                            
                                            {
                                                if ($i/ms_quality) then (
                                                    <div class2="col_option col-lg-12"><b>Manuscript Quality: </b> {$i/ms_quality}</div>
                                                ) else ()
                                            }                        
                                                                    
                                            <br/>
                                            {
                                                if ($i/texts) then (
                                                    <div class2="col_option col-lg-12" style="padding-bottom:20px"><b>Texts: </b> {for $j in $i//text return <div>{$j} <entry class="texts_val" style="display:none">{data($j/@id)}</entry><br/></div>}</div>
                                                ) else ()
                                            }  
                                            
                                                <div style="background-color: #6d8f60; padding:20px;">
                                                    <div style="text-align:right;"><a target="_blank" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/manuscript_full_viewer.html?manuscript={$i/siglum_new}" style="color:white">See manuscript transliteration <span class="glyphicon glyphicon-list-alt"></span></a></div>
                                                </div>   
                            </div>                 
                        </div>

                        <div class="expand_db">⎯⎯⎯⎯⎯⎯⎯⎯⎯<button class="btn btn-link" data-toggle="collapse" data-target="#collapse-{data($pos)}" style="color:white;" role="button" aria-expanded="false" aria-controls="collapse-{data($pos)}" onclick="LoadDatabaseItem( '{$i/siglum_new}', {$pos})">
                                                        Expand ∇
                                                    </button>⎯⎯⎯⎯⎯⎯⎯⎯⎯</div>
                    </div>

                    
                </li>
    }
</ul>     
};