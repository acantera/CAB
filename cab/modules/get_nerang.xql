xquery version "3.1";

declare variable $nerang_id := request:get-parameter( 'id'  , '0' );

let $header := for $x in collection("/db/apps/cab_db/cab_rituals/nerang/")/div[data(div//div/ab1/@xml:id)[1] eq $nerang_id] return $x/header
        let $nerang_created := for $i in $header/created return $i
        let $nerang_updated := for $i in $header/updated return $i
        let $nerang_creator := for $i in $header/creators return $i
        
        let $stanza_authors := for $i in $nerang_creator/creator
                                    for $j in doc('/db/apps/cab_db/cab_collaborators/collab.xml')//div/collaborator[data(@xml:id) eq data($i)]
                                    return
                                        data($j)
                                        
        let $authors_display := string-join( $stanza_authors, " &amp; " )                                

let $n_transl := for $x in collection("/db/apps/cab_db/cab_rituals/nerang/")//div/div/div/ab1[data(@xml:id) eq replace($nerang_id, 'Transc', 'Translit')]
                    return
                        $x

let $n_transc := for $x in collection("/db/apps/cab_db/cab_rituals/nerang/")//div/div/div/ab1[data(@xml:id) eq $nerang_id]
                    return
                        $x
               
let $n_neng := for $x in collection("/db/apps/cab_db/cab_rituals/nerang/")//div/div/div/ab1[data(@xml:id) eq replace($nerang_id, 'Transc', 'English')]
                    return
                        $x
            
return 
    <nerang>
        <div>
            <div class="nerang_div"><b>Source:</b> Manuscript {data($n_transc/@source)}</div>
            <div class="nerang_div"><b>Transliteration:</b> <d>{data($n_transl)}</d></div>
            <div class="nerang_div"><b>Transcription:</b>   <d class="nerang_red">{data($n_transc)}</d></div>
            <div class="nerang_div"><b>Translation:</b>     <d>{data($n_neng)}</d></div>
            <div><b>Created: </b> {data($nerang_created)}</div>
            <div><b>Updated: </b> {data($nerang_updated)}</div>
            <div><b>Collaborator: </b> {data($authors_display)}</div>
        </div>
    </nerang>                    