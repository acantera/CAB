xquery version "3.1";

declare variable $get_abbrev  := request:get-parameter( 'abbrev'  , '' );
declare variable $get_left    := request:get-parameter( 'left'    , '' );
declare variable $get_right   := request:get-parameter( 'right'   , '' );

let $abbrev := for $x in collection( "/db/apps/1_ada_cab_manuscripts/abbrevs/" )/abbreviations/abbrev[data(@form) eq $get_abbrev]
                    return
                        $x
                        
(:  :return
    <span>
        {data($abbrev)}
    </span>:)
    
return
    if ( count($abbrev) <= 1 )  then (
        <span>
            {data($abbrev)}
        </span>    
    ) else (
        let $left := for $x in $abbrev[data(@id_left) eq $get_left]
                     return $x
        let $right := for $x in $abbrev[data(@id_right) eq $get_right]
                     return $x             
                     
        let $result := if ( $left ) then (
                            <span>
                                {data($left)}
                            </span>
                        ) else if ( $right ) then (
                            <span>
                                {data($right)}
                            </span>
                        ) else (
                            <span>
                                {data($abbrev)}
                            </span>   
                        )
                        
        return
            $result
    )
    
    
