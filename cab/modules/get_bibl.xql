xquery version "3.1";

declare variable $get_ref     := request:get-parameter( 'reference'  , '0' );

let $bibl_ref := for $x in collection( "/db/apps/cab_db/cab_bibliography/" )//div/bibl[data(@xml:id) eq $get_ref]
                    return
                        $x

return
    <bibl_ref>
        {
        if ( data($bibl_ref/@type) eq "book" ) then (
            <entry>
                { if ( data($bibl_ref/author) ) then (
                   <bibl_elem>{data($bibl_ref/author)}, </bibl_elem>
                ) else () }
                
                { if ( data($bibl_ref/title) ) then (
                   <bibl_elem> <i>{data($bibl_ref/title)}</i>, </bibl_elem>
                ) else () }                
                
                { if ( data($bibl_ref/trans) ) then (
                   <bibl_elem> trans. {data($bibl_ref/trans)}, </bibl_elem>
                ) else () 
                    
                }
                
                { if ( data($bibl_ref/publisher) ) then (
                   <bibl_elem> {data($bibl_ref/publisher)}, </bibl_elem>
                ) else () } 
                
                { if ( data($bibl_ref/pubPlace) ) then (
                   <bibl_elem> {data($bibl_ref/pubPlace)}, </bibl_elem>
                ) else () }                 
                
                { if ( data($bibl_ref/date) ) then (
                   <bibl_elem> {data($bibl_ref/date)} </bibl_elem>
                ) else () } 
            </entry>
        ) else if ( data($bibl_ref/@type) eq "article" ) then (
            <entry>
                { if ( data($bibl_ref/author) ) then (
                   <bibl_elem>{data($bibl_ref/author)}, </bibl_elem>
                ) else () }
                
                { if ( data($bibl_ref/title) ) then (
                   <bibl_elem> "{data($bibl_ref/title)}", </bibl_elem>
                ) else () }
                
                { if ( data($bibl_ref/publication) ) then (
                    <bibl_elem> in <i>{data($bibl_ref/publication)}</i></bibl_elem>
                ) else () }

                { if ( data($bibl_ref/issue) ) then (
                    <bibl_elem>, {data($bibl_ref/issue)}</bibl_elem>
                ) else () }
                
                { if ( data($bibl_ref/date) ) then (
                    <bibl_elem>, {data($bibl_ref/date)}</bibl_elem>
                ) else () }
                
                { if ( data($bibl_ref/editors) ) then (
                   <bibl_elem style="margin-left:0px">  
                    { if ( data($bibl_ref/editors/@multiple) eq "yes" ) then (
                            " eds."
                        ) else (
                            " ed."    
                        )
                    }                    
                    {
                        string-join(data($bibl_ref/editors/editor), " and ")
                    }
                    </bibl_elem>
                ) else () }                 
                
                { if ( data($bibl_ref/page) ) then (
                    <bibl_elem>, 
                    {
                        if ( data($bibl_ref/page/@multiple) eq "yes" ) then (
                            "pp. "
                        ) else (
                            "p. "    
                        )
                    }    
                    {data($bibl_ref/page)}</bibl_elem>
                ) else () }

            </entry>
            
        ) else if ( data($bibl_ref/@type) eq "chapter" ) then (
            <entry>
                { if ( data($bibl_ref/author) ) then (
                   <bibl_elem>{data($bibl_ref/author)}, </bibl_elem>
                ) else () }
                
                { if ( data($bibl_ref/title) ) then (
                   <bibl_elem> "{data($bibl_ref/title)}", </bibl_elem>
                ) else () }                
                
                { if ( data($bibl_ref/editors) ) then (
                    
                   <bibl_elem style="margin-left:0px"> in  
                    {
                        string-join(data($bibl_ref/editors/editor), " and ")
                    }
                    {
                        if ( data($bibl_ref/editors/@multiple) eq "yes" ) then (
                            " (eds.)"
                        ) else (
                            " (ed.)"    
                        )
                    }
                    </bibl_elem>
                ) else () } 
                
                { if ( data($bibl_ref/volume) ) then (
                   <bibl_elem>, <i>{data($bibl_ref/volume)}</i></bibl_elem>
                ) else () }                  
                
                { if ( data($bibl_ref/publisher) ) then (
                   <bibl_elem>, {data($bibl_ref/publisher)}</bibl_elem>
                ) else () }                  
                
                { if ( data($bibl_ref/pubPlace) ) then (
                   <bibl_elem>, {data($bibl_ref/pubPlace)}</bibl_elem>
                ) else () }                 
                
                { if ( data($bibl_ref/date) ) then (
                   <bibl_elem>, {data($bibl_ref/date)}</bibl_elem>
                ) else () } 
                
                { if ( data($bibl_ref/page) ) then (
                    <bibl_elem>, 
                    {
                        if ( data($bibl_ref/page/@multiple) eq "yes" ) then (
                            "pp. "
                        ) else (
                            "p. "    
                        )
                    }    
                    {data($bibl_ref/page)}</bibl_elem>
                ) else () }                
            
            </entry>   
            
        ) else ()
        }
    </bibl_ref>
