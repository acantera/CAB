xquery version "3.1";

declare namespace functx = "http://www.functx.com"; 

declare function functx:containsall
  ( $arg as xs:string? ,
    $searchStrings as xs:string* )  as xs:boolean {

   some $searchString in $searchStrings
   satisfies contains($arg,$searchString)
};
 
declare function functx:is-node-in-sequence-deep-equal
  ( $node as node()? ,
    $seq as node()* )  as xs:boolean {

   some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq,$node)
};
 
declare function functx:distinct-deep
  ( $nodes as node()* )  as node()* {

    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(functx:is-node-in-sequence-deep-equal(
                          .,$nodes[position() < $seq]))]
};

declare option exist:serialize "method=json media-type=text/javascript";
declare variable $get_request := request:get-parameter( 'column'  , '0' );

let $class := for $i in  collection( "/db/apps/cab_manuscripts/classes/" )/text
                  (: order by  fn:lower-case(fn:normalize-unicode( $i/ms_class, 'NFKD' ) ) ascending :)
                  return
                    $i/msclass

let $locations := for $i in  collection( "/db/apps/cab_manuscripts/manuscripts/" )/manuscripts/manuscript/location
                  order by $i ascending
                  return
                    $i
                    
let $col_date := for $i in  collection( "/db/apps/cab_manuscripts/manuscripts/" )/manuscripts/manuscript
                  order by $i/col_date ascending
                  return
                    $i/col_date                      
                    
let $col_scribe := for $i in  collection( "/db/apps/cab_manuscripts/manuscripts/" )/manuscripts/manuscript/scribes/scribe
                   order by  fn:lower-case(fn:normalize-unicode( $i, 'NFKD' ) ) ascending
                      return
                        $i   
                    
let $texts := for $i in  collection( "/db/apps/cab_manuscripts/texts/" )/texts
                  (:order by $i/texts ascending :)
                  return
                    $i/text

let $result := 
        switch ($get_request) 
            case "0" return $class
            case "1" return $locations
            case "2" return $col_date
            case "3" return $col_scribe
            case "4" return $texts
                default return '0'           
                    
return
    if ( functx:containsall( string($get_request), ( "0" ) ) ) then (
        <div>
        {for $i in functx:distinct-deep($result)
            return
                <type>{data($i)}§{if (data($i/@id)) then (data($i/@id)) else ()}</type>
        }
        </div>
    ) else if ( functx:containsall( string($get_request), ( "4" ) ) ) then (
        <div>
        {for $i in $result
            return
                <type>{data($i)}§{if (data($i/@id)) then (data($i/@id)) else ()}</type>
        }
        </div>
    ) else (
        <div>
        {for $i in distinct-values($result)
            return
                <type>{$i}</type>
        }
        </div>    
    )