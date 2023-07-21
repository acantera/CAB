$class = "";
$designation = "";
$location = "";
$col_date = "";
$col_scribe = "";
$texts = "";

$(document).ready(function(){   
    populate_conditions( 1 );
    
    // get column values
    $class = get_designations(0);   
    $class = $class.type;
    $class.unshift('');
    $location = get_designations(1);
    $location = $location.type;
    $location.unshift('');
    $col_date = get_designations(2);
    $col_date = $col_date.type;
    $col_date.unshift('');
    $col_scribe = get_designations(3);
    $col_scribe = $col_scribe.type;
    $col_scribe.unshift('');
    $texts = get_designations(4);
    $texts = $texts.type;
    $texts.unshift('');
    
    $( "#get-condition_one" ).on('change', function() {
        if (  $( "#get-condition_one" ).val() == -1 ) {
            $( "#selector_two_full" ).css( 'display', 'none' );
            $( "#selector_three_full" ).css( 'display', 'none' );
            populate_selectors( -1 );
            FilterConditions();
            populate_conditions( 2 );
            
        } else {
            populate_selectors( 1 );
            FilterConditions();
            $( "#selector_two_full" ).css( 'display', 'none' );
            $( "#selector_three_full" ).css( 'display', 'none' );
        }

    });
    
    $(document).on( 'keyup change', '.cond-one', function() {
        $( "#selector_two_full" ).css( 'display', 'inline' );
        if (  $( "#get-condition_two" ).val() == -1 ) {
            $( "#selector_three_full" ).css( 'display', 'none' );
        }
        if (  $( "#get-condition_two" ).val() == -1 ) {
            populate_conditions( 2 );
    
        }
        
        if (  $( "#get-condition_three" ).val() == -1 ) {
            populate_conditions( 3 );
        }
        
    });
    
    $( "#get-condition_two" ).on('change', function() {
        if (  $( "#get-condition_two" ).val() == -1 ) {
            $( "#selector_three_full" ).css( 'display', 'none' );
            populate_selectors( 2 );
        } else {
            populate_selectors( 2 );
            populate_conditions( 3 );
            FilterConditions();
            $( "#selector_three_full" ).css( 'display', 'none' );
        }        
    });    
    
    $(document).on( 'keyup change', '.cond-two', function() {
        $( "#selector_three_full" ).css( 'display', 'inline' );
        if (  $( "#get-condition_three" ).val() == -1 ) {
            populate_conditions( 3 );
        }
    });    
    
    $( "#get-condition_three" ).on('change', function() {
        populate_selectors( 3 );
        FilterConditions();
    });
    
    $('button').click(function(){ //you can give id or class name here for $('button')
        if ($(this).text().trim() == 'Expand ∇') {
            $(this).text('Collapse Δ');
        } else {
            $(this).text('Expand ∇');
        }

    });
    
});

function populate_conditions( $i )
{
    const $options = [ "Siglum (new)", "Siglum (old)" , "Date", "Type", "Ms. Class", "Current Location", "Scribe", "Texts", "Anything" ];
    
    $cond_no = "#get-condition_one";
    $selector_no = "#selector-options_one";
    if ( $i == 1 ) {
        $cond_no     = "#get-condition_one";
        $selector_no = "#selector-options_one";
    } else if ( $i == 2 ) {
        $cond_no     = "#get-condition_two";
        $selector_no = "#selector-options_two";
    } else if ( $i == 3 ) {
        $cond_no     = "#get-condition_three";
        $selector_no = "#selector-options_three";
    }
    
    // empty
    $( $cond_no ).empty().append('<option value="-1" default="true"/>');
    $( $selector_no ).empty();

    // add values

    $cond_one   = $( "#get-condition_one" ).val();
    $cond_two   = $( "#get-condition_two" ).val();
    $cond_three = $( "#get-condition_three" ).val();
    
    for ( $j = 0; $j <= $options.length - 1; $j++ ) {
        if ( ( $i == 1 ) || ( $i == 2 ) && ( $cond_one != $j ) || ( $i == 3 ) && ( $cond_one != $j )  && ( $cond_two != $j ) ) {
            $( $cond_no ).append(new Option( $options[$j], $j ));
        }
    }
    
}

