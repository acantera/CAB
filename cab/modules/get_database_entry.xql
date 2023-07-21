xquery version "3.1";

declare variable $manuscript := request:get-parameter( 'manuscript'  , '-1' );

let $database := for $i in collection( "/db/apps/cab_manuscripts/manuscripts/")/manuscripts/manuscript[(not(@hide) or (@hide ne "1")) and (siglum_new eq $manuscript)]
              
                    return
                        $i

return                        
    <div class="entry entry_db">
                        <div class="siglum_db"><b> Siglum: </b> <entry class="siglum_val">{$database/siglum_new}</entry></div>
                        <table>
                        <tr>
                        {
                            if ($database/siglum_old) then (
                                <td><div ><b>Old Siglum: </b> {$database/siglum_old}</div></td>
                            ) else ()
                        }
                        {
                            if ($database/type) then (
                                <td><div><b>Type: </b> <entry class="type_val">{$database/type}</entry></div></td>
                            ) else ()                            
                        }
                        {
                            if ($database/location) then (
                                <td><div ><b>Current Location: </b> 
                                <entry class="location_val">{$database/location}</entry></div></td>
                            ) else ()
                        }
                        </tr>
                        <tr>
                        {
                            if ($database/ms_class) then (
                            <td><div ><b>Manuscript Class: </b>{$database/ms_class}
                                <entry class="msclass_val" style="display:none">{$database/ms_class}</entry>
                            </div></td>
                            ) else ()
                        }

                        {
                            if ($database/date) then (
                                <td><div ><b>Date: </b> <entry class="date_val">{$database/date}</entry></div></td>
                            ) else ()                            
                        }
                        </tr>
                        </table>
                        {
                            if ($database/scribes) then (
                                <div ><b>Scribe(s): </b> <entry class="scribes_val">{$database/scribes}</entry></div>
                            ) else ()
                        }
                    
                    
                        <br/>
                        <div >
                            <div id="extended-{$database/siglum_new}">
                                            {
                                                if ($database/notes) then (
                                                    <div class2="col_option col-lg-12"><b>Notes: </b> {$database/notes}</div>
                                                ) else ()
                                            }
                                            
                                            <br/>               
                    
                                            {
                                                if ($database/donator_purchase) then (
                                                    <div class2="col_option col-lg-6" ><b>Donator/Purchase: </b> {$database/donator_purchase}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/ms_history) then (
                                                    <div class2="col_option col-lg-6" ><b>Manuscript History: </b> {$database/ms_history}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/copied_from) then (
                                                    <div class2="col_option col-lg-6"><b>Copied from: </b> {$database/copied_from}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/col_copied_from) then (
                                                    <div class2="col_option col-lg-6"><b>Colophon copied from: </b> {$database/col_copied_from}</div>
                                                ) else ()
                                            }
                                        
                                           
                                            {
                                                if ($database/designation) then (
                                                    <div class2="col_option col-lg-12"><b>Designation: </b> {$database/designation}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/information) then (
                                                    <div class2="col_option col-lg-12"><b>Information: </b> {$database/information}</div>
                                                ) else ()
                                            }
                    
                                        
                                            {
                                                if ($database/language_script) then (
                                                    <div class2="col_option col-lg-6"><b>Language and/or Script: </b> {$database/language_script}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/pictures_used_in_edition) then (
                                                    <div class2="col_option col-lg-6"><b>Pictures used in edition: </b> {$database/pictures_used_in_edition}</div>
                                                ) else ()
                                            }
                    
                    
                                        
                                            <br/>
                                            {
                                                if ($database/col_folio) then (
                                                    <div class2="col_option col-lg-4"><b>Colophon folio: </b> {$database/col_folio}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/col_date) then (
                                                    <div class2="col_option col-lg-4"><b>Colophon date: </b> {$database/col_date}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/col_place) then (
                                                    <div class2="col_option col-lg-4"><b>Colophon place: </b> {$database/col_place}</div>
                                                ) else ()
                                            }
                    
                                            
                                            <br/>
                                            {
                                                if ($database/codicology) then (
                                                    <div class2="col_option col-lg-12"><b>Codicology: </b> {$database/codicology}</div>
                                                ) else ()
                                            }
                    
                                            
                                            {
                                                if ($database/replacements) then (
                                                    <div class2="col_option col-lg-2"><b>Replacements: </b> {$database/replacements}</div>    
                                                ) else ()
                                            }
                                            {
                                                if ($database/measurements) then (
                                                    <div class2="col_option col-lg-3"><b>Measurements: </b> {$database/measurements}</div>
                                                ) else ()
                                            }
                                            {
                                                if ($database/folio_line_no) then (
                                                    <div class2="col_option col-lg-7"><b>Folio line no: </b> {$database/folio_line_no}</div>
                                                ) else ()
                                            }                        
                                            
                                            {
                                                if ($database/calligraphy) then (
                                                    <div class2="col_option col-lg-12"><b>Calligraphy: </b> {$database/calligraphy}</div>
                                                ) else ()
                                            }                        
                                
                                            {
                                                if ($database/text_quality) then (
                                                    <div class2="col_option col-lg-12"><b>Text Quality: </b> {$database/text_quality}</div>
                                                ) else ()
                                            }                        
                                            
                                            {
                                                if ($database/ms_quality) then (
                                                    <div class2="col_option col-lg-12"><b>Manuscript Quality: </b> {$database/ms_quality}</div>
                                                ) else ()
                                            }                        
                                                                    
                                            <br/>
                                            {
                                                if ($database/texts) then (
                                                    <div class2="col_option col-lg-12" style="padding-bottom:20px"><b>Texts: </b> {for $j in $database//text return <div>{$j} <entry class="texts_val" style="display:none">{data($j/@id)}</entry><br/></div>}</div>
                                                ) else ()
                                            }  
                                            
                                                <div style="background-color: #6d8f60; padding:20px;">
                                                    <div style="text-align:right;"><a target="_blank" href="https://cab.geschkult.fu-berlin.de/exist/apps/cab/pages/tools/manuscript_full_viewer.html?manuscript={$database/siglum_new}" style="color:white">See manuscript transliteration <span class="glyphicon glyphicon-list-alt"></span></a></div>
                                                </div>   
                            </div>                 
                        </div>

                    </div>
