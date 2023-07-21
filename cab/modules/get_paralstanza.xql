xquery version "3.1";

(:  :declare option exist:serialize "method=json media-type=text/javascript"; :)
declare variable $main_stanza := request:get-parameter( 'main'  , '' );
declare variable $secondary_liturgy := request:get-parameter( 'paral', '2' );

let $value := for $x in collection("/db/apps/cab_db/cab_parals")//parals/pair[ (data(DrYt) eq $main_stanza) or (data(Y) eq $main_stanza) or (YR eq $main_stanza)
                                                                            or (data(VrS) eq $main_stanza) or (data(VS) eq $main_stanza) or (data(Vyt) eq $main_stanza) ]
    return
        $x

let $get_what := 
        switch ($secondary_liturgy) 
            case "0" return $value/DrYt
            case "1" return $value/YR
            case "2" return $value/Y
            case "3" return $value/VrS
            case "4" return $value/VS
            case "5" return $value/Vyt
                default return -1
      
return
    <result>{data($get_what)}</result>