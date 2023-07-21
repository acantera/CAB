xquery version "3.1";
declare option exist:serialize "method=json media-type=text/javascript";

declare variable $stanza_id := request:get-parameter( 'stanza'  , '0' );

let $value := for $x in collection("/db/apps/cab_db/cab_grammar")//text[data(@xml:id) eq $stanza_id]
    return
        $x
        
return
    concat("work=",data($value/@work), "&amp;", "book=",data($value/@book), "&amp;", "paragraph=",data($value/@paragraph) )
    