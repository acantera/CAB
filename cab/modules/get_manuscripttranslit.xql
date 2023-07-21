xquery version "3.1";
  
let $get_manuscript := request:get-parameter( 'manuscript'  , 'yasna/0005' )
let $manuscript_location := concat( "/db/apps/ada_manuscripts/manuscripts/", $get_manuscript )


    let $first_page := data((for $i in collection( $manuscript_location )//pb
                    return
                        $i/@n)[1])

  return
    <div id="manuscript_box_translit">
        <div id="manuscript_viewer">
            {if ( not( data(substring-after($get_manuscript, '/') ) eq '0' ) ) then ( <h3 id="manuscript-title" style="font-size:20px;font-weight:bold">Manuscript {data(substring-after($get_manuscript, '/') )}</h3> ) else ( "No manuscript selected yet" )}
        
            <div>
                <pb n="{$first_page}"/>
                {

                    for $i in collection( $manuscript_location )/TEI/text/body/div/*
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
        </div>
    </div>     