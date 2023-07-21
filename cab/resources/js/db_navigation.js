var $showing = 0;   
var $full_db = 0;

$(document).ready(function(){    
    
    LoadDatabase();
    
    var $perPage = 10;
    
    manuscriptList = new List('man-db-list', {
        valueNames: ['entry','siglum_val', 'siglum_val_old', 'date_val' , 'type_val', 'msclass_val', 'location_val', 'scribes_val', 'texts_val'],
        page: $perPage,
        pagination: true
    });
    
    $showing = manuscriptList.size();       
    NoManuscripts();
 
    function isLessThan(a, b) {
        return Object.is((a-b)%1, -0);
    }        
        
    $('.nav').append('<div class="btn-next navig-arrow"> › </div>');
    $('.nav').prepend('<div class="btn-prev navig-arrow"> ‹ </div>');
        
    $('.nav').append('<div class="btn-last navig-arrow navig-arrow-right"> » </div>');
    $('.nav').prepend('<div class="btn-first navig-arrow navig-arrow-left"> « </div>');

    var $i = 1;
    $('.btn-next').on('click', function(){
        $i = $('li.active').find('a').attr('data-i');
      
        if ( manuscriptList.filtered ) {
            if ( isLessThan( $i + 1, manuscriptList.update().matchingItems.length ) ) {
                $i = $i * $perPage;
                manuscriptList.show( $i + 1, $perPage );
            }
                
		} else {
		    if ( ($i + 1)  <= manuscriptList.size() ) {
                $i = $i * $perPage;
                manuscriptList.show( $i + 1, $perPage );
            }    
		}            
            
    })

    $('.btn-prev').on('click', function(){
            $i = $('li.active').find('a').attr('data-i') - 2;
            if ( isLessThan( -1, $i ) ) {
                $i = $i * $perPage;
                manuscriptList.show( $i + 1, $perPage );
            }
    })

    $('.btn-first').on('click', function(){
        manuscriptList.show( 1, $perPage );
    })
    
    $('.btn-last').on('click', function(){
        if ( manuscriptList.filtered ) {
            if ( manuscriptList.update().matchingItems.length == manuscriptList.size() )    {
                manuscriptList.show( manuscriptList.size() - manuscriptList.size() % $perPage + 1, $perPage );  
            } else {
                manuscriptList.show( manuscriptList.update().matchingItems.length - manuscriptList.update().matchingItems.length % $perPage + 1, $perPage );
            }
		} else {
		    var $per_page = $perPage;
		    if ( manuscriptList.size() % $perPage != 0 )    {
		        $per_page = manuscriptList.size() % $perPage;
		    } 
            manuscriptList.show( manuscriptList.size() - $per_page + 1, $perPage );
          
		}
		    
    })
        
});    

function NoManuscripts()
{
    $('#man_results').html( $showing );
}

