xquery version "3.1";

declare variable $folder := request:get-parameter( 'folder'  , '0' );
declare variable $get_passage := request:get-parameter( 'passage', '0' );

let $man_loc := concat( "/db/apps/ada_manuscripts/manuscripts/", $folder )

let $full_passage := for $x at $pos in collection( $man_loc )/TEI//div[@xml:id = $get_passage]
                return
                    $x
            
return  
    <div id="manuscript_box_translit">
        <div id="manuscript_viewer">
            <b>Passage: {data($get_passage)}</b><br/>
            <div>
                {
                 $full_passage
                }   
            </div>
        </div>
    </div>     