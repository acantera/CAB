xquery version "3.1";

declare variable $paral := request:get-parameter( 'paralstart'  , '0' );
declare variable $n := request:get-parameter( 'paralend'  , '0' );

let $value := for $x in collection("/db/apps/cab_db/cab_rituals/static/Yasna_static")//div/div/div/ab[data(@xml:id) eq $paral]
    return
        $x
        
return
    if ( $value ) then  (
        $value        
    ) else (
        <div>
            <p>Parallel not found</p>
        </div>
    )