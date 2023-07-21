xquery version "3.1";

declare variable $ceremony := request:get-parameter( 'ceremony'  , '-1' );

declare variable $get_ceremony := 
        switch ($ceremony) 
            case "0" return "Dron"
            case "1" return "YasnaR"
            case "2" return "Yasna"
            case "3" return "Visperad"
            case "4" return "videvdad"
            case "5" return "Vishtasp"
            case "10" return "Paragna"
                default return 0;


for $i in collection("/db/apps/cab_db/cab_rituals/header")//div/Header[data(@xml:id) eq $get_ceremony]
return
    $i
    