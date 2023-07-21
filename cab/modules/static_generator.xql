xquery version "3.1";

declare namespace functx = "http://www.functx.com";
(: Variables to be taken from input :) 

declare variable $get_ritual := request:get-parameter( 'ceremony'  , '2' );
(: dron - 0; y rapithwin - 1; y - 2; vsp - 3; v - 4; vish - 5 :)

(: Get from files :)
declare variable $ritual := 
        switch ($get_ritual) 
            case "0" return "/db/apps/cab_db/cab_statics/Static_Dron/"
            case "1" return "/db/apps/cab_db/cab_statics/Static_YasnaR/"
            case "2" return "/db/apps/cab_db/cab_statics/Static_Yasna/"
            case "3" return "/db/apps/cab_db/cab_statics/Static_Visperad/"
            case "4" return "/db/apps/cab_db/cab_statics/Static_Visperad_DH/"
            case "5" return "/db/apps/cab_db/cab_statics/Static_Videvdad/"
            case "6" return "/db/apps/cab_db/cab_statics/Static_Vishtasp/"
                default return 0;
                                
for $i in collection( $ritual )/TEI
    return
        $i