function FilterConditions()
{
    var $nConditions = 0;
    var $aConditionsVal = [];
    var $aConditionsType = [];
    
    var $siglumCond = 0;
    
    var $DateCond = 0;

    if ( $( '#siglum_search' ).length )  {
        var $searchString = $( "#siglum_search" ).val();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'siglum';
        $nConditions++;
    }
    
    if ( $( '#siglum_search_old' ).length )  {
        var $searchString = $( "#siglum_search_old" ).val();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'siglum_old';
        $nConditions++;
    }    
    
    if ( $( '#get-type' ).length )  {
        var $Type = $( "#get-type" ).val();
        var $TypeName = "";
        
        if ( $Type == 0 )   {
            $TypeName = "indian";    
        } else if ( $Type == 1 )    {
            $TypeName = "iranian";    
        }
        
        $aConditionsVal[$nConditions] = $TypeName;
        $aConditionsType[$nConditions] = 'type';
        $nConditions++;
    }
    
    if ( $( '#get-class' ).length )  {
        var $searchString = $( "#get-class" ).val();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'msclass';
        $nConditions++;
    }  
    
    if ( $( '#date_search' ).length )  {
        var $searchString = $( "#date_search" ).val();
    
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'date';
        $nConditions++;
        
        $DateCond = $( "#get-date" ).val();
    }    
    
    if ( $( '#get-location' ).length )  {
        var $searchString = $( "#get-location option:selected" ).text();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'location';
        $nConditions++;
    }   
    
    if ( $( '#get-col_scribe' ).length )  {
        var $searchString = $( "#get-col_scribe option:selected" ).text();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'scribe';
        $nConditions++;
    } 
    
    if ( $( '#scribe_search' ).length )  {
        var $searchString = $( "#scribe_search" ).val();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'scribe';
        $nConditions++;
        
        $ScribeCond = $( "#get-scribe" ).val();
    }    
    
    if ( $( '#get-texts' ).length )  {
        var $searchString = $( "#get-texts" ).val();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'texts';
        $nConditions++;
    }      
    
    if ( $( '#anything_search' ).length )  {
        var $searchString = $( "#anything_search" ).val();
        $aConditionsVal[$nConditions] = $searchString;
        $aConditionsType[$nConditions] = 'anything';
        $nConditions++;
    }      
    
    $showing = 0;
    
    manuscriptList.filter(function(item) {
        var $toDo = 0;
        for ( i = 0; i < $nConditions; i++) {
            if ( $aConditionsType[i] == 'siglum' )  {
                if ( ( $aConditionsVal[i].includes('-') ) || ( $aConditionsVal[i].includes('–') ) ) {
                    
                    var $lineChar = '-';
                    if ( $aConditionsVal[i].includes('–') ) {
                        $lineChar = '–';
                    }
                    
                    var $startRange = $aConditionsVal[i].substring(0, $aConditionsVal[i].indexOf( $lineChar ) );
                    var $endRange   = $aConditionsVal[i].substring( $aConditionsVal[i].indexOf( $lineChar ) + 1, $aConditionsVal[i].length );
                    
                    var $currentVal = item.values().siglum_val.match(/\d+/);
                    
                    if ( 
                            ( parseInt($startRange) <= parseInt($currentVal) ) && 
                            ( parseInt($endRange)   >= parseInt($currentVal) ) 
                        ) {
                        $toDo++;
                    }
                    
                } else if ( ~item.values().siglum_val.indexOf( $aConditionsVal[i] ) )  {
                    $toDo++;
                }
            
            } else if ( $aConditionsType[i] == 'siglum_old' )  {
                
                var currentVal = item.values().siglum_val_old.toLowerCase();

                if ( ~currentVal.indexOf( $aConditionsVal[i].toLowerCase() ) )  {
                    $toDo++;
                }
                
            } else if ( $aConditionsType[i] == 'type' )  {
        
              var currentVal = item.values().type_val.toLowerCase();
            
              if (  $aConditionsVal[i] == "" )  {
                    $toDo++;
              } else if ( currentVal.length != 0 )   {
                    if ( ~currentVal.indexOf( $aConditionsVal[i] ) ) {                    
                        $toDo++;
                    } 
              } 

            } else if ( $aConditionsType[i] == 'date' )  {
               
                if ( $DateCond == 0 )   {
                    if ( ~item.values().date_val.indexOf( $aConditionsVal[i] ) )  {
                        $toDo++;
                    }               
                    
                } else {

                    
                    var $nCond = parseInt($aConditionsVal[i]);
                    var $nDate = item.values().date_val.match(/\d+/);
                

                    if ( ( $DateCond == 1 ) && ( $nCond == $nDate ) )   {
                        $toDo++;
                    } else if ( ( $DateCond == 2 ) && ( $nCond >= $nDate ) )   {
                        $toDo++;
                    } else if ( ( $DateCond == 3 ) && ( $nCond <= $nDate ) )   {
                        $toDo++;
                    } else if ( $DateCond == 4 )    {
                        
                        if ( ( $aConditionsVal[i].includes('-') ) || ( $aConditionsVal[i].includes('–') ) ) {
                       
                                var $lineChar = '-';
                                if ( $aConditionsVal[i].includes('–') ) {
                                    $lineChar = '–';
                                }

                                var $startRange = $aConditionsVal[i].substring( 0, $aConditionsVal[i].indexOf( $lineChar ) );
                                var $endRange   = $aConditionsVal[i].substring( $aConditionsVal[i].indexOf( $lineChar ) + 1, $aConditionsVal[i].length );

                                if ( 
                                        ( parseInt($startRange) <= $nDate ) && 
                                        ( parseInt($endRange)   >= $nDate ) 
                                    ) {
                                    $toDo++;
                                }
                        
                        }
                        
                    }
                    
                }
            
            } else if ( $aConditionsType[i] == 'msclass' )  {
                 if ( ~item.values().msclass_val.indexOf( $aConditionsVal[i] ) )  {
                    $toDo++;
                }            
                
            } else if ( $aConditionsType[i] == 'location' )  {
                 if ( ~item.values().location_val.indexOf( $aConditionsVal[i] ) )  {
                    $toDo++;
                }                  

            } else if ( $aConditionsType[i] == 'scribe' )  {

                if ( $ScribeCond == 0 )   {
                    if ( ~item.values().scribes_val.indexOf( $aConditionsVal[i] ) )  {
                        $toDo++;
                    }                 
                    
                } else if ( $ScribeCond == 1 ) {
                    var $nScribe = $searchString.toLowerCase();
                    console.log($nScribe);
                    if ( $nScribe.length != 0 )   {
                        if ( ~item.values().scribes_val.toLowerCase().normalize('NFD').indexOf( $nScribe ) )  {                    
                            $toDo++;
                        }
                    }                     
                }
                
            } else if ( $aConditionsType[i] == 'texts' )  {
                 if ( ~item.values().texts_val.indexOf( $aConditionsVal[i] ) )  {
                    $toDo++;
                }                

            } else if ( $aConditionsType[i] == 'anything' )  {
                 if ( ~item.values().entry.indexOf( $aConditionsVal[i] ) )  {
                    $toDo++;
                }               
            }
            
        } 
        
        if ( $toDo == $nConditions )    {
            $showing++;
            return true;
        } else {
            return false;
        }
    });    
    
    NoManuscripts();
}