function populate_selectors( $i )
{
    $cond_no = 0;
    $val_get = 0;
    $val = ""

    if ( $i == 1 )  {
        $val_get = "#get-condition_one";
        $cond_no = "#selector-options_one";
        $val = "cond-one";
    } else if ( $i == 2 ) {
        $val_get = "#get-condition_two";
        $cond_no = "#selector-options_two";
        $val = "cond-two";
    } else if ( $i == 3 ) {
        $val_get = "#get-condition_three";
        $cond_no = "#selector-options_three";
        $val = "cond-three";
    } else if ( $i == 5 ) {
        $val_get = "#get-condition_five";
        $cond_no = "#selector-options_five";
        $val = "cond-five";
    } else if ( $i == -1 )  {
        $val_get = "#get-condition_one";
        $cond_no = "#selector-options_one";
        $val = "";
    }
    
    $cond_val = $( $val_get ).val();

    $( $cond_no ).empty();  // remove previous selection

    if ( $cond_val == 0 )   {
        $( $cond_no ).append( '<label class="label-general">Siglum (New): </label>' );
        $( $cond_no ).append( '<input id="siglum_search" type="text" class="search ' + $val + ' form-control" placeholder="Search (single value or range, e.g. 2005-3020)" style="display: block;width: 100%"/>' );
    } else if ( $cond_val == 1 ) {
        $( $cond_no ).append( '<label class="label-general">Siglum (Old): </label>' );
        $( $cond_no ).append( '<input id="siglum_search_old" type="text" class="search ' + $val + ' form-control" placeholder="Search" style="display: block;width: 100%"/>' );
    } else if ( $cond_val == 2 )    {
        $( $cond_no ).append( '<div id="date-condition" class="col_option col-lg-6"></div>' );
            $( "#date-condition" ).append( '<label class="label-general">Condition: </label>' );
            $( "#date-condition" ).append( '<select id="get-date" name="get-date" class="form-control"></select>' );
                // $( '#get-date' ).append( '<option value="-1" default="true"/>' );
                $( '#get-date' ).append( '<option value="0" default="true">Containing value</option>' );
                $( '#get-date' ).append( '<option value="1" default="true">Exact date</option>' );
                $( '#get-date' ).append( '<option value="2">Earlier than (and including)</option>' );              
                $( '#get-date' ).append( '<option value="3">Later than (and including)</option>' );
                $( '#get-date' ).append( '<option value="4">Between (start-end date)</option>' );
        $( $cond_no ).append( '<div id="date-search" class="col_option col-lg-6"></div>' );                                
            $( "#date-search" ).append( '<label class="label-general">Date: </label>' );                                
            $( "#date-search" ).append( '<input id="date_search" type="text" class="search ' + $val + ' form-control" placeholder="Date" style="display: block;width: 100%"/>' );                        
                        
    } else if ( $cond_val == 3 )    {
        $( $cond_no ).append( '<label class="label-type label-general">Type: </label>' );
        $( $cond_no ).append( '<select id="get-type" name="get-type" class="form-control ' + $val + '">' );
            $( '#get-type' ).append( '<option value="-1" default="true"/>' );
            $( '#get-type' ).append( '<option value="0">Indian</option>' );
            $( '#get-type' ).append( '<option value="1">Iranian</option>' );
        $( $cond_no ).append( '</select>' );
    } else if ( $cond_val == 4 )    {
        $( $cond_no ).append( '<label class="label-class label-general">Class: </label>' );
        $( $cond_no ).append( '<select id="get-class" name="get-class" class="form-control ' + $val + '">' );
        
        for ( $j = 0; $j <= $class.length - 1; $j++ ) {
            $( '#get-class' ).append(new Option( $class[$j].substr(0, $class[$j].indexOf('§')), $class[$j].substr( $class[$j].indexOf('§') + 1, $class[$j].length ))); 
        }
    } else if ( $cond_val == 5 )    {
        $( $cond_no ).append( '<label class="label-location label-general">Location: </label>' );
        $( $cond_no ).append( '<select id="get-location" name="get-location" class="form-control ' + $val + '">' );
        
        for ( $j = 0; $j <= $location.length - 1; $j++ ) {
            $( '#get-location' ).append(new Option( $location[$j], $j ));
        }   
    } else if ( $cond_val == 6 )    {
        $( $cond_no ).append( '<div id="scribe-condition" class="col_option col-lg-3"></div>' );
            $( "#scribe-condition" ).append( '<label class="label-general">Condition: </label>' );
            $( "#scribe-condition" ).append( '<select id="get-scribe" name="get-date" class="form-control"></select>' );
                $( '#get-scribe' ).append( '<option value="0" default="true">List of Scribes</option>' );
                $( '#get-scribe' ).append( '<option value="1" default="true">Scribe Name</option>' );
        $( $cond_no ).append( '<div id="scribe-search" class="col_option col-lg-9"></div>' );                                
            $( "#scribe-search" ).append( '<label class="label-col_scribe label-general label-scribes-one">Scribe(s): </label>' );
            $( "#scribe-search" ).append( '<select id="get-col_scribe" name="get-col_scribe" class="col_option col-lg-9 form-control ' + $val + '">' );
            for ( $j = 0; $j <= $col_scribe.length - 1; $j++ ) {
                $( '#get-col_scribe' ).append(new Option( $col_scribe[$j], $j ));
            } 
            $( "#scribe-search" ).append( '<label class="label-col_scribe label-general label-scribes-two" style="display:none">Containing Scribe Name: </label>' );
            $( "#scribe-search" ).append( '<input id="scribe_search" type="text" class="search ' + $val + ' form-control" placeholder="Scribe Name" style="display: none;width: 100%"/>' );
        
    } else if ( $cond_val == 7 )    {
        $( $cond_no ).append( '<label class="label-texts label-general">Text(s): </label>' );
        $( $cond_no ).append( '<select id="get-texts" name="get-texts" class="form-control ' + $val + '">' );
        
        for ( $j = 0; $j <= $texts.length - 1; $j++ ) {
            $( '#get-texts' ).append(new Option( $texts[$j].substr(0, $texts[$j].indexOf('§')), $texts[$j].substr( $texts[$j].indexOf('§') + 1, $texts[$j].length ))); 
        } 
        
    } else if ( $cond_val == 8 )    {
        $( $cond_no ).append( '<label class="label-anything label-general">Search all fields: </label>' );
        $( $cond_no ).append( '<input id="anything_search" type="text" class="search ' + $val + ' form-control" placeholder="Search" style="display: block;width: 100%"/>' );
        
    }

}

function get_designations( $i )
{
    var $link = "";
        $link = $link.concat( "https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/db_getcolumns.xql?column=", $i );
    
    var $result = '';
    
    $.ajax({
                    
        url: $link,
        async: false,
            
        success: function( data ) {
            $result = data;
        },
        
        error: function () {
            alert("problem");
        },
            
        type: "GET",
        dataType: "JSON",
        processData: false,  // tell jQuery not to process the data
        contentType: false   // tell jQuery not to set contentType
                       
    }).done(function( data ) {
        //console.log(data);
    });   

    return $result;
}