xquery version "3.1";

declare variable $man_type := request:get-parameter( 'type'  , '0' );

let $man_loc := concat( "/db/apps/ada_manuscripts/manuscripts/", $man_type , "/" )

let $value := for $x at $pos in collection( $man_loc )/TEI
    return
                    fn:replace( util:document-name($x), '.xml', '' )
return  
    <div>
    {
        for $i in $value    
        order by $i
        return
            <option>{$i}</option>
    }
    </div>