$(document).on( 'keyup', '#siglum_search', function() {
    FilterConditions();
});

$(document).on( 'keyup', '#siglum_search_old', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-type', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-date', function() {
    FilterConditions();
});

$(document).on( 'keyup', '#date_search', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-class', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-location', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-col_scribe', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-scribe', function() {
    SetScribeSelector();
    FilterConditions();
});

$(document).on( 'keyup', '#scribe_search', function() {
    FilterConditions();
});

$(document).on( 'change', '#get-texts', function() {
    FilterConditions();
});

$(document).on( 'keyup', '#anything_search', function() {
    FilterConditions();
});

function LoadDatabase()
{
    var $link = "";
    
    $link = $link.concat( 'https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_databasefull.xql' );
   
    $.ajax({
                    
            url: $link,
            async: false,
            success: function( data ) {
                var $val_data = xmlToString(data);
                $( '#full_database' ).html( $val_data );                
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });
}

function SetScribeSelector()
{
    var $scribeType = $( "#get-scribe" ).val();
    
    if ( $scribeType == 0 ) {
        $( "#get-col_scribe select" ).val( "0" );
        $( "#get-col_scribe" ).show();
        $( "#scribe_search" ).val( "" );
        $( "#scribe_search" ).hide();
        $( ".label-scribes-one" ).show();
        $( ".label-scribes-two" ).hide();
    } else if ( $scribeType == 1 ) {
        $( "#scribe_search" ).val( "" );
        $( "#scribe_search" ).show();
        $( "#get-col_scribe" ).hide();
        $( "#get-col_scribe select" ).val( "0" );
        $( ".label-scribes-one" ).hide();
        $( ".label-scribes-two" ).show();
    }
}