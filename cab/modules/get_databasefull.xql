xquery version "3.1";

let $database := for $i in collection( "/db/apps/cab_manuscripts/manuscripts/")//manuscript[not(@hide) or (@hide ne "1")]
                order by ( number($i/siglum_new) )
                    return
                        $i

return                        
<ul class="list" >
    {
        for $i at $pos in $database
        order by ( number($i/siglum_new) )
        return 
                <li class="" val="{$pos}">
                    <div class="entry entry_db">
                        <div class="siglum_db">#{$pos} <b> Siglum: </b> <entry class="siglum_val">{$i/siglum_new}</entry></div>
                        <table>
                        <tr>
                        {
                            if ($i/siglum_old) then (
                                <td><div ><b>Old Siglum: </b> <entry class="siglum_val_old">{$i/siglum_old}</entry></div></td>
                            ) else ()
                        }
                        {
                            if ($i/type) then (
                                <td><div><b>Type: </b> <entry class="type_val">{$i/type}</entry></div></td>
                            ) else ()                            
                        }
                        {
                            if ($i/location) then (
                                <td><div ><b>Current Location: </b> 
                                <entry class="location_val">{$i/location}</entry></div></td>
                            ) else ()
                        }
                        </tr>
                        <tr>
                        {
                            if ($i/ms_class) then (
                            <td><div ><b>Manuscript Class: </b>{$i/ms_class}
                                <entry class="msclass_val" style="display:none">{$i/ms_class}</entry>
                            </div></td>
                            ) else ()
                        }

                        {
                            if ($i/date) then (
                                <td><div ><b>Date: </b> <entry class="date_val">{$i/date}</entry></div></td>
                            ) else ()                            
                        }
                        </tr>
                        </table>
                        {
                            if ($i/scribes) then (
                                <div ><b>Scribe(s): </b> <entry class="scribes_val">{$i/scribes}</entry></div>
                            ) else ()
                        }
                    
                    
                        <br/>
                        <div class="collapse" id="collapse-{$pos}">
                            <div id="extended-{$i/siglum_new}">
                                            {
                                                if ($i/notes) then (
                                                    <div ><b>Notes: </b> {$i/notes}</div>
                                                ) else ()
                                            }
                                            
                                            <br/>               
                    
                                            {
                                                if ($i/donator_purchase) then (
                                                    <div  ><b>Donator/Purchase: </b> {$i/donator_purchase}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/ms_history) then (
                                                    <div  ><b>Manuscript History: </b> {$i/ms_history}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/copied_from) then (
                                                    <div ><b>Copied from: </b> {$i/copied_from}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/col_copied_from) then (
                                                    <div ><b>Colophon copied from: </b> {$i/col_copied_from}</div>
                                                ) else ()
                                            }
                                        
                                           
                                            {
                                                if ($i/designation) then (
                                                    <div ><b>Designation: </b> {$i/designation}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/information) then (
                                                    <div ><b>Information: </b> {$i/information}</div>
                                                ) else ()
                                            }
                    
                                        
                                            {
                                                if ($i/language_script) then (
                                                    <div ><b>Language and/or Script: </b> {$i/language_script}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/pictures_used_in_edition) then (
                                                    <div ><b>Pictures used in edition: </b> {$i/pictures_used_in_edition}</div>
                                                ) else ()
                                            }
                    
                    
                                        
                                            <br/>
                                            {
                                                if ($i/col_folio) then (
                                                    <div ><b>Colophon folio: </b> {$i/col_folio}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/col_date) then (
                                                    <div ><b>Colophon date: </b> {$i/col_date}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/col_place) then (
                                                    <div ><b>Colophon place: </b> {$i/col_place}</div>
                                                ) else ()
                                            }
                    
                                            
                                            <br/>
                                            {
                                                if ($i/codicology) then (
                                                    <div ><b>Codicology: </b> {$i/codicology}</div>
                                                ) else ()
                                            }
                    
                                            
                                            {
                                                if ($i/replacements) then (
                                                    <div ><b>Replacements: </b> {$i/replacements}</div>    
                                                ) else ()
                                            }
                                            {
                                                if ($i/measurements) then (
                                                    <div ><b>Measurements: </b> {$i/measurements}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($i/folio_line_no) then (
                                                    <div ><b>Folio line no: </b> {$i/folio_line_no}</div>
                                                ) else ()
                                            }                        
                                            
                                            {
                                                if ($i/calligraphy) then (
                                                    <div ><b>Calligraphy: </b> {$i/calligraphy}</div>
                                                ) else ()
                                            }                        
                                
                                            {
                                                if ($i/text_quality) then (
                                                    <div ><b>Text Quality: </b> {$i/text_quality}</div>
                                                ) else ()
                                            }                        
                                            
                                            {
                                                if ($i/ms_quality) then (
                                                    <div ><b>Manuscript Quality: </b> {$i/ms_quality}</div>
                                                ) else ()
                                            }                        
                                                                    
                                            <br/>
                                            {
                                                if ($i/texts) then (
                                                    <div  style="padding-bottom:20px"><b>Texts: </b> {for $j in $i//text return <div>{$j} <entry class="texts_val" style="display:none">{data($j/@id)}</entry><br/></div>}</div>
                                                ) else ()
                                            }  
                                            
                                                <div style="background-color: #6d8f60; padding:20px;">
                                                    <div style="text-align:right;"><a target="_blank" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/manuscript_full_viewer.html?manuscript={$i/siglum_new}" style="color:white">See manuscript transliteration <span class="glyphicon glyphicon-list-alt"></span></a></div>
                                                </div>   
                            </div>                 
                        </div>

                        <div class="expand_db">⎯⎯⎯⎯⎯⎯⎯⎯⎯<button class="btn btn-link" data-toggle="collapse" data-target="#collapse-{data($pos)}" style="color:white;" role="button" aria-expanded="false" aria-controls="collapse-{data($pos)}" onclick="LoadDatabaseItem( '{$i/siglum_new}', {$pos})">
                                                        Expand ∇
                                                    </button>⎯⎯⎯⎯⎯⎯⎯⎯⎯</div>
                    </div>

                    
                </li>
    }
</ul>     