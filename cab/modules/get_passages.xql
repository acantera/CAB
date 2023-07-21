xquery version "3.1";

declare variable $folder := request:get-parameter( 'no'  , '0' );

let $man_loc := concat( "/db/apps/ada_manuscripts/manuscripts/", $folder )


let $value := for $x at $pos in collection( $man_loc )/TEI//div[(@type = "stanza") or (@type = "Stanza")]
                return
                    <div>
                        <a>{data($x/@xml:id)}</a>
                    </div>
            
return  
 <div>
    {
        for $i in $value
        return
            <option>{data($i/a)}</option>
    }
    </div>